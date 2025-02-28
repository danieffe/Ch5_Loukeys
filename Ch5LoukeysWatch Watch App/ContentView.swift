//
//  ContentView.swift
//  Ch5LoukeysWatch Watch App
//
//  Created by Daniele Fontana on 25/02/25.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @State private var showConfirmation = false
    let taskTitle = "Morning Pill"
    let taskSubtitle = "Before Breakfast"
    
    var body: some View {
        VStack {
            HStack {
                Text("Task to do")
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
                        Text(taskTitle)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text(taskSubtitle)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .padding(.horizontal)

 
            Button(action: {
                showConfirmation = true
                WatchToiOSConnector.shared.sendTaskCompletionToiOS(taskName: taskTitle)
            }) {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $showConfirmation) {
            ConfirmationView(showConfirmation: $showConfirmation)
        }
    }
}

#Preview {
    ContentView()
}



