//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 14.08.2021.
//

import UIKit

public protocol ApplicationThemeEnvironment {
	var applicationTheme: ApplicationTheme { get }
	
	func applicationThemeDidChange()
}

public extension ApplicationThemeEnvironment {
	var applicationTheme: ApplicationTheme {
		UIApplication.shared.applicationTheme
	}
}

public extension ApplicationThemeEnvironment where Self: CastedViewController, View: ApplicationThemeApplayable {
	func applicationThemeDidChange() {
		overrideUserInterfaceStyle(by: applicationTheme)
		castedView.applyTheme(applicationTheme)
	}
}
