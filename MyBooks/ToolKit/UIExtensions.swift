//
//  Extensions.swift
//  MyBooks
//
//  Created by Victor Pereira on 25/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit

extension UIButton {
    func setColor(status: Bool) {
        if status {
            self.tintColor = .white
            self.backgroundColor = DEFAULT_GREEN
        } else {
            self.tintColor = .lightGray
            self.backgroundColor = .white
        }
    }
}