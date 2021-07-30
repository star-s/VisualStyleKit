//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 30.07.2021.
//

import UIKit

public extension UIColor {
    
    var webColor: WebColor? {
        var alpha: CGFloat = 0, red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }
        return WebColor(red: Double(red),
                        green: Double(green),
                        blue: Double(blue),
                        alpha: (alpha == 1.0 ? nil : Double(alpha)))
    }
    
    convenience init(_ webColor: WebColor) {
        self.init(red: CGFloat(webColor.red),
                  green: CGFloat(webColor.green),
                  blue: CGFloat(webColor.blue),
                  alpha: CGFloat(webColor.alpha ?? 1.0))
    }
}
