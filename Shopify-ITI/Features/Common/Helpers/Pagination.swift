//
//  Pagination.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 14/06/2023.
//

import Foundation

struct PageResult<T> {
    let list: [T]
    let pageInfo: PageInfo
}

extension PageResult: Equatable where T: Equatable {}

struct PageInfo {
    let nextCursor: String?
    let hasNextCursor: Bool
}

extension PageInfo: Equatable {}
