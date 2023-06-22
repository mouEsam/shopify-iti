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
    @StateObject private var ordersViewModel: OrdersViewModel
    
    private let strings: any AnyProfileStrings
    private let stringsOrders: any AnyOrdersStrings
    private let colors: any AnyAppColors
    
    init(container: AppContainer) {
        
        strings = container.require((any AnyProfileStrings).self)
        stringsOrders = container.require((any AnyOrdersStrings).self)
        colors = container.require((any AnyAppColors).self)
        
        let authenticationManager = container.require(AuthenticationManager.self)
        _profileviewModel = .init(wrappedValue: ProfileViewModel(authenticationManager:  authenticationManager))
        
        let modelWishList = container.require((any AnyWishlistModel).self)
        let manager = container.require(WishlistManager.self)
        let notificationCenter = container.require((any AnyNotificationCenter).self)
        _wishListViewModel = .init(wrappedValue: WishlistViewModel(model: modelWishList,
                                                                   wishlistManager: manager,
                                                                   notificationCenter: notificationCenter))
        let modelOrders = container.require((any AnyOrdersModelFactory).self).create()
        _ordersViewModel = .init(wrappedValue: OrdersViewModel(model: modelOrders))
    }
    
    var body: some View {
        let name = profileviewModel.userState?.firstName
        VStack{
            if let name = name {
                Group {
                    Text(strings.welcomeLabel.localized)
                        
                    + Text(", ")
                    + Text(name)
                }
                .font(.title)
                .bold()
                ScrollView {
                    Group {
                        HStack {
                            Text(strings.orderLabel.localized)
                                .font(.title2)
                                .bold()
                                .padding()
                            Spacer()
                            Button(strings.moreLabel.localized, role: .cancel){
                                router.push(OrdersScreen.Route(container: container))
                            }.buttonStyle(.plain)
                                .foregroundColor(.black)
                                .font(.title2).padding()
                        }
                        Group {
                            switch ordersViewModel.operationState {
                                case .loaded(let data):
                                    if(data.data.isEmpty){
                                        NoResultsView(message: strings.emptyListOrders)
                                    } else {
                                        let items = Array(data.data.prefix(2))
                                        ForEach(items,id:\.id){
                                            SectionOrder(strings: stringsOrders, order: $0)
                                            Divider()
                                        }
                                    }
                                case .error(let error):
                                    ErrorMessageView(error: error)
                                case .loading:
                                    ProgressView()
                                default:
                                    Group {}
                            }
                        }
                        HStack {
                            Text(strings.wishlsitLabel.localized)
                                .font(.title2)
                                .bold()
                                .padding()
                            Spacer()
                            Button(strings.moreLabel.localized, role: .cancel){
                                router.push(WishlistScreen.Route(container: container))
                            }.buttonStyle(.plain)
                                .foregroundColor(.black)
                                .font(.title2).padding()
                        }
                        Group {
                            switch wishListViewModel.uiState {
                                case .loaded(let data):
                                    if(data.data.isEmpty) {
                                        NoResultsView(message: strings.emptyListWishList)
                                    } else {
                                        let data = Array(data.data.prefix(2))
                                        ForEach(data,id:\.id){item in
                                            WishlistItemView(container: container,
                                                             product: item.product)
                                        }
                                    }
                                case .error(let error):
                                    ErrorMessageView(error: error)
                                case .loading:
                                    ProgressView()
                                default:
                                    Group {}
                            }
                        }.padding(.horizontal)
                    }.onFirstAppear {
                        wishListViewModel.initialize()
                        Task{
                            await ordersViewModel.loadBrand()
                        }
                    }.padding()
                }
            } else {
                VStack {
                    Spacer()
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 150)
                    Text(strings.loginMessage.localized)
                        .font(.title3)
                        .multilineTextAlignment(.center)
                    Spacer()
                    RoundedButton(label: strings.loginAction,
                                  labelColor: colors.white,
                                  backgroundColor: colors.black
                    ) {
                        Task {
                            router.push(AppRoute(identifier:colors.white.hashValue, content: {
                                LoginScreen(container: container)
                            }))
                        }
                    }.frame(alignment: .bottom)
                }.padding()
            }
        }
        .onFirstAppear {
            profileviewModel.initialize()
        }
    }
}
