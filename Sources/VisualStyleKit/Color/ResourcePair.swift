//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 14.08.2021.
//

import Foundation

public struct ResourcePair<T> {
	private let light: T
	private let dark: T?
	
	public init(_ light: T, dark: T? = nil) {
		self.light = light
		self.dark = dark
	}
	
	public subscript(theme: ColorTheme) -> T {
		switch theme {
		case .light:
			return light
		case .dark:
			return dark ?? light
		}
	}
}

extension ResourcePair: ExpressibleByNilLiteral where T: ExpressibleByNilLiteral {
	public init(nilLiteral: ()) {
		self.init(nil)
	}
}

extension ResourcePair: ExpressibleByUnicodeScalarLiteral where T: ExpressibleByUnicodeScalarLiteral {
    public typealias UnicodeScalarLiteralType = T.UnicodeScalarLiteralType
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(.init(unicodeScalarLiteral: value))
    }
}

extension ResourcePair: ExpressibleByExtendedGraphemeClusterLiteral where T: ExpressibleByExtendedGraphemeClusterLiteral {
    public typealias ExtendedGraphemeClusterLiteralType = T.ExtendedGraphemeClusterLiteralType
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(.init(extendedGraphemeClusterLiteral: value))
    }
}

extension ResourcePair: ExpressibleByStringLiteral where T: ExpressibleByStringLiteral {
    public typealias StringLiteralType = T.StringLiteralType
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(.init(stringLiteral: value))
    }
}
