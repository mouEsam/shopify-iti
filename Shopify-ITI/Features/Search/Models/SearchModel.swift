//
//  SearchModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation

protocol AnySearchModel {
    func fetch(byQuery query: String) async -> Result<SourcedData<[String]>, ShopifyErrors<Any>>
    func getPreviousSearches() -> [String]
    func addASearch(search: String) -> [String]
}

struct SearchModel: AnySearchModel, AnyInjectable {
     static func register(_ container: AppContainer) {
         container.register(type: (any AnySearchModel).self, scope: .transient) { resolver in
            SearchModel(remoteService: resolver.require(SearchRemoteService.self),
                        localStore: resolver.require((any AnyPreviousSearchesStore).self))
        }
    }
    
    private let remoteService: SearchRemoteService
    private let localStore: any AnyPreviousSearchesStore
    
    init(remoteService: SearchRemoteService,
         localStore: some AnyPreviousSearchesStore) {
        self.remoteService = remoteService
        self.localStore = localStore
    }
    
    func fetch(byQuery query: String) async -> Result<SourcedData<[String]>, ShopifyErrors<Any>> {
        let result = await remoteService.fetch(query: query)
        return result.map { .remote($0) }
    }
    
    func getPreviousSearches() -> [String] {
        return localStore.read() ?? []
    }
    
    func addASearch(search: String) -> [String] {
        var suggestions = [search]
        let searches = self.getPreviousSearches()
        if searches.contains(where: { search == $0  }) != true {
            suggestions.append(contentsOf: searches)
            localStore.write(searches: suggestions)
        }
        return suggestions
    }
}
