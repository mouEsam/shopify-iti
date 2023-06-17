//
//  CategoryCard.swift
//  Shopify-ITI
//
//  Created by ammar on 16/06/2023.
//

import Foundation
import SwiftUI
struct CardCategory : View {
    let title: String
    var body: some View {
        VStack {
            Image(title)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 90)
                .padding(4)
            
            Text(String(title))
                .font(.callout)
                .fontWeight(.bold)
                .foregroundColor(.black).padding(4)
            
            
        }.frame(height: 150)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
        
        
    }
}
