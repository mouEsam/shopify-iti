//
//  RemoteImageView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 19/06/2023.
//

import Foundation
import SwiftUI

struct RemoteImageView: View {
    private let image: RemoteImage?
    
    init(image: RemoteImage?) {
        self.image = image
    }
    
    var body: some View {
        Rectangle().fill(.clear).background {
            let placeholder = Image("Logo").resizable()
            if let image = image {
                AsyncImage(url: URL(string:  image.url)) { image in
                    image.resizable().onAppear {
                        print("ASDASD")
                    }
                } placeholder: {
                    placeholder.onAppear {
                        print("ETERT")
                    }
                }
            } else {
                placeholder
            }
        }
    }
}
