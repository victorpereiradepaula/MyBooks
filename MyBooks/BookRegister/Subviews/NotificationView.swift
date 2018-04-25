//
//  NotificationView.swift
//  MyBooks
//
//  Created by Victor Pereira on 25/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

class NotificationView: UIView {

    var isEnabledNotification = false
    
    let notificationLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: DEFAULT_FONT_SIZE)
        view.text = "Cadastrar lembrete:"
        view.sizeToFit()
        return view
    }()
    
    let notificationSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let datePicker: UIDatePicker = {
        let view = UIDatePicker()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.datePickerMode = .time
        view.isEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        
        let stackHeader: UIStackView = {
            let view = UIStackView(arrangedSubviews: [notificationLabel, notificationSwitch])
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isUserInteractionEnabled = true
            view.axis = .horizontal
            view.spacing = NEAR
            return view
        }()
        
        let stackNotification: UIStackView = {
            let view = UIStackView(arrangedSubviews: [stackHeader, datePicker])
            view.translatesAutoresizingMaskIntoConstraints = false
            view.isUserInteractionEnabled = true
            view.axis = .vertical
            view.spacing = NEAR
            return view
        }()
        
        addSubview(stackNotification)

        stackNotification.setAnchors(topAnchor: self.topAnchor,leftAnchor: self.leftAnchor, rightAnchor: self.rightAnchor)
        datePicker.setAnchors(leftAnchor: self.leftAnchor, rightAnchor: self.rightAnchor)
        self.setEqualsConstraints(stackNotification)
        
    }
    
    func enableNotification() {
        isEnabledNotification = !isEnabledNotification
        datePicker.isEnabled = isEnabledNotification
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
