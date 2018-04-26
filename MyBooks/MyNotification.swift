//
//  Notification.swift
//  MyBooks
//
//  Created by Victor Pereira on 26/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import Foundation
import RealmSwift

class MyNotification: Object {
    
    func setNotification(notification: MyNotification) {
        self.notificationIdentifier = notification.notificationIdentifier
        
        self.hour = notification.hour
        self.minute = notification.minute
        
        self.repeatDay = notification.repeatDay
        
        self.domingo = notification.domingo
        self.segunda = notification.segunda
        self.terca = notification.terca
        self.quarta = notification.quarta
        self.quinta = notification.quinta
        self.sexta = notification.sexta
        self.sabado = notification.sabado
    }
    
    func setNotification(notificationIdentifier: String, hour: Int, minute: Int, repeatDay: Bool, weekDays: [Bool]) {
        self.notificationIdentifier = notificationIdentifier
        
        self.hour = hour
        self.minute = minute
        
        self.repeatDay = repeatDay
        
        self.domingo = weekDays[0]
        self.segunda = weekDays[1]
        self.terca = weekDays[2]
        self.quarta = weekDays[3]
        self.quinta = weekDays[4]
        self.sexta = weekDays[5]
        self.sabado = weekDays[6]
    }
    
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
