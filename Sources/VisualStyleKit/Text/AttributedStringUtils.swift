//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 24.07.2021.
//

import UIKit

public extension Dictionary where Key == NSAttributedString.Key, Value == Any {
	
	// MARK: - Font
	
	var font: UIFont? {
		self[.font] as? UIFont
	}
	
	var fontSize: CGFloat? {
		font?.pointSize
	}
	
	// MARK: - Color
	
	var backgroundColor: UIColor? {
		self[.backgroundColor] as? UIColor
	}
	
	var foregroundColor: UIColor? {
		self[.foregroundColor] as? UIColor
	}
	
	// MARK: - Paragpaph style
	
	var paragraphStyle: NSParagraphStyle? {
		self[.paragraphStyle] as? NSParagraphStyle
	}
	
	var alignment: NSTextAlignment? {
		paragraphStyle?.alignment
	}
	
	var lineBreakMode: NSLineBreakMode? {
		paragraphStyle?.lineBreakMode
	}
}

public func paragraph(_ attrs: inout [NSAttributedString.Key : Any]) -> NSMutableParagraphStyle {
	let paragrahStyle = NSMutableParagraphStyle()
	paragrahStyle.setParagraphStyle(attrs.paragraphStyle ?? .default)
	attrs[.paragraphStyle] = paragrahStyle
	return paragrahStyle
}
