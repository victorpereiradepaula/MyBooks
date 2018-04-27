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

    // Constantes
    let bookRegisterView = BookRegisterView()
    let notification = Notification()
    let book = Book()
    
    // Executa antes de exibir a view
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavibar()
        setupGestures()
        setupScrollView()
    }
    
    // Configura o navbar
    func setupNavibar() {
        navigationItem.title = "Cadastro de livro" // Define o título
        
        // Cria o botão de salvar
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: #selector(saveBook))
        
        // Define o botão de salvar como o botão direito do navbar
        self.navigationItem.setRightBarButton(saveButton, animated: true)
    }
    
    // Cria, configura e adiciona a scrollView, adiciona a bookRegisterView a esta
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
    
    // Função chamada pelo botão de salvar
    @objc func saveBook() {
        validateBookTitle()
    }
    
    // Modo FEIO de salvar, o processo de salvamento desta fica assíncrono desta forma
    // O problema era esperar as respostas do usuário para executar as ações (nas exceções)
    
    // Valida se há título (chave primária de livro)
    func validateBookTitle(){
        
        let title: String = bookRegisterView.titleText.text!
        if !title.isEmpty {
            
            let exists = BDHelper.existsBook(key: title)
            if exists {
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
    // Valida o tamanho da imagem
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
        } else {
            save()
        }
        // Para esse fluxo funcionar de forma síncrona, não pode haver códigos aqui
    }
    // Salva dados no banco
    func save() {
        let pages: String = bookRegisterView.pagesText.text!
        // Atribui valor ao campo de páginas apenas se houver valor
        if pages != "" {
            book.pages = Int(pages)!
        }
        
        let newNotification = Notification()
        let hasNotification = bookRegisterView.isNotificationEnabled()
        
        // Executa se existirem notificações
        if hasNotification {
            book.notificationIdentifier = book.title
            let datePicker = bookRegisterView.notificationView.datePicker
            let date = datePicker.date
            let components = Calendar.current.dateComponents([.hour, .minute], from: date)
            let hour = components.hour!
            let minute = components.minute!
            let identifier = "\(self.book.title)_Identifier"
            let weekDays = bookRegisterView.weekDays
            
            newNotification.setNotification(notificationIdentifier: identifier, hour: hour, minute: minute, weekDays: weekDays)
        }
        
        let newBook = Book()
        newBook.setValues(book: book)
        
        BDHelper.add(book: newBook, notification: newNotification)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // Executa funções responsáveis para atribuir valores aos campos da view
    func setBook(book: Book) {
        let notifications = BDHelper.getNotification(key: book.notificationIdentifier)
        
        if notifications.isEmpty {
            bookRegisterView.setValues(book: book) // Caso não existam notificações
        } else {
            bookRegisterView.setValues(book: book, notification: notifications[0]) // Caso existam notificações
        }
    }
}



extension BookRegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Ao clicar no botão cancelar, volta para a tela anterior
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    // Ao terminar a seleção da imagem, adiciona ela a imageView e volta para a tela anterior
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        bookRegisterView.cover.image = image
        dismiss(animated: true, completion: nil)
    }
    
    // Abre a galeria
    @objc func openPhotoLibrary(_ sender: UITapGestureRecognizer) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
}

// Adiciona gestureRecognizer a imageView (+) para que ao clicar a galeria seja aberta
extension BookRegisterViewController: UIGestureRecognizerDelegate {
    func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
        tapGestureRecognizer.delegate = self
        bookRegisterView.plusImage.addGestureRecognizer(tapGestureRecognizer)
    }
}
