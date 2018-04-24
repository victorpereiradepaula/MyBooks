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
    
    func createNotifications(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = "body"
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
        
        let realm = try! Realm()
        
        let title: String = bookRegisterView.titleText.text!
        if title != "" {
            
//            try! let sameBook = realm.objects(Book.self).filter("tile == \(title)")
//            if sameBook.count != 0 {
//                let alertView = UIAlertController(title: "Livro já cadastrado", message: "Deseja substituir sobreescrever os dados existentes?", preferredStyle: .actionSheet)
//                alertView.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
//                    return
//                }))
//                alertView.addAction(UIAlertAction(title: "Sim", style: .destructive))
//            }
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
                present(alertView, animated: true, completion: nil)
                alertView.addAction(UIAlertAction(title: "OK", style: .default))
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
            print(date)
            createNotifications(inSeconds: date, completion: { (success) in })
        }
    }
}
