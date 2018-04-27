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
    
    // Botão que habilita os botões dos dias da semana
    let repeatSwitch: UISwitch = {
        let view = UISwitch()
        view.setDefaults()
        return view
    }()

    // Botões referentes aos dias da semana
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
    
    // Contrutor
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true // Habilita a interação do usuário
        
        // Criação de stacks
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
        
        // Adição de subviews a view
        addSubview(stackHeader)
        addSubview(stackDays)
        
        // Definição de constraints
        stackHeader.setAnchors(topAnchor: self.topAnchor, leftAnchor: self.leftAnchor, rightAnchor: self.rightAnchor)
        stackDays.setTopAnchor(stackHeader.bottomAnchor, FAR)
        stackDays.centerX(stackHeader)
        
        // Gambiarra para concertar o fato da view ficar com tamanho 0x0 e consequantimente não conseguirmos interagir com os elementos na tela
        let width: CGFloat = stackHeader.frame.width
        let height: CGFloat = 61 // stackDays.frame.height + stackHeader.frame.height
        self.setSize(width: width, height: height)
    }
    
    // Retorna se a repetição esta habilitada ou não
    func isRepeatEnabled() -> Bool {
        return repeatSwitch.isOn
    }
    
    // Habilita e desabilita elementos do cabeçalho
    func enableHeader(isEnabled: Bool = false) {
        repeatLabel.isEnabled = isEnabled
        repeatSwitch.isEnabled = isEnabled
        
        // Se for desabilitado, muda a posição do switchButton e desabilita os botões dos dias da semana
        if !isEnabled {
            repeatSwitch.isOn = false
            enableDays()
        }
    }
    
    // Habilita e desabilita os botões dos dias da semana
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
