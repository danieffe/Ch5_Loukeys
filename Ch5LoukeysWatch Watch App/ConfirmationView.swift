//
//  ConfirmationView.swift
//  Ch5LoukeysWatch Watch App
//
//  Created by Daniele Fontana on 28/02/25.
//

import SwiftUI

struct ConfirmationView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("Well Done Bruno!")
                .font(.headline)
                .foregroundColor(.black)

            Spacer()

            Button(action: {
                WKInterfaceDevice.current().play(.success)
            }) {
                Text("OK")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow.opacity(0.8))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
        }
        .padding()
        .background(Color.yellow)
        .cornerRadius(20)
    }
}

#Preview {
    ConfirmationView()
}

