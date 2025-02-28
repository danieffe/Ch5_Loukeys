//
//  WatchToiOSConnector.swift
//  Ch5LoukeysWatch Watch App
//
//  Created by Daniele Fontana on 25/02/25.
//

import Foundation
import WatchConnectivity

class WatchToiOSConnector: NSObject, WCSessionDelegate {
    
    static let shared = WatchToiOSConnector()
    var session: WCSession
    
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
    
    func sendTaskCompletionToiOS(taskName: String) {
        if session.isReachable {
            let message = ["taskCompleted": taskName]
            session.sendMessage(message, replyHandler: nil, errorHandler: { error in
                print("Errore invio messaggio: \(error.localizedDescription)")
            })
        }
    }
}



