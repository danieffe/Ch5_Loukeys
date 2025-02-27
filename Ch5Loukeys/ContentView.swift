//
//  ContentView.swift
//  Ch5Loukeys
//
//  Created by Daniele Fontana on 25/02/25.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    private var watchConnector = WatchConnector()
    
    var body: some View {
        VStack {
            Button(action: {
                watchConnector.sendTaskNotificationToWatch()
            }) {
                Text("Invia Notifica a Watch")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .onAppear {
            requestNotificationPermission()
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            if granted {
                print("Notifiche autorizzate.")
            } else {
                print("Permessi notifiche negati.")
            }
        }
    }
}

#Preview {
    ContentView()
}

