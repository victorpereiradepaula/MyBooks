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
    
    func setValues(title: String, pages: Int = 0, cover: NSData = NSData(), notification: MyNotification = MyNotification()) {
        self.cover = cover
        self.pages = pages
        self.title = title
        self.notificationIdentifier = notification.notificationIdentifier
    }
    
    func setValues(book: Book) {
        self.cover = book.cover
        self.pages = book.pages
        self.title = book.title
        self.notificationIdentifier = book.notificationIdentifier
    }
    
    @objc dynamic var title: String = ""
    @objc dynamic var pages: Int = 0
    @objc dynamic var cover = NSData()
    
    @objc dynamic var notificationIdentifier: String = ""

    override static func primaryKey() -> String? {
        return "title"
    }
}
