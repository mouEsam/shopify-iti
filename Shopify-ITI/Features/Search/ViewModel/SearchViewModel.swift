//
//  SearchViewModel.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 20/06/2023.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published private(set) var uiState: UIState<[String]> = .initial
    @Published private(set) var suggestions: [String] = []
    @Published var input: String = ""
    
    private var fetchTask: Task<Void, Error>? = nil
    
    private let model: any AnySearchModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(model: some AnySearchModel) {
        self.model = model
        initialize()
    }
    
    private func initialize() {
        $input
            .map { query in
                if query.isEmpty {
                    self.clear()
                }
                return query
            }
            .debounce(for: 1, scheduler: DispatchQueue.global())
            .filter { query in !query.isEmpty }
            .sink { query in self.fetch(query: query) }
            .store(in: &cancellables)
        
        suggestions = model.getPreviousSearches()
    }
    
    func onSearch() {
        suggestions = model.addASearch(search: input)
    }
    
    private func clear() {
        fetch(query: "")
    }
    
    private func fetch(query: String) {
        fetchTask?.cancel()
        fetchTask = Task {
            await MainActor.run {
                self.uiState = .loading
            }
            if query.isEmpty {
                await MainActor.run {
                    self.uiState = .initial
                }
            } else {
                let result = await model.fetch(byQuery: query)
                await MainActor.run {
                    switch result {
                        case .success(let data):
                            self.uiState = .loaded(data: data)
                            break
                        case .failure(let error):
                            self.uiState = .error(error: error)
                    }
                }
            }
        }
    }
}
