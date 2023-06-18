//
//  CartManager.swift
//  Shopify-ITI
//
//  Created by ahmed alameir on 14/06/2023.
//

import Foundation
import Shopify_ITI_SDK
import Combine

class CartManager:AnyInjectable{
    static func register(_ container: AppContainer) {
        container.register(type: CartManager.self) { resolver in
            CartManager(cartIdStore:  resolver.require((any AnyCartIdStore).self),
                        notificationCenter:  resolver.require((any AnyNotificationCenter).self),
                        cartRemoteService: resolver.require(CartRemoteService.self),
                        authManager: resolver.require(AuthenticationManager.self))
            
        }
    }
    typealias State = Resource<Cart>
    
    private let cartIdStore: any AnyCartIdStore
    private let notificationCenter: any AnyNotificationCenter
    private let authManager: AuthenticationManager
    private let cartRemoteService:CartRemoteService
    private var task: Task<Any, Error>? = nil
    private var cancellables: Set<AnyCancellable> = []
    @Published private(set) var state: State = .loading
    
    init(cartIdStore: some AnyCartIdStore,
         notificationCenter: some AnyNotificationCenter,
         cartRemoteService: CartRemoteService,
         authManager: AuthenticationManager) {
        self.cartIdStore = cartIdStore
        self.notificationCenter = notificationCenter
        self.cartRemoteService = cartRemoteService
        self.authManager = authManager
        
        self.initialize()
    }
    
    private func initialize() {
        authManager.$state
            .prepend(authManager.state)
            .receive(on: DispatchQueue.global()).sink { authState in
                print(authState)
                self.handleAuthState(authState)
            }.store(in: &cancellables)
    }
    
    private func evaluateState() {
        handleAuthState(authManager.state)
    }
    
    private func handleAuthState(_ authState: AuthenticationState) {
        task?.cancel()
        task = Task {
            await handleAuthStateImpl(authState, self.state.data)
        }
    }
    
    private func handleAuthStateImpl(_ authState: AuthenticationState,
                                     _ cart: Cart?) async {
        await MainActor.run {
            self.state = .loading
        }
        
        if let user = authState.user {
            if let cart = cart {
                if cart.userToken == nil {
                    await updateOwnership(cart, user)
                } else if cart.userToken != user.id {
                    await removeCart()
                } else {
                    await setCart(cart)
                }
            }
        } else {
            if let cart = cart {
                if let _ = cart.userToken {
                    await removeCart()
                } else {
                    await setCart(cart)
                }
            }
        }
    }
    
    private func setCart(_ cart: Cart) async {
        await MainActor.run {
            self.state = .data(data: cart)
        }
    }
    
    private func removeCart() async {
        cartIdStore.delete()
        await MainActor.run {
            self.state = .none
        }
    }
    
   
  
    
    private func updateOwnership(_ cart: Cart, _ user: User) async {
        let result = await cartRemoteService.upDataBuyerIdentity(withUserID: user.id, forCart: cart.id)
        await handleCartResult(result)
    }
    
    private func handleCartResult(_ result: Result<Cart?, Error>) async {
        guard !Task.isCancelled else { return }
        
        await MainActor.run {
            switch result {
                case .success(let newCart):
                if let newCart = newCart{
                    self.handleCart(newCart)
                    break
                }
                
                case .failure(let error):
                    self.state = .error(error: error)
                break
            }
        }
    }
    
    func addItem(productVariant item: ProductVariant,quantity :Int) async -> Result<Cart, Error> {
        if case .loading = state {
            _ = await task?.result
        }
        let result = cartIdStore.read()
        switch result{
        case .success(let cardID):
            return await addToCart(cardID, item,quantity: quantity)
        case .failure(_):
            return await fetchOrCreate(item,quantity: quantity)

        }
        
    }
    
    private func addToCart(_ cartid: String, _ item: ProductVariant,quantity:Int) async -> Result<Cart, Error> {
        
        let cartResult = await cartRemoteService.upDate(card: cartid, with: ShopifyAPI.CartLineInput(quantity: .init(nullable: quantity), merchandiseId: item.id ))
        return await cartHandler(result: cartResult)
    }
    
    private func fetchOrCreate(_ item: ProductVariant,quantity:Int) async -> Result<Cart, Error>{
        let buyerIdentity = ShopifyAPI.CartBuyerIdentityInput(customerAccessToken: .init(nullable: "userId"))
        let cartLineInputs = [ShopifyAPI.CartLineInput(quantity: .init(nullable: quantity), merchandiseId: item.id)]
        
        let cartResult = await cartRemoteService.createCart(with: ShopifyAPI.CartInput(lines: .init(nullable: cartLineInputs),
                                                                                       buyerIdentity: .init(nullable: buyerIdentity)))
        return await cartHandler(result: cartResult)
    }
    
    private func cartHandler(result:Result<Cart?, Error>)async -> Result<Cart, Error>{
        switch result{
        case .success(let cart):
            
            if let cart = cart{
                return Result.success(cart)
            }else{
                return Result.failure(LocalErrors.NotFound)
            }
        case .failure(let error):
            
            return Result.failure(error)
        }
    }
    
    private func handleCart(_ cart: Cart) {
        let user = authManager.state.user
        if let ownerId = cart.userToken {
            _ = cartIdStore.delete()
            if let user = user {
                if user.id == ownerId {
                    self.setList(cart)
                } else {
                    evaluateState()
                }
            } else {
                evaluateState()
            }
        } else if user == nil {
            _ = cartIdStore.write(id: cart.id)
            self.setList(cart)
        } else {
            self.setList(cart)
            evaluateState()
        }
    }
    
    private func setList(_ cart: Cart) {
        self.state = .data(data: cart)
    }
}
