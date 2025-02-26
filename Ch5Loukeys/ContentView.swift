//
//  ContentView.swift
//  Ch5Loukeys
//
//  Created by Daniele Fontana on 25/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var textToSend: String = ""
    @State private var receivedText: String = ""
    
    private var watchConnector = WatchConnector()
    
    var body: some View {
        VStack {
            TextField("Inserisci testo", text: $textToSend)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                watchConnector.sendTextToWatch(textToSend)
            }) {
                Text("Invia a Watch")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Text("Testo ricevuto: \(receivedText)")
                .padding()
            
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
