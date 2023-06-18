//
//  AuthTopBarDecor.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation
import SwiftUI

struct AuthTopBarDecor: View {
    
    private let barColor: Color
    private let circleColor: Color
    
    init(barColor: Color, circleColor: Color) {
        self.barColor = barColor
        self.circleColor = circleColor
    }
    
    var body: some View {
        HStack(spacing: 20) {
            let bar = Rectangle()
                .fill(barColor)
                .frame(maxHeight: 2)
            bar
            Image(systemName: "touchid")
                .resizable()
                .renderingMode(.template)
                .aspectRatio(1, contentMode: .fit)
                .frame(maxHeight: 50)
                .clipShape(Circle())
                .padding(5)
                .background(Circle()
                    .stroke(circleColor))
                .foregroundColor(circleColor)
            bar
        }
        .padding(.horizontal, 24)
    }
}
