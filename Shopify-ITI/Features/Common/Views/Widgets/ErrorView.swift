//
//  ErrorView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 22/06/2023.
//

import Foundation
import Shopify_ITI_SDK
import SwiftUI

struct ErrorView: View {
    
    private let error: any Error
    
    init(error: some Error) {
        self.error = error
    }
    
    var body: some View {
        error.text
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: LocalErrors.NotFound)
    }
}
