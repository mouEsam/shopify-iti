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
    typealias AlertType = AppAlert
    
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
    
    @Published private var alertsHolder: [AppAlert] = []
    var alert: AppAlert? {
        get { alertsHolder.first }
        set {
            if let newValue = newValue {
                alertsHolder.append(newValue)
            } else if !alertsHolder.isEmpty {
                alertsHolder.removeLast()
            }
        }
    }
    
    required init(path: NavigationPath) {
        self.path = path
    }
    
    required init(root: RouteType) {
        self.path = NavigationPath()
        path.append(AppRouteWrapper(route: root))
    }
    
    var routesCount: Int { path.count }
    var canPop: Bool { !path.isEmpty }
    
    func push(_ route: RouteType) {
        path.append(AppRouteWrapper(route: route))
    }
    
    func replace(_ route: RouteType) {
        var path = self.path
        if !path.isEmpty {
            path.removeLast()
        }
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
    

    
    func alert<Item>(item: Item, alert: @escaping (Item) -> Alert) where Item : Identifiable {
        let route = AppAlert(id: item) { alert(item) }
        self.alertsHolder.append(route)
    }
    
    func dismissAlert() {
        if !self.alertsHolder.isEmpty {
            self.alertsHolder.removeLast()
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

class AppAlert: AnyAlert {
    
    let id: any Identifiable
    let body: () -> Alert
    
    init(id: some Identifiable,
         content: @escaping () -> Alert) {
        self.id = id
        self.body = content
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
