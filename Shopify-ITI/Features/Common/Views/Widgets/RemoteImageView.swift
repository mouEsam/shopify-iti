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
                AsyncImage(url: URL(string:  image.url)) { (phase: AsyncImagePhase) in
                    switch phase {
                        case .success(let image):
                            image.resizable()
                        case .empty:
                            placeholder
                        case .failure(_):
                            placeholder
                        @unknown default:
                            placeholder
                    }
                }
            } else {
                Image("Logo").resizable()
            }
        }
    }
}
