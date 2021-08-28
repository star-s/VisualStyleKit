//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 28.08.2021.
//

import UIKit

extension NSAttributedString {
	
	public static func space(width: CGFloat) -> NSAttributedString {
		let attach = NSTextAttachment()
		attach.bounds.size.width = width
		return NSAttributedString(attachment: attach)
	}
	
	public func appended(space width: CGFloat) -> NSAttributedString {
		modified {
			$0.append(.space(width: width))
		}
	}
	
	public func appended(text attrString: NSAttributedString) -> NSAttributedString {
		modified {
			$0.append(attrString)
		}
	}
	
	public func appended(image: UIImage, capitalCharacterHeight: CGFloat? = nil) -> NSAttributedString {
		modified {
			$0.append(image.embeddedInString(capitalCharacterHeight: capitalCharacterHeight))
		}
	}
	
	func modified(_ modificator: (NSMutableAttributedString) -> Void) -> NSAttributedString {
		let result = NSMutableAttributedString(attributedString: self)
		modificator(result)
		return NSAttributedString(attributedString: result)
	}
}

public extension UIImage {
	
	func embeddedInString(capitalCharacterHeight: CGFloat? = nil) -> NSAttributedString {
		let attach = NSTextAttachment()
		attach.image = self
		attach.bounds.size = size
		capitalCharacterHeight.map {
			attach.bounds.origin.y = ( $0 - attach.bounds.height ) / 2
		}
		return NSAttributedString(attachment: attach)
	}
}

public extension String {
	
	func attributed(_ attributes: [NSAttributedString.Key: Any]? = nil) -> NSAttributedString {
		NSAttributedString(string: self, attributes: attributes)
	}

	func attributed(_ block: (inout [NSAttributedString.Key: Any]) -> Void) -> NSAttributedString {
		var attributes = [NSAttributedString.Key: Any]()
		block(&attributes)
		return NSAttributedString(string: self, attributes: attributes)
	}
}

@available(iOS 10.0, tvOS 10.0, *)
extension Array where Element: NSAttributedString {
	
	func join(_ traitCollection: UITraitCollection? = nil) -> NSAttributedString {
		let result = NSMutableAttributedString()
		(traitCollection?.layoutDirection == .rightToLeft ? reversed() : self).forEach(result.append)
		return result
	}
}
