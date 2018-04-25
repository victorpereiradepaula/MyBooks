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
        view.backgroundColor = .lightGray
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: 18.0)
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
        view.font = .boldSystemFont(ofSize: 16.0)
        view.text = "Páginas:"
        view.sizeToFit()
        return view
    }()
    
    let pagesText: UILabel = {
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
        
        cover.setSize(width: 100, height: 150)
        cover.setAnchors(topAnchor: self.topAnchor, FAR, leftAnchor: self.leftAnchor, FAR)
        stackLabels.setWidth(65)
        stackInfo.setAnchors(topAnchor: cover.topAnchor, leftAnchor: cover.rightAnchor, NEAR, rightAnchor: self.rightAnchor, NEGATIVE_FAR)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
