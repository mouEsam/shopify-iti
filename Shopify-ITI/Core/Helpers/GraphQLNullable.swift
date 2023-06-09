//
//  GraphQLNullable.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 08/06/2023.
//

import Foundation
import Shopify_ITI_SDK

extension GraphQLNullable {
  public init(nullable: Optional<Wrapped>) {
      switch nullable {
          case .some(let data):
              self = .some(data)
          case .none:
              self = .none
      }
  }
}
