//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 30.07.2021.
//

import UIKit

public extension TextStyle {
	
	// MARK: - Font
	
	var font: UIFont? {
		make().font
	}
	
	func font(_ font: UIFont) -> TextStyle {
		TextStyle(parent: self) {
			$0[.font] = font
		}
	}
	
	func fontStyle(_ style: UIFont.TextStyle) -> TextStyle {
		TextStyle(parent: self) {
			$0[.font] = UIFont.preferredFont(forTextStyle: style)
		}
	}
	
	func fontSize(_ size: CGFloat) -> TextStyle {
		TextStyle(parent: self) {
			if let font = $0[.font] as? UIFont {
				$0[.font] = font.withSize(size)
			} else {
				$0[.font] = UIFont.systemFont(ofSize: size)
			}
		}
	}
	
	func fontName(_ name: String) -> TextStyle {
		TextStyle(parent: self) {
			let size = $0.fontSize ?? UIFont.systemFontSize
			if let font = UIFont(name: name, size: size) {
				$0[.font] = font
			}
		}
	}
	
	// MARK: - Color
	
	var foregroundColor: UIColor? {
		make().foregroundColor
	}
	
	var backgroundColor: UIColor? {
		make().backgroundColor
	}
	
	func foregroundColor(_ color: UIColor) -> TextStyle {
		TextStyle(parent: self) {
			$0[.foregroundColor] = color
		}
	}
	
	func backgroundColor(_ color: UIColor) -> TextStyle {
		TextStyle(parent: self) {
			$0[.backgroundColor] = color
		}
	}
	
	// MARK: - Paragraph params
	
	func alignment(_ alignment: NSTextAlignment) -> TextStyle {
		TextStyle(parent: self) {
			paragraph(&$0).alignment = alignment
		}
	}
    
    func lineBreakMode(_ lineBreakMode: NSLineBreakMode) -> TextStyle {
        TextStyle(parent: self) {
            paragraph(&$0).lineBreakMode = lineBreakMode
        }
    }
}
