//
//  VariantItemView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 19/06/2023.
//

import Foundation
import SwiftUI

struct VariantItemView: View {
    
    @EnvironmentObject private var container: AppContainer
    @EnvironmentRouter private var router: AppRouter
    private let colors: AnyAppColors
    private let onSelected: (() -> Void)?
    private let variant: ProductVariant
    private let isSelected: Bool
    
    init(container: AppContainer,
         variant: ProductVariant,
         isSelected: Bool,
         onSelected: (() -> Void)? = nil) {
        self.colors = container.require((any AnyAppColors).self)
        self.variant = variant
        self.isSelected = isSelected
        self.onSelected = onSelected
    }
    
    var body: some View {
        let view = VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                RemoteImageView(image: variant.image)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                if isSelected {
                    Image(systemName: "checkmark.circle").padding(8)
                        .foregroundColor(colors.white)
                }
            }.frame(maxWidth: .infinity)
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(variant.title)
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                Spacer().frame(height: 8)
                if let sku = variant.sku {
                    Text(sku).font(.caption2)
                }
                Spacer().frame(height: 16)
                PriceView(price: variant.price)
                    .font(.caption)
            }
            .padding()
        }
            .background(colors.white)
            .foregroundColor(colors.black)
            .overlay {
                if isSelected {
                    RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 4)
                }
            }
            .cornerRadius(10)
            .shadow(radius: 2)
        if let onSelected = onSelected {
            Button(action: onSelected) {
                view
            }
        } else {
            view
        }
    }
}

struct VariantItemView_Previews: PreviewProvider {
    static var previews: some View {
        VariantItemView(container: AppContainer.preview(),
                        variant: .init(id: "id",
                                       title: "title",
                                       image: nil,
                                       barcode: nil,
                                       sku: nil,
                                       availableForSale: true,
                                       quantityAvailable: 3,
                                       price: .init(amount: 10, currencyCode: .egp)),
                        isSelected: true)
    }
}
