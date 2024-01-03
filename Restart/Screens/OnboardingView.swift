//
//  OnboardingView.swift
//  Restart
//
//  Created by Hassan Alkhafaji on 1/1/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @AppStorage("onboarding") var isOnboarding = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var indicatorOpacity: Double = 1.0
    @State private var textTitle: String = "Share"
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                // MARK: Header
                VStack(spacing: 0) {
                    Text(textTitle)
                        .foregroundColor(.white)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .transition(.opacity)
                    
                    Text("""
It's not how much we give, but how much love we put into giving.
""")
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 10)
                    
                }
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                // MARK: Center
                ZStack {
                    
                    CircleGroupView(shapeColor: .white, shapeOpacity: 0.2)
                        .offset(x: imageOffset.width * -1)
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 1), value: isAnimating)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20)))
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if abs(imageOffset.width) <= 150 {
                                        imageOffset = gesture.translation
                                        
                                        withAnimation(.linear(duration: 0.25)) {
                                            
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                            
                                        }
                                    }
                                }
                                .onEnded{ _ in
                                        imageOffset = .zero
                                    
                                    withAnimation(.linear(duration: 0.25)) {
                                        
                                        indicatorOpacity = 1
                                        textTitle = "Share."
                                    }
                                }
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    
                }// END CENTER
                .overlay(
                Image(systemName: "arrow.left.and.right.circle")
                    .font(.system(size: 44, weight: .ultraLight))
                    .offset(y: 20)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                    .opacity(indicatorOpacity)
                    .foregroundColor(.white)
                , alignment: .bottom
                )
                
                Spacer()
                //MARK: Footer
                
                ZStack {
                    // BACKGROOUND
                    Capsule()
                        .fill(.white.opacity(0.2))
                    
                    Capsule()
                        .fill(.white.opacity(0.2))
                        .padding(8)
                    // CALL TO ACTION - STATIC
                    
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // CAPSULE - DYNAMIC WIDTH
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    
                    // CIRCLE DRAGGABLE
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    if gesture.translation.width > 0  && buttonOffset <= buttonWidth - 80
                                    {
                                        buttonOffset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.easeIn(duration: 1)) {
                                        if buttonOffset > buttonWidth / 2 {
                                            withAnimation(.easeInOut(duration: 0.8)) {
                                                
                                                hapticFeedback.notificationOccurred(.success)
                                                playSound(sound: "chimeup", type: "mp3")
                                                buttonOffset = buttonWidth - 80
                                                isOnboarding = false
                                            }
                                        } else {
                                            withAnimation(.easeOut(duration: 0.4)) {
                                                hapticFeedback.notificationOccurred(.warning)
                                                buttonOffset = 0
                                            }
                                        }
                                    }
                                }
                        )
                        
                        
                        Spacer()
                    }
                    
                }// END OF FOOTER
                .frame(width: buttonWidth,height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
            }
        } // END VSTACK
        .onAppear(perform: {
            isAnimating = true
        })
        .preferredColorScheme(.dark)
    }
}

#Preview {
    OnboardingView()
}
