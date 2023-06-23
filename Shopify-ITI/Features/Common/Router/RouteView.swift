//
//  RouteView.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 15/06/2023.
//

import Foundation
import Combine
import SwiftUI

@propertyWrapper
struct EnvironmentRoute<Route: AnyRoute>: DynamicProperty {
    @EnvironmentObject private var route: EnvironmentObjectWrapper<any AnyRoute>
    
    var wrappedValue: Route {
        get {
            return route.object as! Route
        }
    }
}

@propertyWrapper
struct EnvironmentOverlayRoute<Route: AnyOverlayRoute>: DynamicProperty {
    @EnvironmentObject private var route: EnvironmentObjectWrapper<any AnyOverlayRoute>
    
    var wrappedValue: Route {
        get {
            return route.object as! Route
        }
    }
}

@propertyWrapper
struct EnvironmentRouter<Router: AnyRouter>: DynamicProperty {
    @EnvironmentObject private var router: EnvironmentObjectWrapper<any AnyRouter>
    
    var wrappedValue: Router {
        get {
            return router.object as! Router
        }
    }
}

fileprivate class EnvironmentObjectWrapper<T>: ObservableObject {
    let object: T
    
    init(object: T) {
        self.object = object
    }
}

struct RouterView<Router: AnyRouter, Content: View>: View {
    
    @StateObject private var router: Router
    private let root: () -> Content
    
    init(router: Router, @ViewBuilder root: @escaping () -> Content) {
        self._router = .init(wrappedValue: router)
        self.root = root
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            root()
                .navigationDestination(for: Router.RouteWrapperType.self) { wrapper in
                    let route = wrapper.route
                    let body = route.body()
                    AnyView(erasing: body)
                        .environmentObject(EnvironmentObjectWrapper(object: wrapper.route as any AnyRoute))
            }
            .hiddenNavigationBarStyle()
        }.sheet(item: getOverlayBinding(for: .sheet)) { route in
            route.body().environmentObject(EnvironmentObjectWrapper(object: route as any AnyOverlayRoute))
        }.fullScreenCover(item: getOverlayBinding(for: .fullscreen)) { route in
            route.body().environmentObject(EnvironmentObjectWrapper(object: route as any AnyOverlayRoute))
        }.popover(item: getOverlayBinding(for: .popover)) { route in
            route.body().environmentObject(EnvironmentObjectWrapper(object: route as any AnyOverlayRoute))
        }.alert(item: $router.alert) { item in
            item.body()
        }.environmentObject(EnvironmentObjectWrapper(object: router as any AnyRouter))
    }
    
    private func getOverlayBinding(for overlay: Overlay) -> Binding<Router.OverlayRouteType?> {
        .init {
            if let route = router.overlay,
               route.overlayType == overlay {
                return route
            }
            return nil
        } set: { newRoute in
            if let route = router.overlay,
               route.overlayType == overlay {
                router.overlay = newRoute
            }
        }
    }
}
