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
    
    var cover: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = .lightGray
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
        view.borderStyle = .roundedRect
        return view
    }()
    
    let notificationView = NotificationView()
    
    let repeatView = RepeatView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        notificationView.notificationSwitch.addTarget(self, action: #selector(enableNotification), for: .valueChanged)
        
        repeatView.repeatSwitch.addTarget(self, action: #selector(enableDays), for: .valueChanged)
        
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
        
        addSubview(cover)
        addSubview(stackInfo)
        addSubview(notificationView)
        addSubview(repeatView)
        
        cover.setSize(width: magicWidth, height: magicHeight)
        cover.setAnchors(topAnchor: self.topAnchor, FAR, leftAnchor: self.leftAnchor, FAR)
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
    
    func setValues(book: Book) {
        pagesText.text = String(book.pages)
        cover.image = UIImage(data: book.cover as Data)
        titleText.text = book.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
