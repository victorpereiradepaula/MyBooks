//
//  AppDelegate.swift
//  MyBooks
//
//  Created by Victor Pereira on 23/04/18.
//  Copyright © 2018 Victor Pereira. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in })
        
        let booksListNavigationController = UINavigationController(rootViewController: BooksListTableViewController()) // Cria uma UINavigationController, setanndo o rootViewController como BooksListTableViewController
        
        window = UIWindow(frame: UIScreen.main.bounds) // Cria uma UIWindow com frame do tamanho do retângulo da tela do aparelho
        window?.rootViewController =  booksListNavigationController // Define booksListNavigationController como rootViewController (inicial)
        window?.makeKeyAndVisible() // Torna visível
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}
