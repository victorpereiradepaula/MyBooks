//
//  BooksListTableViewCell.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

class BooksListTableViewCell: UITableViewCell {
    
    // Criação das subviews
    var cover: UIImageView = {
        let view = UIImageView()
        view.setDefaults()
        return view
    }()
    lazy var clock: UIImageView =  {
        let view = UIImageView(image: UIImage(imageLiteralResourceName: "clock"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    let titleLabel: UILabel = {
        let view = UILabel()
        view.setDefaults(text: "Título:")
        return view
    }()
    let pagesLabel: UILabel = {
        let view = UILabel()
        view.setSmall(text: "Páginas:")
        return view
    }()
    let titleText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let pagesText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var clockText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    // Construtor
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Criação de stacks
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
        
        // Adiciona subviews na view
        addSubview(cover)
        addSubview(stackInfo)
        addSubview(clock)
        addSubview(clockText)
        
        // Definição das constraints
        cover.setSize(width: IMAGE_WIDTH, height: IMAGE_HEIGHT)
        cover.setAnchors(topAnchor: self.topAnchor, FAR, leftAnchor: self.leftAnchor, FAR)
        stackLabels.setWidth(magicLabelWidth)
        stackInfo.setAnchors(topAnchor: cover.topAnchor, leftAnchor: cover.rightAnchor, NEAR, rightAnchor: self.rightAnchor, NEGATIVE_FAR)
        clock.setAnchors(topAnchor: stackInfo.bottomAnchor, 35, leftAnchor: cover.rightAnchor, NEAR)
        clock.setSize(width: 25, height: 25)
        clockText.setAnchors(topAnchor: clock.topAnchor, leftAnchor: clock.rightAnchor, 8)
    }
    
    // Obrigatório quando fazemos o override de init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
