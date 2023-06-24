//
//  AnyCartIdStore.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 17/06/2023.
//

import Foundation
protocol AnyCartIdStore{
    func exists() -> Bool
    func read() -> Result<String, LocalErrors>
    func write(id: String) -> Result<Void, LocalErrors>
    func delete()
}
