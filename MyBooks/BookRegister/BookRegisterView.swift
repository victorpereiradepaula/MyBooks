//
//  BookRegisterView.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

class BookRegisterView: UIView {

    var isEnabledNotification = false
    var isEnabledRepeat = false
    var isDomingo = false
    var isSegunda = false
    var isTerca = false
    var isQuarta = false
    var isQuinta = false
    var isSexta = false
    var isSabado = false
    
    var cover: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = DEFAULT_GRAY
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 3
        view.layer.borderWidth = 1
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
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: DEFAULT_FONT_SIZE)
        view.text = "Título:"
        view.sizeToFit()
        return view
    }()
    
    let titleText: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        return view
    }()
    
    let pagesLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: SMALL_FONT_SIZE)
        view.text = "Páginas:"
        view.sizeToFit()
        return view
    }()
    
    let pagesText: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.keyboardType = .numberPad
        view.borderStyle = .roundedRect
        return view
    }()
    
    let notificationView = NotificationView()
    
    let repeatView = RepeatView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .vertical
            view.spacing = NEAR
            return view
        }()
        
        let stackText: UIStackView = {
            let view = UIStackView(arrangedSubviews: [titleText, pagesText])
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .vertical
            view.spacing = FAR
            return view
        }()
        
        let stackInfo: UIStackView = {
            let view = UIStackView(arrangedSubviews: [stackLabels, stackText])
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .horizontal
            view.spacing = NEAR
            return view
        }()
        
        cover.addSubview(plusImage)
        addSubview(cover)
        addSubview(stackInfo)
        addSubview(notificationView)
        addSubview(repeatView)
        
        cover.setSize(width: magicWidth, height: magicHeight)
        cover.setAnchors(topAnchor: self.topAnchor, FAR, leftAnchor: self.leftAnchor, FAR)
        plusImage.setSize(width: 40, height: 40)
        plusImage.setAnchors(topAnchor: cover.topAnchor, 4, rightAnchor: cover.rightAnchor, -4)
        stackLabels.setWidth(magicLabelWidth)
        stackInfo.setAnchors(topAnchor: cover.topAnchor, leftAnchor: cover.rightAnchor, NEAR, rightAnchor: self.rightAnchor, NEGATIVE_FAR)
        notificationView.setAnchors(topAnchor: cover.bottomAnchor, FAR, leftAnchor: self.leftAnchor, FAR, rightAnchor: self.rightAnchor, NEGATIVE_FAR)
        repeatView.setAnchors(topAnchor: notificationView.bottomAnchor, FAR, leftAnchor: self.leftAnchor, FAR, rightAnchor: self.rightAnchor, NEGATIVE_FAR)
        
    }
    
    @objc func enableNotification() {
        isEnabledNotification = !isEnabledNotification
        notificationView.enableNotification()
        repeatView.enableHeader()
    }
    
    @objc func enableDays() {
        repeatView.enableDays()
    }
    
    @objc func repeatDomingo() {
        isDomingo = !isDomingo
        repeatView.domingo.setColor(status: isDomingo)
    }
    @objc func repeatSegunda() {
        isSegunda = !isSegunda
        repeatView.segunda.setColor(status: isSegunda)
    }
    @objc func repeatTerca() {
        isTerca = !isTerca
        repeatView.terca.setColor(status: isTerca)
    }
    @objc func repeatQuarta() {
        isQuarta = !isQuarta
        repeatView.quarta.setColor(status: isQuarta)
    }
    @objc func repeatQuinta() {
        isQuinta = !isQuinta
        repeatView.quinta.setColor(status: isQuinta)
    }
    @objc func repeatSexta() {
        isSexta = !isSexta
        repeatView.sexta.setColor(status: isSexta)
    }
    @objc func repeatSabado() {
        isSabado = !isSabado
        repeatView.sabado.setColor(status: isSabado)
    }
    
    func setValues(book: Book) {
        pagesText.text = String(book.pages)
        cover.image = UIImage(data: book.cover as Data)
        titleText.text = book.title
        let notification = book.notificationIdentifier
        if notification != "" {
            notificationView.isEnabledNotification = true
            notificationView.datePicker.setDate(Date(timeIntervalSince1970: book.timeInterval), animated: false)
            notificationView.enableNotification()
            if book.repeatDay {
                repeatView.enableHeader()
                repeatView.repeatSwitch.isOn = true
                repeatView.enableDays()
                
                if book.repeatDomingo {
                 repeatDomingo()
                }
                if book.repeatSegunda {
                    repeatSegunda()
                }
                if book.repeatTerca {
                    repeatTerca()
                }
                if book.repeatQuarta {
                    repeatQuarta()
                }
                if book.repeatQuinta {
                    repeatQuinta()
                }
                if book.repeatSexta {
                    repeatSexta()
                }
                if book.repeatSabado {
                    repeatSabado()
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
