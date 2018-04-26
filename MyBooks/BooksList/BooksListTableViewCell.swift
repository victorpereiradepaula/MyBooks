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
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        view.backgroundColor = DEFAULT_GRAY
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 3
        view.layer.borderWidth = 1
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
    
    let titleText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    let pagesText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var clock: UIImageView =  {
        let view = UIImageView(image: #imageLiteral(resourceName: "clock"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let clockText: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
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
        
        
        cover.setSize(width: magicWidth, height: magicHeight)
        cover.setAnchors(topAnchor: self.topAnchor, FAR, leftAnchor: self.leftAnchor, FAR)
        stackLabels.setWidth(magicLabelWidth)
        stackInfo.setAnchors(topAnchor: cover.topAnchor, leftAnchor: cover.rightAnchor, NEAR, rightAnchor: self.rightAnchor, NEGATIVE_FAR)
        
        addSubview(clock)
        clock.setAnchors(topAnchor: stackInfo.bottomAnchor, 35, leftAnchor: cover.rightAnchor, NEAR)
        clock.setSize(width: 25, height: 25)
        
        addSubview(clockText)
        clockText.setAnchors(topAnchor: clock.topAnchor, leftAnchor: clock.rightAnchor, 8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
