//
//  ProfilePage.swift
//  Shopify-ITI
//
//  Created by ammar on 12/06/2023.
//

import Foundation
import SwiftUI

struct ProfilePage: View {
    
    @EnvironmentObject private var container: AppContainer
    
    @State private var validationError: String?
    @StateObject private var viewModel: ProfleViewModel
    
    init(container: AppContainer) {
        let repo = container.require((any AnyProfileRepository).self)
        _viewModel = .init(wrappedValue: ProfleViewModel(repository: repo))
    }
    
    var body: some View {
        Text("Profile View ")
        

    }
}
