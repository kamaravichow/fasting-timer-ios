//
//  ContentView.swift
//  FastingTimer
//
//  Created by Aravind Chowdary Kamani on 20/02/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var fastingManager = FastingManager()
    
    var title : String {
        switch (fastingManager.fastingState) {
        case .notStarted:
            return "Let's fast right now"
        case .fasting:
            return "Keep doing great"
        case .feeding:
            return "Eat to your stomach, not heart"
        }
    }
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.05945179611, green: 0.008803118952, blue: 0.1038201228, alpha: 1))
                .ignoresSafeArea()
            
            content
        }
    }
    
    var content : some View {
        ZStack {
            VStack(spacing: 40) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text(fastingManager.fastingPlan.rawValue)
                    .fontWeight(.bold)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                
                Spacer()
            }
            .padding()
            
            VStack(spacing: 40) {
                
                ProgressRing()
                    .environmentObject(fastingManager)
                
                
                HStack(spacing: 60){
                    
                    VStack(spacing: 5){
                        Text(fastingManager.fastingState ==  FastingState.notStarted ? "Start" : "Started")
                            .opacity(0.7)
                        
                        Text(fastingManager.startTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                    
                    VStack(spacing: 5){
                        Text(fastingManager.fastingState ==  FastingState.notStarted ? "End" : "Ends")
                            .opacity(0.7)
                        
                        Text(fastingManager.endTime, format: .dateTime.weekday().hour().minute().second())
                            .fontWeight(.bold)
                    }
                }
                
                
                Button(action: { fastingManager.toggleFastingState() }) {
                    Text(fastingManager.fastingState == FastingState.fasting ? "End fasting": "Start fasting")
                        .font(.title3)
                        .fontWeight(.bold)
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
