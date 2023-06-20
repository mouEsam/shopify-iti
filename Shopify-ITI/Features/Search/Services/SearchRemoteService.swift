//
//  SearchRemoteService.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct SearchRemoteService: AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: SearchRemoteService.self) { resolver in
            SearchRemoteService(remoteClient: resolver.require((any GraphQLClient).self),
                                localeProvider: resolver.require((any AnyLocaleProvider).self))
        }
    }
    
    typealias SearchError = ShopifyErrors<Any>
    
    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    
    init(remoteClient: some GraphQLClient,
         localeProvider: some AnyLocaleProvider) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
    }
    
    func fetch(query: String) async -> Result<[String], SearchError> {
        let query = ShopifyAPI.GetProductsSearchSuggestionsQuery(query: query,
                                                                 country: .init(nullable: localeProvider.shopifyCountry),
                                                                 lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.fetch(query: query)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let queries = result.data?.predictiveSearch?.queries {
                return .success(queries.map(\.text))
            } else {
                return .failure(SearchError.Unknown)
            }
        }
    }
}
