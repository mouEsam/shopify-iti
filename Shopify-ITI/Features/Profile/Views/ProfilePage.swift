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
    
    private let strings: any AnyProfileStrings
    private let colors: any AnyAppColors
    
    init(container: AppContainer) {
        
        strings = container.require((any AnyProfileStrings).self)
        colors = container.require((any AnyAppColors).self)
        
        let authenticationManager = container.require(AuthenticationManager.self)
        _profileviewModel = .init(wrappedValue: ProfileViewModel(authenticationManager:  authenticationManager))
        
        let model = container.require((any AnyWishlistModel).self)
        let manager = container.require(WishlistManager.self)
        let notificationCenter = container.require((any AnyNotificationCenter).self)
        _wishListViewModel = .init(wrappedValue: WishlistViewModel(model: model,
                                                                   wishlistManager: manager,
                                                                   notificationCenter: notificationCenter))
        
        
    }
    
    var body: some View {
        let name = profileviewModel.userState?.firstName
        VStack{
            if  name != nil {
                Text("Welcome " + (name ?? "") )
                    .font(.title)
                    .bold()
                    .padding()//TODO: nemoriztion
                
                HStack{
                    Text("Orders")
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
                    Text("WishList")
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
                Group {
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
                .padding(.horizontal)
                
            }
            
         else {
             Spacer()
             Text("Please login to show orders and wishlist").font(.title)
             Spacer()
            RoundedButton(label: strings.loginAction.localized,
                       labelColor: colors.white,
                       backgroundColor: colors.black
            ) {
                Task {
                    router.push(AppRoute(identifier:colors.white.hashValue, content: {
                        LoginScreen(container: container)
                    }))
                }
            }.padding(.all)
            
        }
            
    }.frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          ).onFirstAppear {
        profileviewModel.initialize()
        wishListViewModel.initialize()
        //            ordersViewModel.initialize()
    }
}
}
