//
//  Author.swift
//  GoHomeFast
//
//  Created by Kumo on 2020/1/15.
//  Copyright © 2020 Kumo. All rights reserved.
//

import SwiftUI

struct Author: View {
    @State private var degrees: Double = 0
    @State private var newDegrees: Double = 0
    @State private var moveDistance: CGFloat = 0
    @State private var opacity: Double = 1
    var body: some View {
        VStack{
            heartMove(moveDistance: $moveDistance, opacity: $opacity)
            VStack(alignment: .leading, spacing: 50) {
                Image("dog")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                    .clipped()
                    .rotationEffect(Angle.degrees(degrees))
                    .gesture(RotationGesture()
                        .onChanged { angle in
                            self.degrees = self.newDegrees + angle.degrees
                    }.onEnded { angle in
                        self.newDegrees = self.degrees
                    })
                Group{
                    Text("版本: 1.0")
                    HStack {
                        Text("作者: kumo")
                        Group{
                            LottieView(filename: "star")
                                .frame(width: 50, height: 50)
                            LottieView(filename: "star")
                                .frame(width: 50, height: 50)
                            LottieView(filename: "star")
                                .frame(width: 50, height: 50)
                        }
                    }
                    Text("製作日期: 2020/01/14")
                }
            }
        }
    }
}

struct Author_Previews: PreviewProvider {
    static var previews: some View {
        Author()
    }
}

struct heartMove: View {
    @Binding var moveDistance: CGFloat
    @Binding var opacity: Double
    var body: some View {
        HStack {
            Image("heart")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 25)
                .offset(x: moveDistance, y: 0)
                .opacity(opacity)
            Spacer()
        }
        .onAppear {
            self.moveDistance += 500
            self.opacity -= 0.2
        }
        .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
    }
}
