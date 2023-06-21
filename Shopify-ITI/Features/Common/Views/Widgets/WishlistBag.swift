//
//  WishlistBag.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 19/06/2023.
//

import Foundation
import SwiftUI

struct WishlistBag: View {
    
    @State private var task: Task<Any, Error>? = nil
    private let onWishlisted: (() async -> Void)?
    private let isWishlisted: Bool
    
    init(isWishlisted: Bool,
         onWishlisted: (() async -> Void)? = nil) {
        self.isWishlisted = isWishlisted
        self.onWishlisted = onWishlisted
    }
    
    var body: some View {
        Group {
            GeometryReader { reader in
                let wishlisted = Rectangle()
                    .fill(.clear)
                    .overlay {
                        Image(systemName: isWishlisted ? "bag.fill" : "bag")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                    }
                    .padding(reader.size.width * 0.08)
                if let onWishlisted = onWishlisted {
                    Button(action: {
                        task?.cancel()
                        task = Task { await onWishlisted() }
                    }) {
                        wishlisted
                    }
                } else {
                    wishlisted.padding(8)
                }
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .buttonStyle(.bordered)
    }
}

struct WishlistBag_Previews: PreviewProvider {
    static var previews: some View {
        WishlistBag(isWishlisted: true)
        WishlistBag(isWishlisted: true) {}
    }
}

