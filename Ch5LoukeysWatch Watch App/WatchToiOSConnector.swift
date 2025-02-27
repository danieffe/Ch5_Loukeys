//
//  WatchToiOSConnector.swift
//  Ch5LoukeysWatch Watch App
//
//  Created by Daniele Fontana on 25/02/25.
//

import Foundation
import WatchConnectivity
import UserNotifications

class WatchToiOSConnector: NSObject, WCSessionDelegate {
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (Error)?) {
        if let error = error {
            print("Errore attivazione sessione: \(error.localizedDescription)")
        }
    }
    
    func sendTaskNotificationToiOS() {
        if session.isReachable {
            session.sendMessage(["taskNotification": "Task to Do"], replyHandler: nil, errorHandler: { error in
                print("Errore invio messaggio: \(error.localizedDescription)")
            })
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let _ = message["taskNotification"] as? String {
            DispatchQueue.main.async {
                self.sendLocalNotification()
            }
        }
    }
    
    private func sendLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Nuova Notifica"
        content.body = "Task to Do"
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}

