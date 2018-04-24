//
//  BookRegisterView.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

class BookRegisterView: UIView {

    var reminderIsVisible = false
    var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title:"
        label.sizeToFit()
        return label
    }()
    
    let titleText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let pagesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pages:"
        label.sizeToFit()
        return label
    }()
    
    let pagesText: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let reminderActivatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cadastrar lembrete:"
        label.sizeToFit()
        return label
    }()
    
    var reminderActivator: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()
    
    var timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.isEnabled = false
        return datePicker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        reminderActivator.addTarget(self, action: #selector(BookRegisterView.setReminderVisibility), for: .valueChanged)
        
        let stackLabels: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, pagesLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 8
            return stackView
        }()
        
        let stackText: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleText, pagesText])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 15
            return stackView
        }()
        
        let stackInfo: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [stackLabels, stackText])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 8
            return stackView
        }()
        
        let stackReminder: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [reminderActivatorLabel, reminderActivator])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 8
            return stackView
        }()
        
        addSubview(cover)
        addSubview(stackInfo)
        addSubview(stackReminder)
        addSubview(timePicker)
        cover.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cover.heightAnchor.constraint(equalToConstant: 150).isActive = true
        cover.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        cover.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        stackLabels.widthAnchor.constraint(equalToConstant: 60).isActive = true
        stackInfo.topAnchor.constraint(equalTo: cover.topAnchor).isActive = true
        stackInfo.leftAnchor.constraint(equalTo: cover.rightAnchor, constant: 8).isActive = true
        stackInfo.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        stackReminder.topAnchor.constraint(equalTo: cover.bottomAnchor, constant: 16).isActive = true
        stackReminder.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        stackReminder.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        timePicker.topAnchor.constraint(equalTo: stackReminder.bottomAnchor, constant: 8).isActive = true
        timePicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        timePicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
    }
    
    @objc func setReminderVisibility() {
        reminderIsVisible = !reminderIsVisible
        timePicker.isEnabled = reminderIsVisible
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
