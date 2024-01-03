//
//  ContentView.swift
//  Restart
//
//  Created by Hassan Alkhafaji on 1/1/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("onboarding") var isOnboarding = true
    var body: some View {
        
            if isOnboarding {
                OnboardingView()
                    
            } else {
                HomeView()
            }
    }
}

#Preview {
    ContentView()
}
