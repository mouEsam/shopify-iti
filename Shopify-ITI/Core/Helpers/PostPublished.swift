//
//  PostPublished.swift
//  Shopify-ITI
//
//  Created by Mostafa Ibrahim on 19/06/2023.
//

import Foundation
import Combine

/// A type that publishes changes about its `wrappedValue` property _after_ the property has changed (using `didSet` semantics).
/// Reimplementation of `Combine.Published`, which uses `willSet` semantics.
@available(iOS 13, *)
@propertyWrapper
public class PostPublished<Value> {
    typealias Publisher = AnyPublisher<Value, Never>
    
    /// A `Publisher` that emits the new value of `wrappedValue` _after it was_ mutated (using `didSet` semantics).
    public let projectedValue: AnyPublisher<Value, Never>
    /// A `Publisher` that fires whenever `wrappedValue` _was_ mutated. To access the new value of `wrappedValue`, access `wrappedValue` directly, this `Publisher` only signals a change, it doesn't contain the changed value.
    public let valueDidChange: AnyPublisher<Void, Never>
    private let didChangeSubject: any Subject<Value, Never>
    public var wrappedValue: Value {
        didSet {
            didChangeSubject.send(wrappedValue)
        }
    }
    
    /// - parameter emitCurrentValue: whether to emit the current wrapped value when subscribing to `projectValue`
    public init(wrappedValue: Value, emitCurrentValue: Bool = false) {
        self.wrappedValue = wrappedValue
        let didChangeSubject: any Subject<Value, Never>
        if emitCurrentValue {
            didChangeSubject = CurrentValueSubject(wrappedValue)
        } else {
            didChangeSubject = PassthroughSubject<Value, Never>()
        }
        self.didChangeSubject = didChangeSubject
        self.projectedValue = didChangeSubject.eraseToAnyPublisher()
        self.valueDidChange = didChangeSubject.voidPublisher()
    }
}

public extension Publisher {
    /// Maps the `Output` of its upstream to `Void` and type erases its upstream to `AnyPublisher`.
    func voidPublisher() -> AnyPublisher<Void, Failure> {
        map { _ in Void() }
            .eraseToAnyPublisher()
    }
}
