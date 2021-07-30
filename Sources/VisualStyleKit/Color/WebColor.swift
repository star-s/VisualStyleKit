//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 18/10/2019.
//

import Foundation

public struct WebColor {
	
    public let alpha: Double?
    public let red: Double
    public let green: Double
    public let blue: Double
    
    public init(red: Double, green: Double, blue: Double, alpha: Double? = nil) {
        self.red = red
        self.green = green
        self.blue = blue
        self.alpha = alpha
    }
}

extension WebColor: LosslessStringConvertible {
    
    public init?(_ description: String) {
        let colorString = description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        let components: [String]
        switch colorString.count {
        case 3, 4:
            components = colorString.components(withMaxLength: 1).map({"\($0)\($0)"})
        case 6, 8:
            components = colorString.components(withMaxLength: 2)
        default:
            return nil
        }
        var iterator = components.map({ Double(UInt8($0, radix: 16) ?? 0) / 255.0 }).makeIterator()
        if components.count > 3 {
            guard let a = iterator.next() else {
                return nil
            }
            alpha = a
        } else {
            alpha = nil
        }
        guard let r = iterator.next() else {
            return nil
        }
        red = r
        guard let g = iterator.next() else {
            return nil
        }
        green = g
        guard let b = iterator.next() else {
            return nil
        }
        blue = b
    }
    
    public var description: String {
        [alpha, red, green, blue].compactMap({ $0 }).map({ UInt8($0 * 255.0) }).reduce(into: "#", { $0 = $0.appendingFormat("%02X", $1) })
    }
}

extension WebColor: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        guard let color = WebColor(value) else {
            preconditionFailure("Color value \(value) is invalid. It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB")
        }
        self = color
    }
}

extension WebColor: Codable {
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        guard let color = WebColor(value) else {
			let description = "Color value \(value) is invalid. It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB"
            throw DecodingError.dataCorruptedError(in: container, debugDescription: description)
        }
        self = color
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
    }
}
