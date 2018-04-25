//
//  BooksListTableViewController.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit
import RealmSwift

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
    
        cell.titleText.text = books[index].title
        cell.pagesText.text = String(books[index].pages)
        let cover = books[index].cover
        cell.cover.image = UIImage(data: cover as Data)
        
        cell.separatorInset = UIEdgeInsets.zero
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let title = self.books[indexPath.row].title
        
        let details = UITableViewRowAction(style: .normal, title: "Detalhes") { action, index in
            self.navigationController?.pushViewController(BookRegisterViewController(), animated: true)
        }
        details.backgroundColor = .black
        
        let remove = UITableViewRowAction(style: .destructive, title: "Remover") { action, index in
            let setFavoriteAlert = UIAlertController(title: "Livro removido", message: "Livro removido com sucesso.", preferredStyle: .alert)
            setFavoriteAlert.addAction(UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
                
                self.tableView.isEditing = false
                
                let realm = try! Realm()
                realm.refresh()
                try! realm.write {
                    realm.delete(realm.object(ofType: Book.self, forPrimaryKey: title)!)
                }
                self.loadData()
                
                tableView.deleteRows(at: [index], with: .automatic)
                
            })
            
            self.present(setFavoriteAlert, animated: true, completion: nil)
            
        }
        return [remove, details]
    }

    func loadData() {
        books = []
        let realm = try! Realm()
        realm.refresh()
        books.append(contentsOf: realm.objects(Book.self))
        
        let textView: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = .center
            return label
        }()
        
        if books.count == 0 {
           textView.text = "Nenhum livro cadastrado"
        } else {
           textView.text = ""
        }
        self.tableView.tableFooterView = textView
    self.tableView.tableFooterView?.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
    self.tableView.tableFooterView?.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
    }
    
    @objc func goToRegister() {
        self.navigationController?.pushViewController(BookRegisterViewController(), animated: true)
    }
}
