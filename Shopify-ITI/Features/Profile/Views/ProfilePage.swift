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
    @State private var name : String?
    
    init(container: AppContainer) {
        
        let authenticationManager = container.require(AuthenticationManager.self)
        _profileviewModel = .init(wrappedValue: ProfileViewModel(authenticationManager:  authenticationManager))
        
        let model = container.require((any AnyWishlistModelFactory).self).create()
        let manager = container.require(WishlistManager.self)
        let notificationCenter = container.require((any AnyNotificationCenter).self)
        _wishListViewModel = .init(wrappedValue: WishlistViewModel(model: model,
                                                                   wishlistManager: manager,
                                                                   notificationCenter: notificationCenter))
        name = profileviewModel.getName()
    }
    
    var body: some View {
        if let name = name{
            ScrollView{
                VStack{
                    Text("Welcome \(name)")
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
                            router.push(AppRoute(identifier:name.count, content: {
                                WishlistScreen(container: container)
                            }
                                                ))
                        }.buttonStyle(.plain)
                            .foregroundColor(.black)
                            .font(.title2).padding()
                    }
                    List {
                        switch wishListViewModel.uiState {
                        case .loaded(let data):
                            let data = Array(data.data.prefix(2))
                            
                            ForEach(data,id:\.id){item in
                                CartProfile(product: item.product)
                            }
                            
                        case .error(let error):
                            Text("\(error.localizedDescription)")
                        case .loading:
                            ProgressView()
                        default:
                            Group {}
                        }
                    }
                    .onAppear {
                        wishListViewModel.fetch()
                    }
                    
                }
            }.onAppear(){
                self.name = profileviewModel.getName()
            }
        }
        else{
            Button("Pleas login", role: .cancel){
                router.push(AppRoute(identifier:636, content: {
                    LoginScreen(container: container)
                }))
            }.buttonStyle(.bordered)
                .foregroundColor(.black)
                .onAppear(){
                    name = profileviewModel.getName()
                }
        }
    }
    
}


struct CartProfile: View{
    let product:Product
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: URL(string:  product.featuredImage?.url ?? "")){ image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.aspectRatio(contentMode: .fit)
                .frame(width: 100,height: 100)
                .padding()
            
            Text(product.title)
                .font(.headline)
                .padding()
           
          
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(8)
     

    }

}
