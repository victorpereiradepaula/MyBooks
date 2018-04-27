//
//  Notification.swift
//  MyBooks
//
//  Created by Victor Pereira on 26/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import Foundation
import RealmSwift

class Notification: Object {
    
//    override init(value: MyNotification) {
//        <#code#>
//    }
    
    @objc dynamic var notificationIdentifier: String = ""
    
    @objc dynamic var hour: Int = 0
    @objc dynamic var minute: Int = 0
    
    @objc dynamic var repeatDay: Bool = false
    
    @objc dynamic var domingo: Bool = false
    @objc dynamic var segunda: Bool = false
    @objc dynamic var terca: Bool = false
    @objc dynamic var quarta: Bool = false
    @objc dynamic var quinta: Bool = false
    @objc dynamic var sexta: Bool = false
    @objc dynamic var sabado: Bool = false
    
    override static func primaryKey() -> String? {
        return "notificationIdentifier"
    }
}
