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
        tableView.register(BooksListTableViewCell.self, forCellReuseIdentifier: "booksListCellIdentifier")
        let add = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(BooksListTableViewController.goToRegister))
        self.navigationItem.setRightBarButton(add, animated: true)
        
    }
    
    @objc func goToRegister() {
        self.navigationController?.pushViewController(BookRegisterViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.count ?? 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    func loadData() {
        books = []
        let realm = try! Realm()
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

}
