//
//  Resource.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation

enum Resource<T> {
    case loading
    case none
    case data(data: T)
    case error(error: Error)
}

enum BareResource: Equatable, Hashable {
    case loading
    case none
    case loaded
    case error
}

extension Resource {
    var bare: BareResource {
        switch self {
            case .loading:
                return .loading
            case .error(_):
                return .error
            case .none:
                return .none
            default:
                return .loaded
        }
    }
    
    var data: T? {
        if case .data(let data) = self {
            return data
        }
        return nil
    }
    
    var error: Error? {
        if case .error(let error) = self {
            return error
        }
        return nil
    }
    
    var isNone: Bool {
        if case .none = self {
            return true
        }
        return false
    }
    
    var isLoading: Bool {
        if case .loading = self {
            return true
        }
        return false
    }
    
    var isLoaded: Bool {
        if case .data(_) = self {
            return true
        }
        return false
    }
    
    var isError: Bool {
        if case .error(_) = self {
            return true
        }
        return false
    }
}
