//
//  RepeatView.swift
//  MyBooks
//
//  Created by Victor Pereira on 25/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

class RepeatView: UIView {
    
    let repeatLabel: UILabel = {
        let view = UILabel()
        view.setSmall(text: "Repetir:")
        return view
    }()
    
    let repeatSwitch: UISwitch = {
        let view = UISwitch()
        view.setDefaults()
        return view
    }()

    let domingo: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.setDefaults(title: "D")
        return view
    }()
    let segunda: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.setDefaults(title: "S")
        return view
    }()
    let terca: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.setDefaults(title: "T")
        return view
    }()
    let quarta: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.setDefaults(title: "Q")
        return view
    }()
    let quinta: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.setDefaults(title: "Q")
        return view
    }()
    let sexta: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.setDefaults(title: "S")
        return view
    }()
    let sabado: UIButton = {
        let view = UIButton(type: UIButtonType.system)
        view.setDefaults(title: "S")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        
        let stackHeader: UIStackView = {
            let view = UIStackView(arrangedSubviews: [repeatLabel, repeatSwitch])
            view.setDefaults(axis: .horizontal)
            return view
        }()
        
        
        let stackDays: UIStackView = {
            let view = UIStackView(arrangedSubviews: [domingo, segunda, terca, quarta, quinta, sexta, sabado])
            view.setDefaults(axis: .horizontal)
            return view
        }()
        
        addSubview(stackHeader)
        addSubview(stackDays)
        
        stackHeader.setAnchors(topAnchor: self.topAnchor, leftAnchor: self.leftAnchor, rightAnchor: self.rightAnchor)
        stackDays.setTopAnchor(stackHeader.bottomAnchor, FAR)
        stackDays.centerX(stackHeader)
        
        let width: CGFloat = stackHeader.frame.width
        let height: CGFloat = 61 // stackDays.frame.height + stackHeader.frame.height
        self.setSize(width: width, height: height)
    }
    
    func isRepeatEnabled() -> Bool {
        return repeatSwitch.isOn
    }
    
    func enableHeader(isEnabled: Bool) {
        repeatLabel.isEnabled = isEnabled
        repeatSwitch.isEnabled = isEnabled
        if !isEnabled {
            repeatSwitch.isOn = false
            enableDays()
        }
    }
    
    func enableDays() {
        let isEnabled = isRepeatEnabled()
        domingo.isEnabled = isEnabled
        segunda.isEnabled = isEnabled
        terca.isEnabled = isEnabled
        quarta.isEnabled = isEnabled
        quinta.isEnabled = isEnabled
        sexta.isEnabled = isEnabled
        sabado.isEnabled = isEnabled
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
