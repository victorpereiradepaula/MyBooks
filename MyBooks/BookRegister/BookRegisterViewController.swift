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
        setupNavibar()
        setupGestures()
        setupScrollView()
    }
    
    func setupNavibar() {
        navigationItem.title = "Cadastro de livro"
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(saveBook))
        self.navigationItem.setRightBarButton(saveButton, animated: true)
    }
    
    func setupScrollView() {
        bookRegisterView.frame = view.frame
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 60))
        scrollView.backgroundColor = .white
        scrollView.isPagingEnabled = true
        scrollView.contentSize = view.bounds.size
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.scrollableAxes
        scrollView.addSubview(bookRegisterView)
        view.addSubview(scrollView)
    }
    
    @objc func saveBook() {
        validateBookTitle()
    }
    
    
    func validateBookTitle(){
        let title: String = bookRegisterView.titleText.text!
        if title != "" {
            let realm = try! Realm()
            realm.refresh()
            let sameBook = realm.objects(Book.self).filter("title == '\(title)'")
            if sameBook.count == 1 {
                let alertView = UIAlertController(title: "Livro já cadastrado", message: "Deseja substituir sobreescrever os dados existentes?", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
                    return
                }))
                alertView.addAction(UIAlertAction(title: "Sim", style: .destructive, handler: { (action) in
                    self.book.title = title
                    self.validateBookImage()
                }))
                present(alertView, animated: true, completion: nil)
                return
            }
            book.title = title
            self.validateBookImage()
        } else {
            let alertView = UIAlertController(title: "Título não informado", message: "Insira o título do livro antes de salvar", preferredStyle: .alert)
            present(alertView, animated: true, completion: nil)
            alertView.addAction(UIAlertAction(title: "OK", style: .default))
        }
    }
    
    func validateBookImage() {
        let image = bookRegisterView.cover.image
        if image != nil {
            let imageData: NSData = UIImagePNGRepresentation(image!)! as NSData
            if imageData.length > INT_16MB {
                bookRegisterView.cover.image = nil
                let alertView = UIAlertController(title: "Imagem muito grande", message: "Deseja salvar sem uma imagem?", preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) in
                    return
                }))
                alertView.addAction(UIAlertAction(title: "Sim", style: .destructive, handler: { (action) in
                    self.book.cover = NSData()
                    self.save()
                }))
                present(alertView, animated: true, completion: nil)
                return
            }
            book.cover = imageData
            save()
        }
        save()
    }
    
    func save() {
        let pages: String = bookRegisterView.pagesText.text!
        if pages != "" {
            book.pages = Int(pages)!
        }
        
        let newBook = Book()
        newBook.setValues(title: book.title, pages: book.pages, cover: book.cover)
        
        if bookRegisterView.isEnabledNotification {
            let datePicker = bookRegisterView.notificationView.datePicker
            let timeInterval: TimeInterval
            if datePicker.date.timeIntervalSince1970 < Date().timeIntervalSince1970 {
                timeInterval = ONE_DAY + datePicker.date.timeIntervalSince1970
                print(timeInterval)
            } else {
                timeInterval = bookRegisterView.notificationView.datePicker.date.timeIntervalSince(Date())
                print(timeInterval)
            }
            
            let identifier = "\(self.book.title)_Identifier"
            let repeats = bookRegisterView.isEnabledRepeat
            newBook.setNotification(notificationIdentifier: identifier, timeInterval: timeInterval, repeatDay: repeats,repeatDomingo: bookRegisterView.isDomingo, repeatSegunda: bookRegisterView.isSegunda, repeatTerca: bookRegisterView.isTerca, repeatQuarta: bookRegisterView.isQuarta, repeatQuinta: bookRegisterView.isQuinta, repeatSexta: bookRegisterView.isSexta, repeatSabado: bookRegisterView.isSabado)
            createNotifications(identifier: identifier, inSeconds: timeInterval, repeats: repeats, completion: { (success) in })
        }
        
        let realm = try! Realm()
        realm.refresh()
        try! realm.write {
            realm.add(newBook, update: true)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func createNotifications(identifier: String, inSeconds: TimeInterval, repeats: Bool, completion: @escaping (_ Success: Bool) -> ()) {
        
        if repeats {
//            let triggerWeekly = Calendar.current.dateComponents([.weekday,.hour,.minute,.second], from: date)
            
//            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
        } else {
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: repeats)
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: repeats)
        
        
        let content = UNMutableNotificationContent()
        content.title = "Hora de ler \(self.book.title)"
        content.body = "Acesse o MyBooks e confira seus livros."
        content.sound = UNNotificationSound.default()
        
        let notification = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(notification) { (error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func setBook(book: Book) {
        bookRegisterView.setValues(book: book)
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

// Extension para separar 
extension BookRegisterViewController: UIGestureRecognizerDelegate {
    func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
        tapGestureRecognizer.delegate = self
        bookRegisterView.plusImage.addGestureRecognizer(tapGestureRecognizer)
    }
}
