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
    @State private var currentUrl: URL? = nil
    
    init(image: RemoteImage?) {
        self.image = image
    }
    
    var body: some View {
        Rectangle().fill(.clear).background {
            let placeholder = Image("Logo").resizable()
            if var image = image {
                AsyncImage(url: currentUrl) { phase in
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
                }.task {
                    if currentUrl == nil {
                        await MainActor.run {
                            currentUrl = URL(string: image.url)
                        }
                    }
                }
            } else {
                placeholder
            }
        }
    }
}
