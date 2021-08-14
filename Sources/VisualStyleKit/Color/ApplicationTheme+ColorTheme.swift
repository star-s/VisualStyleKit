//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 30.07.2021.
//

import UIKit

public extension ApplicationTheme {
    var colorTheme: ColorTheme {
		if case .forced(let theme) = self {
			return theme
		}
        guard #available(iOS 13.0, tvOS 13.0, *) else {
            return .light
        }
		switch UITraitCollection.current.userInterfaceStyle {
        case .dark:
            return .dark
        default:
            return .light
        }
    }
}
