//
//  ConfirmationView.swift
//  Ch5LoukeysWatch Watch App
//
//  Created by Daniele Fontana on 28/02/25.
//

import SwiftUI

struct ConfirmationView: View {
    @Binding var showConfirmation: Bool 
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()

            VStack {
                Spacer()
                
                Text("Well Done Bruno!")
                    .font(.headline)
                    .foregroundColor(.black)

                Spacer()
            }
        }
        .onAppear {
            WKInterfaceDevice.current().play(.success)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // 🔹 Attende 3s e chiude la view
                showConfirmation = false
            }
        }
    }
}

#Preview {
    ConfirmationView(showConfirmation: .constant(true))
}


