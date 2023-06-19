//
//  AnyRouter.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 15/06/2023.
//

import Foundation
import Combine
import SwiftUI

protocol AnyRouter: AnyObject, ObservableObject {
    associatedtype RouteWrapperType: AnyRouteWrapper
    associatedtype RouteType: AnyRoute
    associatedtype OverlayRouteType: AnyOverlayRoute
    associatedtype AlertType: AnyAlert
    
    var path: NavigationPath { get set }
    var overlay: OverlayRouteType? { get set }
    var alert: AlertType? { get set }
    
    init(path: NavigationPath)
    
    var routesCount: Int { get }
    var canPop: Bool { get }
    
    func push(_ route: RouteType)
    func replace(_ route: RouteType)
    func pop()
    
    func present<Content: View>(_ overlayType: Overlay, overlay: @escaping () -> Content)
    func dismiss()
    
    func alert<Item: Identifiable>(item: Item, alert: @escaping (Item) -> Alert)
    func dismissAlert()
}

enum Overlay: String, Hashable, Identifiable {
    var id: Self { self }
    
    case sheet
    case popover
    case fullscreen
}

extension AnyRouter {
    init() {
        self.init(path: NavigationPath())
    }
}

protocol AnyRestorableRouter: AnyRouter where RouteType: AnyRestorableRoute {
    
    func push(_ route: some AnyRestorableRoute)
    func replace(_ route: some AnyRestorableRoute)
    
    static func readSerializedData() -> Data?
    static func writeSerializedData(_ data: Data)
}

extension AnyRestorableRouter {
    init() {
        if let data = Self.readSerializedData(),
           let representation = try? JSONDecoder().decode(
               NavigationPath.CodableRepresentation.self,
               from: data) {
            self.init(path: NavigationPath(representation))
        } else {
            self.init(path: NavigationPath())
        }
    }
    
    func save() -> Result<Void, Error> {
        guard let representation = path.codable else {
            return .failure(LocalErrors.NotAvailable)
        }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(representation)
            Self.writeSerializedData(data)
            return .success(Void())
        } catch {
            return .failure(error)
        }
    }
}

protocol AnyRoute: Hashable {
    associatedtype Content: View
    
    var body: () -> Content { get }
}

protocol AnyOverlayRoute: AnyRoute, Identifiable {
    var overlayType: Overlay { get }
}

protocol AnyAlert: Identifiable {
    var body: () -> Alert { get }
}

protocol AnyRestorableRoute: AnyRoute, Codable {}

protocol AnyRouteWrapper: Hashable {
    var route: any AnyRoute { get }
}
