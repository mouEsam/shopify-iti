//
//  LocalErrorView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 22/06/2023.
//

import Foundation
import SwiftUI

struct LocalErrorView: View {
    
    private let error: LocalErrors
    
    init(error: LocalErrors) {
        self.error = error
    }
    
    var body: some View {
        error.text
    }
}

struct LocalErrorView_Previews: PreviewProvider {
    static var previews: some View {
        LocalErrorView(error: .NotFound)
    }
}
