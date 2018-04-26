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
    
    static func add(book: Book, notification: MyNotification = MyNotification()) {
        add(book: book)
        if !notification.notificationIdentifier.isEmpty {
            add(notification: notification)
            createNotifications(notification: notification, title: book.title)
        }
    }
    
    static private func add(book: Book) {
        let realm = try! Realm()
        realm.refresh()
        try! realm.write {
            realm.add(book, update: true)
        }
    }
    
    static private func add(notification: MyNotification) {
        let realm = try! Realm()
        realm.refresh()
        try! realm.write {
            realm.add(notification, update: true)
        }
    }
    
    static private func createNotifications(notification: MyNotification, title: String) {
        
        let content = UNMutableNotificationContent()
        content.title = "Hora de ler \(title)"
        content.body = "Acesse o MyBooks e confira seus livros."
        content.sound = UNNotificationSound.default()
        
        let identifier = notification.notificationIdentifier
        let repeats = notification.repeatDay
        var components = DateComponents()
        components.hour = notification.hour
        components.minute = notification.minute
        
        if notification.repeatDay {
            let weekDays = [notification.domingo, notification.segunda, notification.terca, notification.quarta, notification.quinta, notification.sexta, notification.sabado]
            let lenght = weekDays.count
            for index in 0...lenght {
                if weekDays[index] {
                    components.weekday = index + 1
                    components.timeZone = .current
                    
                    
                    let calendar = Calendar(identifier: .gregorian)
                    let date = calendar.date(from: components)
                    
                    let triggerWeekly = Calendar.current.dateComponents([.weekday, .hour, .minute], from: date!)
                    settupNotification(notificationIdentifier: identifier, contents: content, dateComponents: triggerWeekly, repeats: repeats, completion: { (success) in })
                }
            }
        } else {
            settupNotification(notificationIdentifier: identifier, contents: content, dateComponents: components, repeats: repeats, completion: { (success) in })
        }
        
        
    }
    
    static private func settupNotification(notificationIdentifier: String, contents: UNMutableNotificationContent, dateComponents: DateComponents, repeats: Bool,  completion: @escaping (_ Success: Bool) -> ()) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        
        let notification = UNNotificationRequest(identifier: notificationIdentifier, content: contents, trigger: trigger)
        
        UNUserNotificationCenter.current().add(notification) { (error) in
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    static func remove(book: Book) {
        let title = book.title
        let identifier = book.notificationIdentifier

        if(identifier != "") {
            remove(notificationIdentifier: identifier)
        }
        
        let realm = try! Realm()
        realm.refresh()
        try! realm.write {
            realm.delete(realm.object(ofType: Book.self, forPrimaryKey: title)!)
        }
    }
    
    static private func remove(notificationIdentifier: String) {
        
        
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notificationIdentifier])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
        
        let realm = try! Realm()
        realm.refresh()
        try! realm.write {
            realm.delete(realm.object(ofType: MyNotification.self, forPrimaryKey: notificationIdentifier)!)
        }
    }
    
    
    
    static func getBooks() -> [Book]{
        var books = [Book]()
        let realm = try! Realm()
        realm.refresh()
        books.append(contentsOf: realm.objects(Book.self))
        return books
    }
    
    static func getNotifications() -> [MyNotification]{
        var notifications = [MyNotification]()
        let realm = try! Realm()
        realm.refresh()
        notifications.append(contentsOf: realm.objects(MyNotification.self))
        return notifications
    }
    
    static func getNotification(key: String) -> [MyNotification]{
        let realm = try! Realm()
        realm.refresh()
        let realmResult = realm.objects(MyNotification.self).filter("notificationIdentifier == '\(key)'")
        var notification = [MyNotification]()
        notification.append(contentsOf: realmResult)
        return notification
    }
    
    static func exists(key: String) -> Bool {
        let realm = try! Realm()
        realm.refresh()
        let books = realm.objects(Book.self).filter("title == '\(key)'")
        return !books.isEmpty
    }
}
