//
//  ProductPage.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 09/06/2023.
//

import SwiftUI

struct ProductPage: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .task {
            let client = ApolloGraphQLClient(environment: StorefronEnvironmentProvider())
            let localeProvider = LocaleProvider()
            let configsProvider = ConfigsProvider()
            let service = ProductRemoteService(remoteClient: client,
                                               localeProvider: localeProvider,
                                               configsProvider: configsProvider)
            let result = await service.fetch(byId: "gid://shopify/Product/8341864055063")
            dump(result)
        }
    }
}

struct ProductPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductPage()
    }
}
