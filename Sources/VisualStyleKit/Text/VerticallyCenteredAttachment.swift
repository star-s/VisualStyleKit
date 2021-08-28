//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 28.08.2021.
//

import UIKit

public final class VerticallyCenteredAttachment: NSTextAttachment {
	
	public override func attachmentBounds(for textContainer: NSTextContainer?,
								   proposedLineFragment lineFrag: CGRect,
								   glyphPosition position: CGPoint,
								   characterIndex charIndex: Int) -> CGRect {
		var bounds = bounds
		guard let storage = textContainer?.layoutManager?.textStorage else {
			return bounds
		}
		guard let font = storage
				.fons()
				.filter({ storage.string.character(at: $0.position, isNot: Self.character) })
				.sorted(by: { ($0.position - charIndex) < ($1.position - charIndex) })
				.first?
				.font else {
			return bounds
		}
		bounds.origin.y = ( font.capHeight - bounds.height ) / 2
		return bounds
	}
}

extension NSAttributedString {
	func fons() -> [(position: Int, font: UIFont)] {
		var result = [(position: Int, font: UIFont)]()
		enumerateAttribute(.font, in: NSRange(location: 0, length: length), options: []) { value, range, _ in
			guard let font = value as? UIFont else {
				return
			}
			result.append((range.location, font))
		}
		return result
	}
}

extension String {
	func character(at position: Int, isNot char: Int) -> Bool {
		guard let char = Unicode.Scalar(char).map(Character.init) else {
			return true
		}
		return self[index(startIndex, offsetBy: position)] != char
	}
}
