//
//  LocalizationRemoteService.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation
import Shopify_ITI_SDK

struct LocalizationRemoteService: AnyInjectable {
    static func register(_ container: AppContainer) {
        container.register(type: LocalizationRemoteService.self) { resolver in
            LocalizationRemoteService(remoteClient: resolver.require((any GraphQLClient).self),
                                      localeProvider: resolver.require((any AnyLocaleProvider).self))
        }
    }
    
    typealias LocalizationError = ShopifyErrors<Any>
    
    private let remoteClient: any GraphQLClient
    private let localeProvider: any AnyLocaleProvider
    
    init(remoteClient: some GraphQLClient,
         localeProvider: some AnyLocaleProvider) {
        self.remoteClient = remoteClient
        self.localeProvider = localeProvider
    }
    
    func fetch() async -> Result<Localization, LocalizationError> {
        let query = ShopifyAPI.GetCountriesAndLanguagesQuery(country: .init(nullable: localeProvider.shopifyCountry),
                                                             lang: .init(nullable: localeProvider.shopifyLanguage))
        let result = await remoteClient.fetch(query: query)
        return result.mapError { .Client(error: $0) }.flatMap { result in
            if let localization = result.data?.localization {
                return .success(.init(item: localization))
            } else {
                return .failure(LocalizationError.Unknown)
            }
        }
    }
}
