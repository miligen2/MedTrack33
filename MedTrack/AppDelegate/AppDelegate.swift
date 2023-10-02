//
//  AppDelegate.swift
//  MedTrack
//
//  Created by Angelo Macaire on 30/09/2023.
//

import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Demander l'autorisation pour les notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                
                let content = UNMutableNotificationContent()
                content.title = "Bienvenue dans votre application"
                content.body = "Vous recevrez bientôt des rappels pour prendre vos médicaments."
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Erreur lors de la planification de la notification initiale : \(error.localizedDescription)")
                    } else {
                        print("Notification initiale planifiée avec succès")
                    }
                }

            } else {
                print("L'autorisation des notifications a été refusée ou une erreur s'est produite : \(error?.localizedDescription ?? "")")
            }
        }
        
        return true
    }
}
