//
//  BookRegisterView.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

class BookRegisterView: UIView {

    var weekDays = [false, false, false, false, false, false, false]
    
    var cover: UIImageView = {
        let view = UIImageView()
        view.setDefaults()
        return view
    }()
    
    let plusImage: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.image = #imageLiteral(resourceName: "plus")
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.setDefaults(text: "Título:")
        return view
    }()
    
    let titleText: UITextField = {
        let view = UITextField()
        view.setDefaults(keyboard: .default)
        return view
    }()
    
    let pagesLabel: UILabel = {
        let view = UILabel()
        view.setSmall(text: "Páginas:")
        return view
    }()
    
    let pagesText: UITextField = {
        let view = UITextField()
        view.setDefaults(keyboard: .numberPad)
        return view
    }()
    
    let notificationView = NotificationView()
    
    let repeatView = RepeatView()
    
    // Construtor
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleText.delegate = self
        pagesText.delegate = self
        backgroundColor = .white
        
        repeatView.translatesAutoresizingMaskIntoConstraints = false
        notificationView.translatesAutoresizingMaskIntoConstraints = false
        
        notificationView.notificationSwitch.addTarget(self, action: #selector(enableNotification), for: .valueChanged)
        
        repeatView.repeatSwitch.addTarget(self, action: #selector(enableDays), for: .valueChanged)
        
        repeatView.domingo.addTarget(self, action: #selector(repeatDomingo), for: .touchUpInside)
        repeatView.segunda.addTarget(self, action: #selector(repeatSegunda), for: .touchUpInside)
        repeatView.terca.addTarget(self, action: #selector(repeatTerca), for: .touchUpInside)
        repeatView.quarta.addTarget(self, action: #selector(repeatQuarta), for: .touchUpInside)
        repeatView.quinta.addTarget(self, action: #selector(repeatQuinta), for: .touchUpInside)
        repeatView.sexta.addTarget(self, action: #selector(repeatSexta), for: .touchUpInside)
        repeatView.sabado.addTarget(self, action: #selector(repeatSabado), for: .touchUpInside)
        
        let stackLabels: UIStackView = {
            let view = UIStackView(arrangedSubviews: [titleLabel, pagesLabel])
            view.setDefaults(axis: .vertical)
            return view
        }()
        
        let stackText: UIStackView = {
            let view = UIStackView(arrangedSubviews: [titleText, pagesText])
            view.setDefaults(axis: .vertical, spacing: FAR)
            return view
        }()
        
        let stackInfo: UIStackView = {
            let view = UIStackView(arrangedSubviews: [stackLabels, stackText])
            view.setDefaults(axis: .horizontal)
            return view
        }()
        
        cover.addSubview(plusImage)
        addSubview(cover)
        addSubview(stackInfo)
        addSubview(notificationView)
        addSubview(repeatView)
        
        cover.setSize(width: IMAGE_WIDTH, height: IMAGE_HEIGHT)
        cover.setAnchors(topAnchor: self.topAnchor, FAR, leftAnchor: self.leftAnchor, FAR)
        plusImage.setSize(width: 40, height: 40)
        plusImage.setAnchors(topAnchor: cover.topAnchor, 4, rightAnchor: cover.rightAnchor, -4)
        stackLabels.setWidth(magicLabelWidth)
        stackInfo.setAnchors(topAnchor: cover.topAnchor, leftAnchor: cover.rightAnchor, NEAR, rightAnchor: self.rightAnchor, NEGATIVE_FAR)
        notificationView.setAnchors(topAnchor: cover.bottomAnchor, FAR, leftAnchor: self.leftAnchor, FAR, rightAnchor: self.rightAnchor, NEGATIVE_FAR)
        repeatView.setAnchors(topAnchor: notificationView.bottomAnchor, FAR, leftAnchor: self.leftAnchor, FAR, rightAnchor: self.rightAnchor, NEGATIVE_FAR)
        
    }
    
    func isNotificationEnabled() -> Bool {
        return notificationView.notificationSwitch.isOn
    }
    
    func isRepeatEnabled() -> Bool {
        return repeatView.repeatSwitch.isOn
    }
    
    @objc func enableNotification() {
        notificationView.enableNotification()
        let isEnabled = isNotificationEnabled()
        repeatView.enableHeader(isEnabled: isEnabled)
    }
    
    @objc func enableDays() {
        repeatView.enableDays()
    }
    
    @objc func repeatDomingo() {
        weekDays[0] = !weekDays[0]
        repeatView.domingo.setColor(status: weekDays[0])
    }
    @objc func repeatSegunda() {
        weekDays[1] = !weekDays[1]
        repeatView.segunda.setColor(status: weekDays[1])
    }
    @objc func repeatTerca() {
        weekDays[2] = !weekDays[2]
        repeatView.terca.setColor(status: weekDays[2])
    }
    @objc func repeatQuarta() {
        weekDays[3] = !weekDays[3]
        repeatView.quarta.setColor(status: weekDays[3])
    }
    @objc func repeatQuinta() {
        weekDays[4] = !weekDays[4]
        repeatView.quinta.setColor(status: weekDays[4])
    }
    @objc func repeatSexta() {
        weekDays[5] = !weekDays[5]
        repeatView.sexta.setColor(status: weekDays[5])
    }
    @objc func repeatSabado() {
        weekDays[6] = !weekDays[6]
        repeatView.sabado.setColor(status: weekDays[6])
    }
    
    func setValues(book: Book) {
        pagesText.text = String(book.pages)
        cover.image = UIImage(data: book.cover as Data)
        titleText.text = book.title
    }
    
    func setValues(book: Book, notification: MyNotification) {

        setValues(book: book)
    
        if book.hasNotification() {
            let hour = notification.hour
            let minute = notification.minute
            var dateComponents = DateComponents()
            dateComponents.hour = hour
            dateComponents.minute = minute
            dateComponents.calendar = Calendar.current
            
            notificationView.notificationSwitch.isOn = true
            enableNotification()
            let newDate = dateComponents.date!
            notificationView.datePicker.setDate(newDate, animated: false)
            
            if notification.repeatDay {
                repeatView.enableDays()
                
                if notification.domingo {
                 repeatDomingo()
                }
                if notification.segunda {
                    repeatSegunda()
                }
                if notification.terca {
                    repeatTerca()
                }
                if notification.quarta {
                    repeatQuarta()
                }
                if notification.quinta {
                    repeatQuinta()
                }
                if notification.sexta {
                    repeatSexta()
                }
                if notification.sabado {
                    repeatSabado()
                }
            }
        }
    }
    
    // Obrigatório quando sobrescrevemos o init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// Esconder o teclado e delimitar caracteres dos textFields
extension BookRegisterView: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleText {
            pagesText.becomeFirstResponder()
        } else if textField == pagesText {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == pagesText {
            let length = textField.text?.count
            return length! < 5
        }
        return true
    }

}
