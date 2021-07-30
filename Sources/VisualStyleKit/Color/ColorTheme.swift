//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 30.07.2021.
//

import Foundation

public enum ColorTheme: String {
	case light
	case dark
}

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
