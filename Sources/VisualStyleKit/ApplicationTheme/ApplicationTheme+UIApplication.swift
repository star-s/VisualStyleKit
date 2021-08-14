//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 14.08.2021.
//

import UIKit

private let key = "colorTheme"

extension UIApplication: ApplicationThemeEnvironment {
	
	open func updateCurentTheme(with theme: ApplicationTheme) {
		switch theme {
		case .forced(let theme):
			UserDefaults.standard.set(theme.rawValue, forKey: key)
		case .system:
			UserDefaults.standard.removeObject(forKey: key)
		}
		applicationThemeDidChange()
	}
	
	// MARK: - ApplicationThemeEnvironment
	
	open var applicationTheme: ApplicationTheme {
		guard let value = UserDefaults.standard.string(forKey: key).flatMap(ColorTheme.init) else {
			return .system
		}
		return .forced(value)
	}
	
	open func applicationThemeDidChange() {
		windows.forEach {
			$0.applicationThemeDidChange()
		}
	}
}

extension UIWindow: ApplicationThemeEnvironment {
	public func applicationThemeDidChange() {
		[
			rootViewController?.presentedViewController,
			rootViewController
		].compactMap({ $0 })
		.flatMap({ $0.collect({ $0 as? ApplicationThemeEnvironment }) })
		.forEach({ $0.applicationThemeDidChange() })
	}
}

extension UIViewController {
	
	public func overrideUserInterfaceStyle(by theme: ApplicationTheme) {
		guard #available(iOS 13.0, tvOS 13.0, *) else {
			return
		}
		switch theme {
		case .forced(let colorTheme):
			switch colorTheme {
			case .light:
				overrideUserInterfaceStyle = .light
			case .dark:
				overrideUserInterfaceStyle = .dark
			}
		case .system:
			overrideUserInterfaceStyle = .unspecified
		}
	}
	
	fileprivate func collect<T>(_ transform: (UIViewController) -> T?) -> [T] {
		var result = [T]()
		transform(self).map {
			result.append($0)
		}
		children.forEach {
			result.append(contentsOf: $0.collect(transform))
		}
		return result
	}
}
