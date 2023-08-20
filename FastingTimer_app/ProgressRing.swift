//
//  ProgressRing.swift
//  FastingTimer_app
//
//  Created by teona nemsadze on 19.08.23.
//

import SwiftUI

struct ProgressRing: View {
    @EnvironmentObject var fastingManager: FastingManager
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack {
            // Markf : placeholder ring
            
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            //Mark: Colored ring
            
            Circle()
                .trim(from: 0.0, to: min(fastingManager.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)), Color(#colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1))]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270))
                .animation(.easeInOut(duration: 1.0), value: fastingManager.progress)
            VStack (spacing: 30) {
                
                if fastingManager.fastingState == .notStarted {
                    //Mark: Elapsed upcoming fast
                    
                    VStack (spacing: 5) {
                        Text("Elapsed time (\(fastingManager.progress.formatted(.percent)))")
                            .opacity(0.7)
                        Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                   }
                } else {
                    //Mark: Elapsed time
                    
                    
                    VStack (spacing: 5) {
                        if !fastingManager.elapsed {
                            
                            Text("Remaining time (\((1 - fastingManager.progress).formatted(.percent)))")
                                .opacity(0.7)
                        } else {
                            
                            Text("Extra time")
                                .opacity(0.7)
                        }
                        
                        
                        Text(fastingManager.endTime, style: .timer)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
            }
        }
        .frame(width: 250, height: 250)
        .padding()
        .onReceive(timer) { _ in
            fastingManager.track()
        }
    }
}

struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing()
            .environmentObject(FastingManager())
    }
}


