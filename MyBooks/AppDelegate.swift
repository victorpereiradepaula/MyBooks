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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        // Requisita altorização do usuário para enviar notificações
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in })
        
        let booksListNavigationController = UINavigationController(rootViewController: BooksListTableViewController()) // Cria uma UINavigationController, setanndo o rootViewController como BooksListTableViewController
        
        UINavigationBar.appearance().barTintColor = .black  // Seta preto como a cor do fundo dos UINavigationBar
        UINavigationBar.appearance().tintColor = GREEN // Seta DEFAULT_GREEN como a cor dos botoes dos UINavigationBar
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : GREEN] // Seta DEFAULT_GREEN como a cor dos titulos dos UINavigationBar
        
        window = UIWindow(frame: UIScreen.main.bounds) // Cria uma UIWindow com frame do tamanho do retângulo da tela do aparelho
        window?.rootViewController =  booksListNavigationController // Define booksListNavigationController como rootViewController (principal)
        window?.makeKeyAndVisible() // Torna a controller principoal visível e traz para frente das demais janelas
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
}
