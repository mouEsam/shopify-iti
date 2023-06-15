//
//  ProductPage.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import SwiftUI

struct ProductPage: View {
    
    @EnvironmentObject private var container: AppContainer

    @StateObject private var viewModel: ProductViewModel
    
    init(container: AppContainer, productId: String) {
        let model = container.require((any AnyProductModelFactory).self).create()
        let manager = container.require(WishlistManager.self)
        _viewModel = .init(wrappedValue: ProductViewModel(productId:productId,
                                                          model: model,
                                                          wishlistManager: manager))
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .onFirstTask {
            await viewModel.fetch()
        }
    }
}
