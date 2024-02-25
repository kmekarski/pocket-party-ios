//
//  ConfettiView.swift
//  WhoseLine
//
//  Created by Klaudiusz Mękarski on 24/02/2024.
//

import SwiftUI

class ConfettViewModel: ObservableObject {
    @Published var dots: [ConfettiDot]
    // Timer
    private lazy var timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
        for index in self.dots.indices {
            withAnimation(.linear(duration: 0.5)) {
                self.dots[index].move()
            }
            if self.dots[index].posY > UIScreen.main.bounds.height {
                self.dots[index].resetHeight()
            }
        }
    }
    
    
    init() {
        self.dots = []
                for _ in 0..<40 {
                    let dot = ConfettiDot()
                    self.dots.append(dot)
                }
        timer.fire()
    }
}



struct ConfettiDot {
    var posX:  Double = Double.random(in: -UIScreen.main.bounds.width / 2 ...  UIScreen.main.bounds.width / 2)
    var posY: Double = Double.random(in: -UIScreen.main.bounds.height / 2 ...  UIScreen.main.bounds.height / 2)
    var speed: CGFloat = Double.random(in: 30...90)
    var size: CGFloat = Double.random(in: 8...12)
    var color: Color = [Color.theme.logoRed, Color.theme.logoBlue, Color.theme.logoYellow].randomElement()!
    
    mutating func move() {
            self.posY += speed
    }
    
    mutating func resetHeight() {
        self.posY = -UIScreen.main.bounds.height / 2
    }
}

struct ConfettiView: View {
    @ObservedObject var vm = ConfettViewModel()

    var body: some View {
        ZStack {
            ForEach(vm.dots.indices, id: \.self) { index in
                Circle()
                    .offset(x: vm.dots[index].posX ,y: vm.dots[index].posY)
                    .frame(width: vm.dots[index].size, height: vm.dots[index].size)
                    .foregroundColor(vm.dots[index].color)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    ConfettiView()
}

