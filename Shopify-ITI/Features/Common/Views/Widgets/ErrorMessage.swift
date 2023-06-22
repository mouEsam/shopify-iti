//
//  ErrorMessage.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 21/06/2023.
//

import Foundation
import SwiftUI

struct ErrorMessageView: View {
    
    private let content: () -> AnyView
    
    init(message: String) {
        self.content = {
            AnyView(Text(message.localized)
                .font(.title)
                .multilineTextAlignment(.center))
        }
    }
    
    init(error: Error) {
        self.content = {
            AnyView(ErrorView(error: error))
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "xmark.circle")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 150)
            content()
        }
    }
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorMessageView(message: "Hello, world!")
    }
}
