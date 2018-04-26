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

    var books: [Book]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Livros"
        
        let add = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(goToRegister))
        self.navigationItem.setRightBarButton(add, animated: true)
        
        tableView.register(BooksListTableViewCell.self, forCellReuseIdentifier: "booksCellIdentifier")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksCellIdentifier", for: indexPath) as! BooksListTableViewCell
        
        let index = indexPath.row
        let book = books[index]
        
        cell.titleText.text = book.title
        cell.pagesText.text = String(book.pages)
        let cover = book.cover
        cell.cover.image = UIImage(data: cover as Data)
        let isNotification = !(book.notificationIdentifier != "")
        cell.clock.isHidden = isNotification
        cell.clockText.isHidden = isNotification
        if isNotification {
            let date = Date(timeIntervalSince1970: book.timeInterval)
            let dateFormater = DateFormatter()
            dateFormater.setLocalizedDateFormatFromTemplate("HH:MM")
            cell.clockText.text = dateFormater.string(from: date)
        }
        cell.separatorInset = UIEdgeInsets.zero
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let newBookRegisterViewController = BookRegisterViewController()
        newBookRegisterViewController.setBook(book: self.books[index])
        self.navigationController?.pushViewController(newBookRegisterViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let book = self.books[indexPath.row]
        
        let remove = UITableViewRowAction(style: .destructive, title: "Remover") { action, index in
            
                self.tableView.isEditing = false
            
                BDHelper.remove(book: book)
                self.loadData()
                tableView.deleteRows(at: [index], with: .automatic)
            
                self.tableView.isEditing = true
            
        }
        return [remove]
    }

    func loadData() {
        books = BDHelper.getBooks()
        
        
        let messageLabel: UILabel = {
            let view = UILabel()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.textAlignment = .center
            return view
        }()
        
        if books.isEmpty {
           messageLabel.text = "Nenhum livro cadastrado"
        } else {
           messageLabel.text = ""
        }
        self.tableView.tableFooterView = messageLabel
        self.tableView.tableFooterView?.center(tableView)
    }
    
    @objc func goToRegister() {
        self.navigationController?.pushViewController(BookRegisterViewController(), animated: true)
    }
}
