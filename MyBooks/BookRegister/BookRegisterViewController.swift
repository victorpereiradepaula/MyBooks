//
//  BookRegisterViewController.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class BookRegisterViewController: UIViewController {

    let bookRegisterView = BookRegisterView()
    let book = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cadastro de livro"
        
        setGestures()
        
        bookRegisterView.saveButton.addTarget(self, action: #selector(saveBook), for: .touchUpInside)
        
        bookRegisterView.frame = view.frame
        view.addSubview(bookRegisterView)
    }
    
    
    @objc func saveBook() {
        
        let realm = try! Realm()
        realm.refresh()
        
        let title: String = bookRegisterView.titleText.text!
        if title != "" {
            
            let sameBook = realm.objects(Book.self).filter("title == '\(title)'")
            if sameBook.count == 1 {
                let alertView = UIAlertController(title: "Livro já cadastrado", message: "Deseja substituir sobreescrever os dados existentes?", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
                    return
                }))
                alertView.addAction(UIAlertAction(title: "Sim", style: .destructive))
                present(alertView, animated: true, completion: nil)
                
            }
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
        
        let image = bookRegisterView.cover.image
        if image != nil {
            let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
            if imageData.length > 16000000 {
                bookRegisterView.cover.image = nil
                let alertView = UIAlertController(title: "Imagem muito grande", message: "Insira uma imagem menor", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "OK", style: .default))
                present(alertView, animated: true, completion: nil)
                return
            } else {
                book.cover = imageData
            }
        }
        
        try! realm.write {
            realm.add(book, update: true)
        }
        
        if bookRegisterView.reminderIsVisible {
            let date = bookRegisterView.timePicker.date.timeIntervalSince(Date())
            createNotifications(inSeconds: date, completion: { (success) in })
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func createNotifications(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: bookRegisterView.repeatIsVisible)
        
        let content = UNMutableNotificationContent()
        content.title = self.book.title
        content.body = "Acesse o MyBooks e confira seus livros."
        content.sound = UNNotificationSound.default()
        
        let notification = UNNotificationRequest(identifier: "myBooksNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(notification) { (error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}

extension BookRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    
}


extension BookRegisterViewController: UIGestureRecognizerDelegate {
    func setGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
        tapGestureRecognizer.delegate = self
        bookRegisterView.cover.addGestureRecognizer(tapGestureRecognizer)
    }
}
