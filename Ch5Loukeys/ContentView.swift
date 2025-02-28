//
//  ContentView.swift
//  Ch5Loukeys
//
//  Created by Daniele Fontana on 25/02/25.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @ObservedObject private var sessionManager = PhoneSessionManager.shared
    
    var body: some View {
        VStack {

            HStack {
                Text("Task")
                    .font(.headline)
                    .foregroundColor(.yellow)
                Spacer()
            }
            .padding(.horizontal)
            

            ZStack(alignment: .topTrailing) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.black.opacity(0.8))
                    .frame(height: 80)
                
                HStack {
                    Image(systemName: "pills.fill")
                        .foregroundColor(.yellow)
                        .font(.system(size: 24))
                    
                    VStack(alignment: .leading) {
                        Text("Morning Pill")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Before Breakfast")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .padding(.horizontal)
            
            if !sessionManager.taskCompletedMessage.isEmpty {
                Text(sessionManager.taskCompletedMessage)
                    .foregroundColor(.green)
                    .padding()
            }

            Spacer()
        }
        .padding()
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



