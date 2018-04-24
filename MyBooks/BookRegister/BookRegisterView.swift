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
    
    let domingo: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("D", for: UIControlState.normal)
        button.tintColor = .lightGray
        button.isEnabled = false
        return button
    }()
    let segunda: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("S", for: UIControlState.normal)
        button.tintColor = .lightGray
        button.isEnabled = false
        return button
    }()
    let terca: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("T", for: UIControlState.normal)
        button.tintColor = .lightGray
        button.isEnabled = false
        return button
    }()
    let quarta: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Q", for: UIControlState.normal)
        button.tintColor = .lightGray
        button.isEnabled = false
        return button
    }()
    let quinta: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Q", for: UIControlState.normal)
        button.tintColor = .lightGray
        button.isEnabled = false
        return button
    }()
    let sexta: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("S", for: UIControlState.normal)
        button.tintColor = .lightGray
        button.isEnabled = false
        return button
    }()
    let sabado: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("S", for: UIControlState.normal)
        button.tintColor = .lightGray
        button.isEnabled = false
        return button
    }()
    
    var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18.0)
        label.text = "Título:"
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
        label.font = .boldSystemFont(ofSize: 16.0)
        label.text = "Páginas:"
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
    
    let reminderActivator: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }()
    
    let timePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.minimumDate = Date()
        datePicker.isEnabled = false
        return datePicker
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Salvar", for: UIControlState.normal)
        return button
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
        
        let stackRepeatDays: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [domingo, segunda, terca, quarta, quinta, sexta, sabado, domingo])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 8
            return stackView
        }()
        
        addSubview(cover)
        addSubview(stackInfo)
        addSubview(stackReminder)
        addSubview(timePicker)
        addSubview(stackRepeatDays)
        addSubview(saveButton)
        
        cover.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cover.heightAnchor.constraint(equalToConstant: 150).isActive = true
        cover.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        cover.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        stackLabels.widthAnchor.constraint(equalToConstant: 65).isActive = true
        stackInfo.topAnchor.constraint(equalTo: cover.topAnchor).isActive = true
        stackInfo.leftAnchor.constraint(equalTo: cover.rightAnchor, constant: 8).isActive = true
        stackInfo.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        stackReminder.topAnchor.constraint(equalTo: cover.bottomAnchor, constant: 16).isActive = true
        stackReminder.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        stackReminder.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        timePicker.topAnchor.constraint(equalTo: stackReminder.bottomAnchor, constant: 8).isActive = true
        timePicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        timePicker.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        stackRepeatDays.topAnchor.constraint(equalTo: timePicker.bottomAnchor, constant: 16).isActive = true
        stackRepeatDays.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: stackRepeatDays.bottomAnchor, constant: 16).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    @objc func setReminderVisibility() {
        reminderIsVisible = !reminderIsVisible
        timePicker.isEnabled = reminderIsVisible
        domingo.isEnabled = reminderIsVisible
        segunda.isEnabled = reminderIsVisible
        terca.isEnabled = reminderIsVisible
        quarta.isEnabled = reminderIsVisible
        quinta.isEnabled = reminderIsVisible
        sexta.isEnabled = reminderIsVisible
        sabado.isEnabled = reminderIsVisible
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
