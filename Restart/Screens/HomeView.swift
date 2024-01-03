//
//  HomeView.swift
//  Restart
//
//  Created by Hassan Alkhafaji on 1/1/24.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("onboarding") var isOnboarding = false
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            //MARK: HEADER
            
            Spacer()
            ZStack {
                
                CircleGroupView(shapeColor: .gray, shapeOpacity: 0.1)
                
                Image("character-2")
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .offset(y: isAnimating ? 35 : -35)
                    .animation(.easeInOut(duration: 4).repeatForever(), value: isAnimating)
            }
            
            //MARK: CENTER
            
            Text("The time that leads to mastery is the dependent on the intensity of our focus")
                .font(.title3)
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            //MARK: Footer
            
            Spacer()
            
            Button(action: {
                // some action
                withAnimation {
                    playSound(sound: "success", type: "m4a")
                    isOnboarding = true
                }
                
            }, label: {
                Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                    .imageScale(.large)
                Text("Restart")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
            })
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .controlSize(.large)
        }// END VSTACK
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                isAnimating = true
            })
        })
        
    }
}

#Preview {
    HomeView()
}
