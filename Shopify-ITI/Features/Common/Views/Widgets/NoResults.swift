//
//  NoResults.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 21/06/2023.
//

import Foundation
import SwiftUI

struct NoResultsView: View {
    
    private let message: String
    
    init(message: String) {
        self.message = message
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "nosign")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 150)
            Text(message.localized)
                .font(.title)
                .multilineTextAlignment(.center)
        }
    }
}

struct NoResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NoResultsView(message: "Hello, world!")
    }
}
