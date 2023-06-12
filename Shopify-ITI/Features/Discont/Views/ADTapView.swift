//
//  ADTapView.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 11/06/2023.
//

import SwiftUI
struct ADTapView: View {
    @State private var currentPage = 0
    var cards = ADModel.getAds()
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(cards.indices, id: \.self) { index in
                ADCard(card: cards[index])

            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
        .onAppear {
            startTimer()
        }
    }
    
    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            withAnimation {
                currentPage = (currentPage + 1) % cards.count
            }
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
