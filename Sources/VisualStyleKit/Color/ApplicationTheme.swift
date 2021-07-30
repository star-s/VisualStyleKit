//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 30.07.2021.
//

import Foundation

public enum ApplicationTheme {
	case forced(ColorTheme)
	case system
}

public extension ApplicationTheme {
	static var current: ApplicationTheme {
		get {
			guard let value = UserDefaults.standard.string(forKey: key).flatMap(ColorTheme.init) else {
				return .system
			}
			return .forced(value)
		}
		set {
			switch newValue {
			case .forced(let theme):
				UserDefaults.standard.set(theme.rawValue, forKey: key)
			case .system:
				UserDefaults.standard.removeObject(forKey: key)
			}
		}
	}
	
	private static let key = "colorTheme"
}
