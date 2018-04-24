//
//  BooksListTableViewCell.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

class BooksListTableViewCell: UITableViewCell {

    var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    let titleText: UILabel = {
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    let pagesText: UILabel = {
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        backgroundColor = .white
        
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
        
        
        addSubview(cover)
        addSubview(stackInfo)
        
        cover.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cover.heightAnchor.constraint(equalToConstant: 150).isActive = true
        cover.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        cover.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        stackLabels.widthAnchor.constraint(equalToConstant: 65).isActive = true
        stackInfo.topAnchor.constraint(equalTo: cover.topAnchor).isActive = true
        stackInfo.leftAnchor.constraint(equalTo: cover.rightAnchor, constant: 8).isActive = true
        stackInfo.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
