//
//  RepeatView.swift
//  MyBooks
//
//  Created by Victor Pereira on 25/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

class RepeatView: UIView {
    
    var isEnabledDays = false
    var isEnabledHeader = false
    
    let repeatLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .boldSystemFont(ofSize: SMALL_FONT_SIZE)
        view.text = "Repetir:"
        view.isEnabled = false
        return view
    }()
    
    let repeatSwitch: UISwitch = {
        let view = UISwitch()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEnabled = false
        return view
    }()

    let domingo: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("D", for: UIControlState.normal)
        view.tintColor = .lightGray
        view.isEnabled = false
        return view
    }()
    let segunda: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("S", for: UIControlState.normal)
        view.tintColor = .lightGray
        view.isEnabled = false
        return view
    }()
    let terca: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("T", for: UIControlState.normal)
        view.tintColor = .lightGray
        view.isEnabled = false
        return view
    }()
    let quarta: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Q", for: UIControlState.normal)
        view.tintColor = .lightGray
        view.isEnabled = false
        return view
    }()
    let quinta: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Q", for: UIControlState.normal)
        view.tintColor = .lightGray
        view.isEnabled = false
        return view
    }()
    let sexta: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("S", for: UIControlState.normal)
        view.tintColor = .lightGray
        view.isEnabled = false
        return view
    }()
    let sabado: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("S", for: UIControlState.normal)
        view.tintColor = .lightGray
        view.isEnabled = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        
        let stackHeader: UIStackView = {
            let view = UIStackView(arrangedSubviews: [repeatLabel, repeatSwitch])
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .horizontal
            view.spacing = NEAR
            return view
        }()
        
        
        let stackDays: UIStackView = {
            let view = UIStackView(arrangedSubviews: [domingo, segunda, terca, quarta, quinta, sexta, sabado])
            view.translatesAutoresizingMaskIntoConstraints = false
            view.axis = .horizontal
            view.spacing = NEAR
            return view
        }()
        
        addSubview(stackHeader)
        addSubview(stackDays)
        
        stackHeader.setAnchors(topAnchor: self.topAnchor, leftAnchor: self.leftAnchor, rightAnchor: self.rightAnchor)
        stackDays.setTopAnchor(stackHeader.bottomAnchor, FAR)
        stackDays.centerXAnchor.constraint(equalTo: stackHeader.centerXAnchor).isActive = true
        
        let width: CGFloat = stackHeader.frame.width
        let height: CGFloat = 61 // stackDays.frame.height + stackHeader.frame.height
        self.setSize(width: width, height: height)
    }
    
    func enableHeader() {
        isEnabledHeader = !isEnabledHeader
        repeatLabel.isEnabled = isEnabledHeader
        repeatSwitch.isEnabled = isEnabledHeader
    }
    
    func enableDays() {
        isEnabledDays = !isEnabledDays
        domingo.isEnabled = isEnabledDays
        segunda.isEnabled = isEnabledDays
        terca.isEnabled = isEnabledDays
        quarta.isEnabled = isEnabledDays
        quinta.isEnabled = isEnabledDays
        sexta.isEnabled = isEnabledDays
        sabado.isEnabled = isEnabledDays
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
