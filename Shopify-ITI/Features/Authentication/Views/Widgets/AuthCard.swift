//
//  AuthCard.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation
import SwiftUI

struct AuthCard<Content: View>: View {
    
    private let content: () -> Content
    private let backgroundColor: Color
    private let shadowColor: Color
    
    init(shadowColor: Color,
         backgroundColor: Color,
         @ViewBuilder content: @escaping () -> Content) {
        self.shadowColor = shadowColor
        self.backgroundColor = backgroundColor
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: 18, content: content)
        .frame(maxWidth: .infinity)
        .padding()
        .padding(.vertical, 20)
        .background(Rectangle().fill(backgroundColor))
        .shadow(color: shadowColor,
                radius: 16,
                x: 0,
                y: 16)
        .padding(.horizontal, 18)
        
    }
}

