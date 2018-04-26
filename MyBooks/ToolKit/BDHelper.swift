//
//  BDHelper.swift
//  MyBooks
//
//  Created by Victor Pereira on 26/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import RealmSwift
import UserNotifications

class BDHelper {
    
    static func add(book: Book) {
        
    }
    
    static func remove(book: Book) {
        let title = book.title
        let identifier = book.notificationIdentifier
        
        if(identifier != "") {
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
        }
        
        let realm = try! Realm()
        realm.refresh()
        try! realm.write {
            realm.delete(realm.object(ofType: Book.self, forPrimaryKey: title)!)
        }
    }
    
    static func getBooks() -> [Book]{
        var books = [Book]()
        let realm = try! Realm()
        realm.refresh()
        books.append(contentsOf: realm.objects(Book.self))
        return books
    }
    
    static func exists(key: String) -> Bool {
        let realm = try! Realm()
        realm.refresh()
        let books = realm.objects(Book.self).filter("title == '\(key)'")
        return books.isEmpty
    }
}
