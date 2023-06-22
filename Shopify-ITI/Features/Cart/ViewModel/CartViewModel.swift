//
//  CartViewModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 14/06/2023.
//

import Foundation
import Combine
//let testCart = "gid://shopify/Cart/c1-d4bd72d94eefdef6dcfc7cbfb06ea5fa"
class CartViewModel:ObservableObject{
    private let model:AnyCartModel
    private let cartManager:CartManager
    @Published private(set) var operationState: UIState<Cart> = .initial
    var uiStatePublisher: Published<UIState<Cart>>.Publisher { $operationState }
    init(model: AnyCartModel,cartManager:CartManager) {
        self.model = model
        self.cartManager = cartManager
    }
    func getCart()async{
        await MainActor.run{
            operationState = .loading
        }
        let res = await model.getCart().toRemote()
        
        await showCart(uiStat: res)
    }
    private func showCart(uiStat:UIState<Cart>)async{
        await MainActor.run{
            operationState = uiStat
        }
    }
    func increseItem(cartline:CartLine)async{
       
        let res = await model.changeItemQuantity( forLine: cartline.id, with: cartline.quantity+1).toRemote()
        
        await showCart(uiStat: res)
    }
    func decreseItem(cartline:CartLine)async{
        let res = await model.changeItemQuantity( forLine: cartline.id, with: cartline.quantity-1).toRemote()
        
        await showCart(uiStat: res)
        cartManager.refreshState()

    }
    func deleteItem(cartline:CartLine)async{
        let res = await model.deleteCartItem(forLine: cartline.id).toRemote()
        await showCart(uiStat: res)
        cartManager.refreshState()

    }
}
