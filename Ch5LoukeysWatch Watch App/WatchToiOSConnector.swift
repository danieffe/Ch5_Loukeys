//
//  WatchToiOSConnector.swift
//  Ch5LoukeysWatch Watch App
//
//  Created by Daniele Fontana on 25/02/25.
//

import Foundation
import WatchConnectivity

class WatchToiOSConnector: NSObject, WCSessionDelegate {
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        } else {
            print("WCSession non è supportato su questo dispositivo.")
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        if let error = error {
            print("Errore attivazione sessione: \(error.localizedDescription)")
        } else {
            print("Sessione attivata con successo. Stato: \(activationState == .activated ? "Attivata" : "Non attivata")")
            if session.isReachable {
                print("iPhone è raggiungibile")
            } else {
                print("iPhone non è raggiungibile. Verifica la connessione.")
            }
        }
    }
    
    func sendTextToiOS(_ text: String) {
        if session.isReachable {
            session.sendMessage(["text": text], replyHandler: nil, errorHandler: { error in
                print("Errore invio messaggio: \(error.localizedDescription)")
            })
        } else {
            print("iPhone non raggiungibile. Verifica che l'iPhone sia associato e connesso.")
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let text = message["text"] as? String {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("ReceivedText"), object: nil, userInfo: ["text": text])
            }
        }
    }
}
