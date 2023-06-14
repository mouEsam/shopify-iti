//
//  AdsView.swift
//  Shopify-ITI
//
//  Created by ammar on 14/06/2023.
//

import SwiftUI

struct AdsView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Ad")
                .padding()
            
            Spacer()
        }
        .frame(maxWidth:.infinity)
        .frame(height: 300)
        .background(Color.gray)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


struct AdsView_Previews: PreviewProvider {
    static var previews: some View {
        AdsView()
    }
}
