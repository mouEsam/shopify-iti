//
//  GenericErrorView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 22/06/2023.
//

import Foundation
import SwiftUI

struct GenericErrorView: View {
    
    private let error: GenericError
    
    init(error: GenericError) {
        self.error = error
    }
    
    var body: some View {
        error.text
    }
}

struct GenericErrorView_Previews: PreviewProvider {
    static var previews: some View {
        GenericErrorView(error: .init(fields: [],
                                      message: "error"))
    }
}
