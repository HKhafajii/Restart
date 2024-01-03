//
//  CircleGroupView.swift
//  Restart
//
//  Created by Hassan Alkhafaji on 1/2/24.
//

import SwiftUI

struct CircleGroupView: View {
    
    @State var shapeColor: Color
    @State var shapeOpacity: Double
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 50)
                .frame(width: 260, height: 260, alignment: .center)
            
            Circle()
                .stroke(shapeColor.opacity(shapeOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
            
        }
        .blur(radius: isAnimating ? 0 : 10)
        .opacity(isAnimating ? 1 : 0)
        .scaleEffect(isAnimating ? 1 : 0.5)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear(perform: {
            isAnimating = true
        })
    }
}

#Preview {
    ZStack {
        Color.black
            .ignoresSafeArea()
        CircleGroupView(shapeColor: .red, shapeOpacity: 0.2)
    }
}
