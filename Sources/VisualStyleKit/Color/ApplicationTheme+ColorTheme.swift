//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 30.07.2021.
//

import UIKit

public extension ApplicationTheme {
    var colorTheme: ColorTheme {
        switch self {
        case .forced(let theme):
            return theme
        default:
            break
        }
        guard #available(iOS 12.0, tvOS 10.0, *) else {
            return .light
        }
        switch UIScreen.main.traitCollection.userInterfaceStyle {
        case .dark:
            return .dark
        default:
            return .light
        }
    }
}
