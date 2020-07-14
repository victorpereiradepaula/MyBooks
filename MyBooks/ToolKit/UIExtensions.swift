//
//  Extensions.swift
//  MyBooks
//
//  Created by Victor Pereira on 25/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

// Criação de funções para atribição de valores default para views

extension UIButton {
    func setColor(status: Bool) {
        
        // true (ativado) | false (desativado)
        if status {
            self.tintColor = .white
            self.backgroundColor = GREEN
            self.layer.borderColor = GREEN.cgColor
        } else {
            self.tintColor = .lightGray
            self.backgroundColor = .white
            self.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func setDefaults(title: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.setTitle(title, for: UIControl.State.normal)
        self.layer.cornerRadius = CORNER_RADIUS
        self.layer.borderWidth = BORDER_WIDTH
        self.tintColor = .lightGray
        self.isEnabled = false
    }
}

extension UILabel {
    func setDefaults(text: String) {
        self.font = .boldSystemFont(ofSize: DEFAULT_FONT_SIZE)
        self.setDefaults()
        self.text = text
    }
   
    func setSmall(text: String) {
        self.font = .boldSystemFont(ofSize: SMALL_FONT_SIZE)
        self.setDefaults()
        self.text = text
    }
    
    private func setDefaults() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.sizeToFit()
    }
}

extension UITextField {
    func setDefaults(keyboard: UIKeyboardType) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.borderStyle = .roundedRect
        self.keyboardType = keyboard
    }
}

extension UIDatePicker {
    func setDefaults() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.datePickerMode = .time
        self.isEnabled = false
    }
}

extension UISwitch  {
    func setDefaults(enabled: Bool = false) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.onTintColor = GREEN
        self.isEnabled = enabled
    }
}

extension UIStackView {
    func setDefaults(axis: NSLayoutConstraint.Axis, spacing: CGFloat = NEAR) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
    }
}

extension UIImageView {
    func setDefaults() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.isUserInteractionEnabled = true
        self.backgroundColor = GRAY
        self.layer.cornerRadius = CORNER_RADIUS
        self.layer.borderWidth = BORDER_WIDTH
    }
}
