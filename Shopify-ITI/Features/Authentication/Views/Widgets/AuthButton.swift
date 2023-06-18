//
//  AuthButton.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation
import SwiftUI

struct AuthButton: View {
    
    private let label: String
    private let labelColor: Color
    private let backgroundColor: Color
    private let action: () -> Void
    private let isLoading: Bool
    
    init(label: String,
         labelColor: Color,
         backgroundColor: Color,
         isLoading: Bool = false,
         action: @escaping () -> Void) {
        self.label = label
        self.labelColor = labelColor
        self.backgroundColor = backgroundColor
        self.isLoading = isLoading
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .padding(10)
                if isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                }
            }.frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .background(RoundedRectangle(cornerRadius: 6)
            .fill(backgroundColor))
        .foregroundColor(labelColor)
    }
}

