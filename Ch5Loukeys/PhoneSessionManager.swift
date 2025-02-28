//
//  WatchConnector.swift
//  Ch5Loukeys
//
//  Created by Daniele Fontana on 25/02/25.
//

import Foundation
import WatchConnectivity
import UserNotifications

class PhoneSessionManager: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = PhoneSessionManager()
    private var session: WCSession
    
    @Published var taskCompletedMessage: String = ""
    
    private override init() {
        self.session = WCSession.default
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

    func sessionDidBecomeInactive(_ session: WCSession) {}

    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        if let taskName = message["taskCompleted"] as? String {
            let notificationMessage = "Bruno has completed successfully the task: \(taskName)"
            DispatchQueue.main.async {
                self.taskCompletedMessage = notificationMessage
                self.sendLocalNotification(message: notificationMessage)
            }
        }
    }

    private func sendLocalNotification(message: String) {
        let content = UNMutableNotificationContent()
        content.title = "Task Completed"
        content.body = message
        content.sound = .default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}




