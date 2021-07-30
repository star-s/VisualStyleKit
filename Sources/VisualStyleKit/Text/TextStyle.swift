//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 18.07.2021.
//

import Foundation

public final class TextStyle: ExpressibleByDictionaryLiteral {
    
    public typealias Modificator = (inout [NSAttributedString.Key : Any]) -> Void

    private let parent: TextStyle?
    private let modificator: Modificator

    public init(parent: TextStyle? = nil, modificator: @escaping Modificator) {
        self.parent = parent
        self.modificator = modificator
    }
    
    public init(dictionaryLiteral elements: (NSAttributedString.Key, Any)...) {
        parent = nil
        modificator = {
            for element in elements {
                $0[element.0] = element.1
            }
        }
    }
}

extension TextStyle: AbstractBuilder {
	
	public func make() -> [NSAttributedString.Key : Any] {
		var result = parent?.make() ?? [:]
		modificator(&result)
		return result
	}
}

public extension String {
	func attributed(with style: TextStyle) -> NSAttributedString {
		.init(string: self, attributes: style.make())
	}
}
