//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 28.08.2021.
//

import UIKit

extension NSAttributedString {
	
	public static func make(with image: UIImage, capitalCharacterHeight: CGFloat? = nil) -> NSAttributedString {
		NSAttributedString(attachment: .make(with: image, capitalCharacterHeight: capitalCharacterHeight))
	}
	
	public static func make(space width: CGFloat) -> NSAttributedString {
		let attach = NSTextAttachment()
		attach.bounds.size.width = width
		return NSAttributedString(attachment: attach)
	}
	
	public func append(space width: CGFloat) -> NSAttributedString {
		modify {
			$0.append(.make(space: width))
		}
	}
	
	public func append(text attrString: NSAttributedString) -> NSAttributedString {
		modify {
			$0.append(attrString)
		}
	}
	
	public func append(image: UIImage, capitalCharacterHeight: CGFloat? = nil) -> NSAttributedString {
		modify {
			$0.append(.make(with: image, capitalCharacterHeight: capitalCharacterHeight))
		}
	}
	
	func modify(_ modificator: (NSMutableAttributedString) -> Void) -> NSAttributedString {
		let result = NSMutableAttributedString(attributedString: self)
		modificator(result)
		return NSAttributedString(attributedString: result)
	}
}
