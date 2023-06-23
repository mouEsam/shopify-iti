//
//  PriceView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 19/06/2023.
//

import Foundation
import SwiftUI

struct PriceView: View {
    
    @EnvironmentObject private var container: AppContainer
    private let price: Price
    
    init(price: Price) {
        self.price = price
    }
    
    var body: some View {
        Group {
            let price = price.amount
            if let price = moneyFormatter().string(from: NSNumber(value: price)) {
                Text(price)
            } else {
                Text("N/A")
            }
        }
    }
    
    private func moneyFormatter(_ showCurrency: Bool = true) -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = container.require((any AnyLocaleProvider).self).locale
        formatter.numberStyle = .currency
        formatter.currencyCode = price.currencyCode.rawValue
        return formatter
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(price: .init(amount: 10, currencyCode: .egp))
    }
}

