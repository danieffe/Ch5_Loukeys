//
//  WatchConnector.swift
//  Ch5Loukeys
//
//  Created by Daniele Fontana on 25/02/25.
//

import Foundation
import WatchConnectivity

class WatchConnector: NSObject, WCSessionDelegate {
    
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
                print("Watch è raggiungibile")
            } else {
                print("Watch non è raggiungibile. Verifica la connessione.")
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Sessione diventata inattiva")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Sessione disattivata")
        session.activate() 
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let text = message["text"] as? String {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("ReceivedText"), object: nil, userInfo: ["text": text])
            }
        }
    }
    
    func sendTextToWatch(_ text: String) {
        if session.isReachable {
            session.sendMessage(["text": text], replyHandler: nil, errorHandler: { error in
                print("Errore invio messaggio: \(error.localizedDescription)")
            })
        } else {
            print("Watch non raggiungibile. Verifica che il Watch sia associato e connesso.")
        }
    }
}
