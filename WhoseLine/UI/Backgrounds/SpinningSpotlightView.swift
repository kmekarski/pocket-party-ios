//
//  SpinningSpotlightView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 20/02/2024.
//

import SwiftUI

struct SpinningSpotlightView: View {
    @State var animate = false
    var numberOfBeams = 8
    var colors = [Color.white]
    var speed: Int = 10

    var body: some View {
        ZStack {
            ForEach(0..<numberOfBeams, id: \.self) { index in
                let rotation = Angle(degrees: Double(index) * 360/Double(numberOfBeams))
                let offsetX = CGFloat(cos(rotation.radians) * 300)
                let offsetY = CGFloat(sin(rotation.radians) * 300)
                Trapezoid(slope: 0.5)
                    .fill(colors[index % colors.count].opacity(0.5))
                    .frame(width: 2000/CGFloat(numberOfBeams), height: 550)
                    .rotationEffect(.degrees(-90))
                    .rotationEffect(rotation)
                    .offset(x: offsetX, y: offsetY)
            }
        }
        .blur(radius: 12)
        .rotationEffect(.init(degrees: self.animate ? 360 : 0))
        .animation(Animation.linear(duration: TimeInterval(200/speed)).repeatForever(autoreverses: false), value: animate)
        .onAppear {
            self.animate.toggle()
        }
    }
}

#Preview {
    ZStack {
        Color.theme.background.ignoresSafeArea()
        SpinningSpotlightView(numberOfBeams: 8)
    }
}
