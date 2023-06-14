//
//  CardBrand.swift
//  Shopify-ITI
//
//  Created by ammar on 14/06/2023.
//

import SwiftUI

struct CardBrand : View {
    let imageName: String
    let title: String
    
    var body: some View {
        NavigationLink(destination: SearchView()){
            VStack {
                AsyncImage(url: URL(string: imageName)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .padding()
                
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                
            }.background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)
        }
    }
}


struct CardBrand_Previews: PreviewProvider {
    static var previews: some View {
        CardBrand(imageName: "amar",title: "amar")
    }
}
