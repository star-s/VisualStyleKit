//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 30.07.2021.
//

import Foundation
import UIKit

public protocol ColorProtocol {
	associatedtype Palette: PaletteProtocol where Palette.Color == Self
	static var palette: Palette { get }
}

public extension ColorProtocol {
	func resolved() -> UIColor {
		Self.palette.resolved(color: self)
	}
}
