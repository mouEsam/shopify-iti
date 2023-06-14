//
//  ProfilePage.swift
//  Shopify-ITI
//
//  Created by ammar on 12/06/2023.
//

import Foundation
import SwiftUI

struct ProfilePage: View {
    var body: some View {
        NavigationView {
            Text("Profile View ")
                .navigationBarItems(
                    trailing:
                        HStack {
                           
                            NavigationLink(destination: SettingView()) {
                                Image(systemName: "gearshape")
                            }
                        }
                )
            
        }
    }
}
