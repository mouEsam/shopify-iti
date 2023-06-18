//
//  AuthTextField.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 18/06/2023.
//

import Foundation
import SwiftUI

struct AuthTextField: View {
    
    private let label: String
    private let hint: String
    private let error: String?
    private let text: Binding<String>
    private let strokeColor: Color
    private let obsecurable: Bool
    
    @State private var obsecured: Bool
    
    init(text: Binding<String>,
         label: String,
         hint: String,
         error: String? = nil,
         strokeColor: Color,
         obsecurable: Bool = false) {
        self.text = text
        self.label = label
        self.hint = hint
        self.error = error
        self.strokeColor = strokeColor
        self.obsecurable = obsecurable
        self.obsecured = obsecurable
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(label)
                        .font(.footnote)
                        .foregroundColor(strokeColor)
                    Group {
                        if obsecured {
                            SecureField(hint, text: text)
                        } else {
                            TextField(hint, text: text)
                        }
                    }.frame(height: 25)
                    
                }
                if obsecurable {
                    Button {
                        obsecured = !obsecured
                    } label: {
                        Image(systemName: obsecured ? "eye.slash" : "eye")
                    }.buttonStyle(.plain)
                        .padding(10)
                }
            }
            if let error = error {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 4)
            .stroke(strokeColor, lineWidth: 1))
    }
}
