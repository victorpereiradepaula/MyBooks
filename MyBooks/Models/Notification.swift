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
    
    // Declaração de variáveis e constantes
    @objc dynamic var notificationIdentifier: String = ""
    @objc dynamic var hour: Int = 0
    @objc dynamic var minute: Int = 0
    @objc dynamic var repeatDay: Bool = false
    let weekDays = List<Bool>()
    
    // Seta os valores da notificação
    func setNotification(notification: Notification) {
        
        self.notificationIdentifier = notification.notificationIdentifier
        self.hour = notification.hour
        self.minute = notification.minute
        self.repeatDay = notification.repeatDay
        self.weekDays.append(objectsIn: notification.weekDays)
    }
    func setNotification(notificationIdentifier: String, hour: Int, minute: Int, repeatDay: Bool, weekDays: [Bool]) {
        
        self.notificationIdentifier = notificationIdentifier
        self.hour = hour
        self.minute = minute
        self.repeatDay = repeatDay
        self.weekDays.append(objectsIn: weekDays)
    }
    
    override static func primaryKey() -> String? {
        return "notificationIdentifier"
    }
}
