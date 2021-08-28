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

protocol ProducerP {
	associatedtype Product
	func callAsFunction() -> Product
}

protocol MutatorP: ProducerP {
	init(_ value: @autoclosure @escaping () -> Product, modificator: @escaping (inout Product) -> Void)
}

protocol TransformerP {
	associatedtype Input
	associatedtype Output
	func callAsFunction(_ input: Input) -> Output
}

protocol ABProtocol {
	associatedtype Product
	func callAsFunction() -> Product
}

protocol ModifiableAB: ABProtocol {
	init(_ value: @autoclosure @escaping () -> Product, modificator: @escaping (inout Product) -> Void)
}

protocol TextSt: ModifiableAB where Product == [NSAttributedString.Key: Any] {
}

extension TextSt {
	var font: UIFont? {
		self()[.font] as? UIFont
	}
	
	func font(_ font: UIFont) -> Self {
		.init(self()) {
			$0[.font] = font
		}
	}
}

struct Builder<T> {
	private let value: () -> T
	private let modificator: (inout T) -> Void

	public init(_ value: @autoclosure @escaping () -> T, modificator: @escaping (inout T) -> Void) {
		self.value = value
		self.modificator = modificator
	}
}

protocol ModifiableBuilder: AbstractBuilder {
	init(_ value: @autoclosure @escaping () -> Product, modificator: @escaping (inout Product) -> Void)
}

extension Builder: AbstractBuilder {
	public func make() -> T {
		var result = value()
		modificator(&result)
		return result
	}
}

import UIKit

protocol TextSty: ModifiableBuilder where Product == [NSAttributedString.Key: Any] {
}

extension TextSty {
	
	private subscript(key: NSAttributedString.Key) -> Any? {
		make()[key]
	}
	
	var font: UIFont? {
		self[.font] as? UIFont
	}
	
	func font(_ font: UIFont) -> Self {
		.init(make()) {
			$0[.font] = font
		}
	}
}
