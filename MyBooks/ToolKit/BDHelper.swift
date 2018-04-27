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
    
    static func add(book: Book, notification: Notification = Notification()) {
        
        // Se existem notificações, cria notificação
        if book.hasNotification() {
            book.notificationIdentifier = notification.notificationIdentifier
            add(notification: notification)
            createNotifications(notification: notification, title: book.title)
        }
        
        add(book: book)
    }
    
    // Adiciona livro ao banco
    static private func add(book: Book) {
        let realm = try! Realm()
        realm.refresh()
        try! realm.write {
            realm.add(book, update: true)
        }
    }
    
    // Adiciona notificação ao banco
    static private func add(notification: Notification) {
        let realm = try! Realm()
        realm.refresh()
        try! realm.write {
            realm.add(notification, update: true)
        }
    }
    
    
    // Definição das notidicações locais a serem criadas
    static private func createNotifications(notification: Notification, title: String) {
        
        let content = UNMutableNotificationContent()
        content.title = "Hora de ler \(title)"
        content.body = "Acesse o MyBooks e confira seus livros."
        content.sound = UNNotificationSound.default()
        
        let notificationIdentifier = notification.notificationIdentifier
        let repeats = notification.repeatDay
        var components = DateComponents()
        components.hour = notification.hour
        components.minute = notification.minute
        
//        if notification.repeatDay {
//            let weekDays = [notification.domingo, notification.segunda, notification.terca, notification.quarta, notification.quinta, notification.sexta, notification.sabado]
//            let lenght = weekDays.count
//            for index in 0...lenght {
//                if weekDays[index] {
//                    components.weekday = index + 1
//                    components.timeZone = .current
//
//
//                    let calendar = Calendar(identifier: .gregorian)
//                    let date = calendar.date(from: components)
//
//                    let triggerWeekly = Calendar.current.dateComponents([.weekday, .hour, .minute], from: date!)
//                    settupNotification(notificationIdentifier: identifier, contents: content, dateComponents: triggerWeekly, repeats: repeats)
//                }
//            }
//        } else {
            addLocalNotification(notificationIdentifier: notificationIdentifier, contents: content, dateComponents: components, repeats: repeats)
//        }
        
        
    }
    
    // Adiciona notificações locais
    static private func addLocalNotification(notificationIdentifier: String, contents: UNMutableNotificationContent, dateComponents: DateComponents, repeats: Bool) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        
        let notification = UNNotificationRequest(identifier: notificationIdentifier, content: contents, trigger: trigger)
        
        UNUserNotificationCenter.current().add(notification)
    }
    
    // Remove livros
    static func remove(book: Book) {
        let title = book.title
        let notificationIdentifier = book.notificationIdentifier

        // Se existirem notificações, chama função para remove-las
        if notificationIdentifier.isEmpty {
            remove(notificationIdentifier: notificationIdentifier)
        }
        
        // Remove livro do banco
        let realm = try! Realm()
        realm.refresh()
        try! realm.write {
            realm.delete(realm.object(ofType: Book.self, forPrimaryKey: title)!)
        }
    }
    
    // Remove notificações do banco e do sistema
    static private func remove(notificationIdentifier: String) {
        
        removeLocalNotifications(notificationIdentifier: notificationIdentifier)
        
        let realm = try! Realm()
        realm.refresh()
        try! realm.write {
            realm.delete(realm.object(ofType: Notification.self, forPrimaryKey: notificationIdentifier)!)
        }
    }
    
    // Remove notificações locais
   static private func removeLocalNotifications(notificationIdentifier: String) {
        // Remove notificações entregues com identificador igual ao recebido
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notificationIdentifier])
        
        // Remove notificações pendentes com identificador igual ao recebido
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
    }
    
    
    // Retorna um array com todos os livros
    static func getBooks() -> [Book] {
        var books = [Book]()
        let realm = try! Realm()
        realm.refresh()
        books.append(contentsOf: realm.objects(Book.self))
        return books
    }
    
    // Retorna um array com todas as notificações
    static func getNotifications() -> [Notification] {
        var notifications = [Notification]()
        let realm = try! Realm()
        realm.refresh()
        notifications.append(contentsOf: realm.objects(Notification.self))
        return notifications
    }
    
    // Retorna um array com as notidicações encontradas pelo filtro
    static func getNotification(key: String) -> [Notification] {
        let realm = try! Realm()
        realm.refresh()
        let bdNotifications = realm.objects(Notification.self).filter("notificationIdentifier == '\(key)'")
        var notifications = [Notification]()
        notifications.append(contentsOf: bdNotifications)
        return notifications
    }
    
    // Retorna se existem notificações ou não
    static func existsNotificaton(key: String) -> Bool {
        let realm = try! Realm()
        realm.refresh()
        let notifications = realm.objects(Notification.self).filter("notificationIdentifier == '\(key)'")
        return !notifications.isEmpty
    }
    
    // Retorna se existem livros ou não
    static func existsBook(key: String) -> Bool {
        let realm = try! Realm()
        realm.refresh()
        let books = realm.objects(Book.self).filter("title == '\(key)'")
        return !books.isEmpty
    }
}
