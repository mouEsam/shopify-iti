//
//  PriceRangeView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 19/06/2023.
//

import Foundation
import SwiftUI

struct PriceRangeView: View {
    
    private let priceRange: PriceRange
    
    init(priceRange: PriceRange) {
        self.priceRange = priceRange
    }
    
    var body: some View {
        Group {
            let min = priceRange.minPrice.amount
            let max = priceRange.maxPrice.amount
            
            let minS = moneyFormatter().string(from: NSNumber(value: min))
            if min != max,
               let min = minS,
               let max = moneyFormatter(false).string(from: NSNumber(value: max)) {
                Text(min) + Text(" - ") + Text(max)
            } else if let min = minS {
                Text(min)
            }
        }
    }
    
    private func moneyFormatter(_ showCurrency: Bool = true) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if showCurrency {
            formatter.currencyCode = priceRange.minPrice.currencyCode.rawValue
        } else {
            formatter.currencyCode = ""
            formatter.currencySymbol = ""
        }
        formatter.locale = Locale.current // Use the current locale for currency symbol and formatting
        return formatter
    }
}

struct PriceRangeView_Previews: PreviewProvider {
    static var previews: some View {
        PriceRangeView(priceRange: .init(minPrice: .init(amount: 10,
                                                         currencyCode: .egp),
                                         maxPrice: .init(amount: 40,
                                                         currencyCode: .egp)))
    }
}

