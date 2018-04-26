//
//  Book.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import Foundation
import RealmSwift

class Book: Object {
    
    func setValues(title: String, pages: Int = 0, cover: NSData = NSData()) {
        self.cover = cover
        self.pages = pages
        self.title = title
    }
    
    func setValues(book: Book) {
        self.cover = book.cover
        self.pages = book.pages
        self.title = book.title
    }
    
    func setNotification(notificationIdentifier: String, timeInterval: TimeInterval, repeatDay: Bool = false, repeatDomingo: Bool = false, repeatSegunda: Bool = false, repeatTerca: Bool = false, repeatQuarta: Bool = false, repeatQuinta: Bool = false, repeatSexta: Bool = false, repeatSabado: Bool = false) {
        self.notificationIdentifier = notificationIdentifier
        self.timeInterval = timeInterval
        self.repeatDay = repeatDay
        self.repeatDomingo = repeatDomingo
        self.repeatSegunda = repeatSegunda
        self.repeatTerca = repeatTerca
        self.repeatQuarta = repeatQuarta
        self.repeatQuinta = repeatQuinta
        self.repeatSexta = repeatSexta
        self.repeatSabado = repeatSabado
    }
    
    @objc dynamic var title: String = ""
    @objc dynamic var pages: Int = 0
    @objc dynamic var cover = NSData()
    
    @objc dynamic var notificationIdentifier: String = ""
    @objc dynamic var timeInterval: TimeInterval = 0
    @objc dynamic var repeatDay: Bool = false
    @objc dynamic var repeatDomingo: Bool = false
    @objc dynamic var repeatSegunda: Bool = false
    @objc dynamic var repeatTerca: Bool = false
    @objc dynamic var repeatQuarta: Bool = false
    @objc dynamic var repeatQuinta: Bool = false
    @objc dynamic var repeatSexta: Bool = false
    @objc dynamic var repeatSabado: Bool = false

    override static func primaryKey() -> String? {
        return "title"
    }
}
