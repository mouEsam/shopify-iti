//
//  Router.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 15/06/2023.
//

import Foundation
import Combine
import SwiftUI

class AppRouter: ObservableObject, AnyRouter {
    typealias RouteWrapperType = AppRouteWrapper
    typealias RouteType = AppRoute
    typealias OverlayRouteType = AppOverlayRoute
    
    @Published var path: NavigationPath
    
    @Published private var overlaysHolder: [AppOverlayRoute] = []
    var overlay: AppOverlayRoute? {
        get { overlaysHolder.first }
        set {
            if let newValue = newValue {
                overlaysHolder.append(newValue)
            } else if !overlaysHolder.isEmpty {
                overlaysHolder.removeLast()
            }
        }
    }
    
    required init(path: NavigationPath) {
        self.path = path
    }
    
    func push(_ route: RouteType) {
        path.append(AppRouteWrapper(route: route))
    }
    
    func replace(_ route: RouteType) {
        var path = self.path
        path.removeLast()
        path.append(AppRouteWrapper(route: route))
        self.path = path
    }
    
    func pop() {
        path.removeLast()
    }
    
    func present<Content: View>(_ overlayType: Overlay,
                                overlay: @escaping () -> Content) {
        let route = AppOverlayRoute(overlayType, content: overlay)
        self.overlaysHolder.append(route)
    }
    
    func dismiss() {
        if !self.overlaysHolder.isEmpty {
            self.overlaysHolder.removeLast()
        }
    }
}

class AppRoute: AnyRoute {
    private let identifier: any Hashable
    private let content: () -> AnyView
    
    required init<Content: View>(identifier: any Hashable,
                                 content: @escaping () -> Content) {
        self.identifier = identifier
        self.content = { AnyView(erasing: content()) }
    }
    
    var body: () -> AnyView { content }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

class AppOverlayRoute: AnyOverlayRoute {
    typealias Content = AnyView
    var id: Overlay { overlayType }
    let overlayType: Overlay
    let body: () -> Content
    
    required init<Content: View>(_ overlayType: Overlay,
                                 content: @escaping () -> Content) {
        self.overlayType = overlayType
        self.body = { AnyView(erasing: content()) }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(overlayType)
    }
    
    static func == (lhs: AppOverlayRoute, rhs: AppOverlayRoute) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

struct AppRouteWrapper: AnyRouteWrapper {
    let route: any AnyRoute
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(route)
    }
    
    static func == (lhs: AppRouteWrapper, rhs: AppRouteWrapper) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
