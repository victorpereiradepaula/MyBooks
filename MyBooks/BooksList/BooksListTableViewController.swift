//
//  BooksListTableViewController.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class BooksListTableViewController: UITableViewController {

    var books: [Book]! // Garante que o objeto será inicializado antes de ser utilizado
    
    // Cria um vetor de ações para a célula
    func createActions(indexPath: IndexPath) -> [UITableViewRowAction] {
        let index = indexPath.row
        let book = self.books[index]
        
        // Cria a ação
        let remove = UITableViewRowAction(style: .destructive, title: "Remover") { action, index in
            
            self.tableView.isEditing = false // Impede que o usuário interaja com a tabeView
            
            BDHelper.remove(book: book)
            self.loadData() // Devido as alterações dos dados, é necessário carrega-los novamente
            self.tableView.deleteRows(at: [index], with: .automatic) // Remove a célula da tableView
            
            self.tableView.isEditing = true // Permite que o usuário interaja novamente com a tableView
        }
        return [remove]
    }

    // Carrega os dados
    func loadData() {
        books = BDHelper.getBooks()
        setupTableFooter()
    }
    
    // Cria, configura e retorna uma célula
    func createCell(indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksCellIdentifier", for: indexPath) as! BooksListTableViewCell
        
        let index = indexPath.row
        let book = books[index] // Atribui o livro referente à célula selecionada
        
        cell.titleText.text = book.title
        
        let pages = book.pages
        // Atribui valor ao campo apenas se for diferente de 0
        if pages != 0 {
            cell.pagesText.text = String(pages)
        }

        let cover = book.cover
        cell.cover.image = UIImage(data: cover as Data) // Necessário o casting de NSData para Data
        
        let hasNotification = book.hasNotification()
        
        // Executa se houverem notificações
        if hasNotification {
            
            // Torna as subviews visíveis
            cell.clock.isHidden = !hasNotification
            cell.clockText.isHidden = !hasNotification
            
            let notifications = BDHelper.getNotification(key: book.notificationIdentifier)
            let notification = notifications[0]
            
            let hour = String(notification.hour)
            let minute = String(notification.minute)
            let dateText = "\(hour):\(minute)"
            cell.clockText.text = dateText
        }
        
        cell.separatorInset = UIEdgeInsets.zero // Seta as bordas do separador junto as bordas da view
        
        return cell
    }
    
    // Configura o footer da tableView
    func setupTableFooter() {
        let messageLabel: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .center
            return view
        }()
        
        // Se não existirem livros, atribui um texto
        if books.isEmpty {
            messageLabel.text = "Nenhum livro cadastrado"
        } else {
            messageLabel.text = ""
        }
        self.tableView.tableFooterView = messageLabel
        self.tableView.tableFooterView?.center(tableView)
    }
    
    // Seta as configurações iniciais da barra de navegação
    func setupNavigationBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(goToBookRegisterViewController))
        self.navigationItem.setRightBarButton(addButton, animated: true)
        navigationItem.title = "Livros"
    }
    
    // Cria e traz para frente uma BookRegisterViewController
    @objc func goToBookRegisterViewController() {
        self.navigationController?.pushViewController(BookRegisterViewController(), animated: true)
    }
}

// Apenas para separar os overrides
extension BooksListTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        // Registra a classe que será utilizada na criação de células
        tableView.register(BooksListTableViewCell.self, forCellReuseIdentifier: "booksCellIdentifier")
    }
    
    // Executa antes da view ser exibida
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    // Retorna o numero de linhas
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    // Retorna a altura das células
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
    
    // Retorna se as células são "editáveis"
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Retorna uma célula
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createCell(indexPath: indexPath)
    }
    
    // Executa ação quando uma célula é selecionada
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let newBookRegisterViewController = BookRegisterViewController()
        newBookRegisterViewController.setBook(book: self.books[index])
        self.navigationController?.pushViewController(newBookRegisterViewController, animated: true)
    }
    
    // Retorna um vetor com de ações (swipe)
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        return createActions(indexPath: indexPath)
    }
}
