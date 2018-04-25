//
//  Constraints.swift
//  MyBooks
//
//  Created by Victor Pereira on 24/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

extension UIView {
    
    func setEqualsConstraints(_  view: UIView) {
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    // Width
    func setWidth(_ width: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    // Height
    func setHeight(_ height: CGFloat) {
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    // Width e Height
    func setSize(width: CGFloat, height: CGFloat) {
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    // Top
    func setTopAnchor(_ topAnchor: NSLayoutYAxisAnchor,_ constant: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: topAnchor, constant: constant).isActive = true
    }
    
    // Left
    func setLeftAnchor(_ leftAnchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0) {
        self.leftAnchor.constraint(equalTo: leftAnchor, constant: constant).isActive = true
    }
    
    // Right
    func setRightAnchor(_ rightAnchor: NSLayoutXAxisAnchor, _ constant: CGFloat = 0) {
        self.rightAnchor.constraint(equalTo: rightAnchor, constant: constant).isActive = true
    }
    
    // Left e Right
    func setAnchors(leftAnchor: NSLayoutXAxisAnchor, _ constantLeft: CGFloat = 0, rightAnchor: NSLayoutXAxisAnchor, _ constantRight: CGFloat = 0) {
        self.leftAnchor.constraint(equalTo: leftAnchor, constant: constantLeft).isActive = true
        self.rightAnchor.constraint(equalTo: rightAnchor, constant: constantRight).isActive = true
    }
    
    // Top e Left
    func setAnchors(topAnchor: NSLayoutYAxisAnchor,_ constantTop: CGFloat = 0, leftAnchor: NSLayoutXAxisAnchor, _ constantLeft: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: topAnchor, constant: constantTop).isActive = true
        self.leftAnchor.constraint(equalTo: leftAnchor, constant: constantLeft).isActive = true
    }
    
    // Top e Right
    func setAnchors(topAnchor: NSLayoutYAxisAnchor,_ constantTop: CGFloat = 0, rightAnchor: NSLayoutXAxisAnchor, _ constantRight: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: topAnchor, constant: constantTop).isActive = true
        self.rightAnchor.constraint(equalTo: rightAnchor, constant: constantRight).isActive = true
    }
    
    // Top, Left e Right
    func setAnchors(topAnchor: NSLayoutYAxisAnchor,_ constantTop: CGFloat = 0, leftAnchor: NSLayoutXAxisAnchor, _ constantLeft: CGFloat = 0, rightAnchor: NSLayoutXAxisAnchor, _ constantRight: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: topAnchor, constant: constantTop).isActive = true
        self.leftAnchor.constraint(equalTo: leftAnchor, constant: constantLeft).isActive = true
        self.rightAnchor.constraint(equalTo: rightAnchor, constant: constantRight).isActive = true
    }
    
    // Top, Left, Right e Bottom
    func setAnchors(topAnchor: NSLayoutYAxisAnchor,_ contantTop: CGFloat = 0, leftAnchor: NSLayoutXAxisAnchor, _ constantLeft: CGFloat = 0, rightAnchor: NSLayoutXAxisAnchor, _ constantRight: CGFloat = 0, bottomAnchor: NSLayoutYAxisAnchor, _ constantBottom: CGFloat = 0) {
        self.topAnchor.constraint(equalTo: topAnchor, constant: contantTop).isActive = true
        self.leftAnchor.constraint(equalTo: leftAnchor, constant: constantLeft).isActive = true
        self.rightAnchor.constraint(equalTo: rightAnchor, constant: constantRight).isActive = true
        self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: constantBottom).isActive = true
    }
    
}
