//
//  CartViewModel.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 14/06/2023.
//

import Foundation
import Combine
let testCart = "gid://shopify/Cart/c1-d4bd72d94eefdef6dcfc7cbfb06ea5fa"
class CartViewModel:ObservableObject{
    private let model:AnyCartModel
    @Published private(set) var operationState: UIState<Cart> = .initial
    var uiStatePublisher: Published<UIState<Cart>>.Publisher { $operationState }
    init(model: AnyCartModel) {
        self.model = model
    }
    func getCart()async{
        await MainActor.run{
            operationState = .loading
        }
        let res = await model.getCart(with: testCart).toRemote()
        
        await showCart(uiStat: res)
    }
    private func showCart(uiStat:UIState<Cart>)async{
        await MainActor.run{
            operationState = uiStat
        }
    }
    func increseItem(cartline:CartLine)async{
       
        let res = await model.changeItemQuantity(forCart: testCart, forLine: cartline.id, with: cartline.quantity+1).toRemote()
        
        await showCart(uiStat: res)
    }
    func decreseItem(cartline:CartLine)async{
       
        let res = await model.changeItemQuantity(forCart: testCart, forLine: cartline.id, with: cartline.quantity-1).toRemote()
        
        await showCart(uiStat: res)
    }
    func deleteItem(cartline:CartLine)async{
        let res = await model.deleteCartItem(forCart: testCart, forLine: cartline.id).toRemote()
        await showCart(uiStat: res)

    }
}
