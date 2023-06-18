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
    
    @EnvironmentRouter private var router: AppRouter
    
    
    @StateObject private var profileviewModel: ProfileViewModel
    @StateObject private var wishListViewModel: WishlistViewModel
    //    @StateObject private var ordersViewModel: OrdersViewModel
    
    init(container: AppContainer) {
        
        let authenticationManager = container.require(AuthenticationManager.self)
        _profileviewModel = .init(wrappedValue: ProfileViewModel(authenticationManager:  authenticationManager))
        
        let model = container.require((any AnyWishlistModelFactory).self).create()
        let manager = container.require(WishlistManager.self)
        let notificationCenter = container.require((any AnyNotificationCenter).self)
        _wishListViewModel = .init(wrappedValue: WishlistViewModel(model: model,
                                                                   wishlistManager: manager,
                                                                   notificationCenter: notificationCenter))
        
    }
    
    var body: some View {
        let name = profileviewModel.userState?.firstName
        ScrollView{
            if  name != nil {
                VStack{
                    Text("Welcome " + (name ?? "") )
                    
                        .font(.title)
                        .bold()
                        .padding()//TODO: nemoriztion
                    HStack{
                        Text("Orders ")
                            .font(.title2)
                            .bold()
                            .padding()//TODO: nemoriztion
                        Spacer()
                        Button("More", role: .cancel){//TODO: nemoriztion
                            print("orders")
                        }.buttonStyle(.plain)
                            .foregroundColor(.black)
                            .font(.title2).padding()
                    }
                    HStack{
                        Text("WishList ")
                            .font(.title2)
                            .bold()
                            .padding()//TODO: nemoriztion
                        Spacer()
                        Button("More", role: .cancel){//TODO: nemoriztion
                            router.push(WishlistScreen.Route(container: container))
                        }.buttonStyle(.plain)
                            .foregroundColor(.black)
                            .font(.title2).padding()
                    }
                    switch wishListViewModel.uiState {
                        case .loaded(let data):
                            let data = Array(data.data.prefix(2))
                            ForEach(data,id:\.id){item in
                                WishlistItemView(product: item.product)
                            }
                        case .error(let error):
                            Text("\(error.localizedDescription)")
                        case .loading:
                            ProgressView()
                        default:
                            Group {}
                    }
                }
            } else {
                Button("Please login") {
                    router.push(AppRoute(identifier:636, content: {
                        LoginScreen(container: container)
                    }))
                }.buttonStyle(.bordered)
                    .foregroundColor(.black)
            }
        }.onFirstAppear {
            profileviewModel.initialize()
            wishListViewModel.initialize()
//            ordersViewModel.initialize()
        }
    }
}
