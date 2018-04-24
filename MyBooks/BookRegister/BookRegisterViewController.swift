//
//  BookRegisterViewController.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

class BookRegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    let bookRegisterView = BookRegisterView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cadastro de livro"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(openPhotoLibrary))
        tap.delegate = self
        bookRegisterView.cover.addGestureRecognizer(tap)
        
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
}

