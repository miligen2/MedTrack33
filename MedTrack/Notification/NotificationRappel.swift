//
//  NotificationRappel.swift
//  MedTrack
//
//  Created by Angelo Macaire on 30/09/2023.
//

import Foundation
import UserNotifications
//
//struct NotificationManager {
//    static func scheduleNotification(forMedicament medicament: String, at date: Date) {
//        let content = UNMutableNotificationContent()
//        content.title = "Heure de prise du médicament"
//        content.body = "N'oubliez pas de prendre votre médicament : \(medicament)"
//        content.sound = UNNotificationSound.default
//
//        // Convertissez la date sélectionnée en composants de date
//        let calendar = DateComponents()
//        let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
//
//        // Créez un déclencheur basé sur les composants de date
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//        // Créez une demande de notification avec un identifiant unique
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//        // Ajoutez la demande à UserNotificationCenter
//        UNUserNotificationCenter.current().add(request) { error in
//            if let error = error {
//                print("Erreur lors de la planification de la notification : \(error.localizedDescription)")
//            } else {
//                print("Notification planifiée avec succès")
//            }
//        }
//    }
//
//}


