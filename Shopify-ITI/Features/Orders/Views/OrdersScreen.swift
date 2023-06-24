//
//  OrdersScreen.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import SwiftUI

struct OrdersScreen: View {
    class Route: AppRoute {
        convenience init(container: AppContainer) {
            self.init(identifier: String(describing: Self.self)) {
                OrdersScreen(container: container)
            }
        }
    }

    
    @StateObject private var viewModel:  OrdersViewModel
    
    private let strings : AnyOrdersStrings
    
    init(container: AppContainer) {
        let model = container.require((any AnyOrdersModelFactory).self).create()
        _viewModel = .init(wrappedValue:OrdersViewModel(model: model))
        
        strings = container.require((any AnyOrdersStrings).self)
    }
    
    var body: some View {
        Group{
            switch viewModel.operationState {
            case .loaded(let data):
                if(data.data.isEmpty){
                    NoResultsView(message: strings.emptyList)
                }
                else{
                    ScrollView{
                        ForEach(data.data,id:\.id){
                            SectionOrder(strings: strings, order: $0)
                            Divider()
                        }
                    }.scrollIndicators(.hidden)
                    
                }
                
            case .error(let error):
                Text("\(error.localizedDescription)")
            case .loading:
                ProgressView()
            default:
                Group {}
            }
        }.padding(.horizontal)
            .onFirstAppear {
                Task{
                    await viewModel.loadBrand()
                }
            }
    }
}

struct SectionOrder : View {
  
    let strings : AnyOrdersStrings
    let order:Order
    
    init(strings: AnyOrdersStrings, order: Order) {
        self.strings = strings
        self.order = order
    }
    
    var body: some View {
       
            Section(header: Text(strings.orderNumber.localized) + Text(" : ") + Text(String(order.id)),
                    footer: HStack {
                Text(strings.totalPrice.localized) + Text(" : ")
                PriceView(price: order.totalPrice)
            }) {
                ForEach(order.lineItems,id:\.id){
                    CardOrder(lineItem: $0,strings: strings)
                }.background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2).padding(4)
                
            } .headerProminence(.increased)
        }
    
}

struct CardOrder : View {
    @EnvironmentRouter private var router: AppRouter
    @EnvironmentObject private var container: AppContainer
    let lineItem : LineItem
    let strings : AnyOrdersStrings
    var body: some View {
        Button(action: {
            router.push(ProductPage.Route(container: container, productId: lineItem.product.id))
        }) {
            HStack(alignment: .top) {
                RemoteImageView(image: lineItem.product.featuredImage)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, alignment: .center)
                    .padding()
                
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(lineItem.product.title)
                            .font(.headline)
                        Spacer()
                    }
                    Spacer().frame(height: 8)
                    Group {
                        Text(strings.quantityItem.localized)
                        + Text(" ")
                        + Text(String(lineItem.currentQuantity))
                    }
                    .font(.caption2)
                    Spacer().frame(height: 16)
                    PriceView(price: lineItem.originalTotalPrice)
                }
                .padding()
            }
            
        }
        
    }
}


