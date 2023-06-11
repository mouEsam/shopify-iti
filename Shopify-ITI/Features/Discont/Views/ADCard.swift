//
//  ADCard.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 11/06/2023.
//

import SwiftUI
import UniformTypeIdentifiers

struct ADCard: View {
    let card: AD
    @State private var showAlert = false

    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                Image(card.adImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .cornerRadius(10)
                    .onTapGesture(count: 1) {
                        showAlert = true
                    }
                    .alert(isPresented: $showAlert)  {
                        Alert(
                            title: Text("Coupons"),
                            message: {
                                var message = Text(card.adMessage).font(.body)
                                message = message + Text("\n\nCoupons: \(card.coupons)").font(.caption)
                                return message
                            }(),
                            primaryButton: .default(Text("Copy Coupon"), action: {
                                UIPasteboard.general.setValue(card.coupons, forPasteboardType: UTType.plainText.identifier)
                            }),
                            secondaryButton: .cancel(Text("OK"))
                        )
                    }
            }
        }.padding(.all)
    }

}
