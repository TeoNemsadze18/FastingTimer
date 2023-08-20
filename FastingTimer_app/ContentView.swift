//
//  ContentView.swift
//  FastingTimer_app
//
//  Created by teona nemsadze on 19.08.23.
//

import SwiftUI

struct ContentView: View {
   @StateObject var fastingManager = FastingManager()
    
    var title: String {
        switch fastingManager.fastingState {
            
        case .notStarted:
            return "Let's get started!"
        case .fasting:
            return "You are now fasting"
        case .feeding:
            return "You are now feeding"
        }
    }
    
    
    var body: some View {
        ZStack {
            //Mark: background
            
            Color(#colorLiteral(red: 0.04911849648, green: 0.03416168317, blue: 0.1286045909, alpha: 1))
                .ignoresSafeArea()
            
            content
        }
    }
    var content: some View {
        ZStack {
            VStack (spacing: 40) {
                //Mark: title
                Text(title)
                    .font(.headline)
                    .foregroundColor(Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)))
                
                // mark : Progress ring
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                Spacer()
            }
            .padding()
            
            VStack (spacing: 40){
                
                ProgressRing()
                    .environmentObject(fastingManager)
                
                HStack(spacing: 60) {
                    //Mark: Start time
                    
                    VStack (spacing: 5) {
                        Text(fastingManager.fastingState == .notStarted ? "Start" : "Started")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    //Mark: End Time
                    VStack (spacing: 5) {
                         Text(fastingManager.fastingState == .notStarted ? "End" : "Ends")
                            .opacity(0.7)
                        
                        Text(fastingManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
                // Mark: Button
                
                Button {
                    fastingManager.toggleFastingState()
                } label: {
                    Text(fastingManager.fastingState == .fasting ? "End fast" : "Start Fasting")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                }
            }
            .padding()
        }
            .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
