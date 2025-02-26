//
//  ContentView.swift
//  Ch5LoukeysWatch Watch App
//
//  Created by Daniele Fontana on 25/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var textToSend: String = ""
    @State private var receivedText: String = ""
    
    private var watchToiOSConnector = WatchToiOSConnector()
    
    var body: some View {
        VStack {
            TextField("Inserisci testo", text: $textToSend)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Button(action: {
                watchToiOSConnector.sendTextToiOS(textToSend)
            }) {
                Text("Invia a iPhone")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Text("Testo ricevuto: \(receivedText)")
                .padding()
                .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding()
        .onAppear {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("ReceivedText"), object: nil, queue: .main) { notification in
                if let text = notification.userInfo?["text"] as? String {
                    receivedText = text
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
