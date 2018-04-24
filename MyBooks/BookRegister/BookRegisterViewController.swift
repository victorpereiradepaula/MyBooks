//
//  BookRegisterViewController.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit
import RealmSwift

class BookRegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    let bookRegisterView = BookRegisterView()
    let book = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cadastro de livro"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
        tap.delegate = self
        bookRegisterView.cover.addGestureRecognizer(tap)
        
        bookRegisterView.saveButton.addTarget(self, action: #selector(saveBook), for: .touchUpInside)
        
        bookRegisterView.frame = view.frame
        view.addSubview(bookRegisterView)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        bookRegisterView.cover.image = image
        dismiss(animated: true, completion: nil)
    }
    
    @objc func openPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    @objc func saveBook() {
        
        let title: String = bookRegisterView.titleText.text!
        if title != "" {
            book.title = title
        } else {
            let alertView = UIAlertController(title: "Título não informado", message: "Insira o título do livro antes de salvar", preferredStyle: .alert)
            present(alertView, animated: true, completion: nil)
            alertView.addAction(UIAlertAction(title: "OK", style: .default))
            return
        }
        
        let pages: String = bookRegisterView.pagesText.text!
        if pages != "" {
            book.pages = Int(pages)!
        }
        
        if bookRegisterView.cover.subviews.count != 0 {
            let imageData: Data = UIImagePNGRepresentation(bookRegisterView.cover.image!)!
            book.cover = imageData as NSData
        }
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(book, update: true)
        }
    }
}

