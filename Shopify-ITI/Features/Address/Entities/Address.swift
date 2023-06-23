//
//  Adress.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 23/06/2023.
//

import Foundation

struct Address: Identifiable {
    let id = UUID()
    let street: String
    let city: String
    let state: String
    let postalCode: String
    
    init(street: String, city: String, state: String, postalCode: String) {
        self.street = street
        self.city = city
        self.state = state
        self.postalCode = postalCode
    }
    
    static func fromString(_ addressString: String) -> Address? {
        let components = addressString.components(separatedBy: ", ")
        guard components.count == 4 else {
            return nil
        }
        
        let street = components[0]
        let city = components[1]
        let state = components[2]
        let postalCode = components[3]
        
        return Address(street: street, city: city, state: state, postalCode: postalCode)
    }
    
    func toString() -> String {
        return "\(street), \(city), \(state), \(postalCode)"
    }
}
