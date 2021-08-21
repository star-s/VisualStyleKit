//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 30.07.2021.
//

import Foundation
import UIKit

public protocol PaletteProtocol {
	associatedtype Color
	
	func resolved(color: Color) -> UIColor
}

extension Dictionary: PaletteProtocol where Value: UiKitColorConvertible {
	public typealias Color = Key
	
	public func resolved(color: Key) -> UIColor {
		guard let value = self[color] else {
			fatalError("Color \(color) don't exist!")
		}
		return value.uiColor
	}
}
