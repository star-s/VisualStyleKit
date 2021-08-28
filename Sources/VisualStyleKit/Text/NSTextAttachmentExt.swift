//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 28.08.2021.
//

import UIKit

public extension NSTextAttachment {
	static func make(with image: UIImage, capitalCharacterHeight: CGFloat? = nil) -> Self {
		let attach = Self()
		attach.image = image
		attach.bounds.size = image.size
		capitalCharacterHeight.map {
			attach.ajustVerticalPosition(with: $0)
		}
		return attach
	}
	
	func ajustVerticalPosition(with capitalCharacterHeight: CGFloat) {
		bounds.origin.y = ( capitalCharacterHeight - bounds.height ) / 2
	}
}
