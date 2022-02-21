//
//  ProgressRing.swift
//  FastingTimer
//
//  Created by Aravind Chowdary Kamani on 20/02/22.
//

import SwiftUI

struct ProgressRing: View {
    
    @EnvironmentObject var fastingManager : FastingManager
    
    let timer = Timer
        .publish(every: 1, on: .main, in: .common)
        .autoconnect()
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: 20)
                .foregroundColor(.gray)
                .opacity(0.1)
            
            
            Circle()
                .trim(from: 0.0, to: min(fastingManager.progress, 1.0))
                .stroke(AngularGradient(gradient: Gradient(colors: [.blue, .green, .blue]), center: .center), style: StrokeStyle(lineWidth: 15.0, lineCap: .round, lineJoin: .round))
                .rotationEffect((Angle(degrees: 270)))
                .animation(.easeInOut(duration: 1.0), value: fastingManager.progress)
            
            
            VStack(spacing: 30) {
                
                if fastingManager.fastingState == .notStarted {
                    
                    VStack(spacing: 5) {
                        Text("Upcoming fast")
                            .opacity(0.7)
                        
                        Text("\(fastingManager.fastingPlan.fastingPeriod.formatted()) Hours")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    
                } else {
                    VStack(spacing: 5) {
                        Text("Elapsed Time (\(fastingManager.progress.formatted(.percent)))")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, style: .timer)
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .padding(.top)
                    
                    VStack(spacing: 5) {
                        
                        Text(fastingManager.elapsed != true ? "Remaining Time" : "Extra time")
                            .opacity(0.7)
                        
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
