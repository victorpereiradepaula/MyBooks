//
//  NotificationView.swift
//  MyBooks
//
//  Created by Victor Pereira on 25/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

class NotificationView: UIView {
    
    let notificationLabel: UILabel = {
        let view = UILabel()
        view.setDefaults(text: "Cadastrar lembrete:")
        return view
    }()
    
    // Botão para habilitar ou desabilitar notificações
    let notificationSwitch: UISwitch = {
        let view = UISwitch()
        view.setDefaults(enabled: true)
        return view
    }()
    
    // Seletor de horário
    let datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.setDefaults()
        return view
    }()
    
    // Construtor
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true // Habilita a interação do usuário
        
        // Criação de stacks
        let stackHeader: UIStackView = {
            let view = UIStackView(arrangedSubviews: [notificationLabel, notificationSwitch])
            view.setDefaults(axis: .horizontal)
            return view
        }()
        let stackNotification: UIStackView = {
            let view = UIStackView(arrangedSubviews: [stackHeader, datePicker])
            view.setDefaults(axis: .vertical)
            return view
        }()
        
        // Adiciona subviews a view
        addSubview(stackNotification)

        // Defineção das constraints
        stackNotification.setAnchors(topAnchor: self.topAnchor,leftAnchor: self.leftAnchor, rightAnchor: self.rightAnchor)
        datePicker.setAnchors(leftAnchor: self.leftAnchor, rightAnchor: self.rightAnchor)
        self.setEqualsConstraints(stackNotification)
        
    }
    
    // Habilita e desabilita o datePicker
    func enableDatePicker() {
        datePicker.isEnabled = notificationSwitch.isOn
    }
    
    // Obrigatório quando sobrescrevemos o init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
