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
    @Published var cart:Cart?
    var uiStatePublisher: Published<UIState<Cart>>.Publisher { $operationState }
    init(model: AnyCartModel) {
        self.model = model
    }
    func getCart()async{
        let res = await model.getCart(with: testCart)
        switch res{
        case .success(let cart):
            self.cart = cart
        case .failure(let error):
            operationState = .error(error: error)
        }
    }
}
