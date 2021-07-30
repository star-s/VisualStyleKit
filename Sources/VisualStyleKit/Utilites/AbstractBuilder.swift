//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 24.07.2021.
//

import Foundation

public protocol AbstractBuilder {
	associatedtype Product
	
	func make() -> Product
}

public struct Modificator<T> {
	private let builder: () -> T
	private let modificator: (inout T) -> Void

	public init<Builder: AbstractBuilder>(builder: Builder, modificator: @escaping (inout T) -> Void) where Builder.Product == T {
		self.builder = { builder.make() }
		self.modificator = modificator
	}
}

extension Modificator: AbstractBuilder {
    public func make() -> T {
        var result = builder()
        modificator(&result)
        return result
    }
}
