//
//  OrdersViewModel.swift
//  Shopify-ITI
//
//  Created by ammar on 21/06/2023.
//

import Foundation
import Combine

class OrdersViewModel : ObservableObject{
    
    @Published private(set) var operationState: UIState<[Order]> = .initial
    
    private let notificationCenter: any AnyNotificationCenter
    private let model: AnyOrdersModel
    
    private var task: Task<(), Never>? = nil
    private var cancellables: Set<AnyCancellable> = []
    
    init(model: AnyOrdersModel,
         notificationCenter: some AnyNotificationCenter) {
        self.model = model
        self.notificationCenter = notificationCenter
        
        self.initialize()
    }
    
    private func initialize() {
        notificationCenter
            .publisher(for: PaymentNotification.name)
            .receive(on: DispatchQueue.global())
            .sink { _ in
                self.loadOrders()
            }.store(in: &cancellables)
    }
    
    func loadOrders() {
        task?.cancel()
        task = Task {
            await self.loadOrdersImpl()
        }
    }
    
    private func loadOrdersImpl() async {
        await MainActor.run(){
            self.operationState = .loading
        }
        
        let res =  await model.fetch().toRemote()
        
        await MainActor.run(){
            self.operationState = res
        }
    }
}
