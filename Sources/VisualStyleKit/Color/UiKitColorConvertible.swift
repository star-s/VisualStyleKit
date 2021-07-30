//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 30.07.2021.
//

import Foundation
import UIKit

public protocol UiKitColorConvertible {
    var uiColor: UIColor { get }
}

extension UIColor: UiKitColorConvertible {
    public var uiColor: UIColor {
        self
    }
}

extension WebColor: UiKitColorConvertible {
    public var uiColor: UIColor {
        .init(self)
    }
}

extension ResourcePair: UiKitColorConvertible where T: UiKitColorConvertible {
    public var uiColor: UIColor {
        self[ApplicationTheme.current.colorTheme].uiColor
    }
}
