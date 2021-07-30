//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 18/10/2019.
//

import Foundation

public extension String {
    
    func components(withMaxLength length: Int) -> [String] {
        stride(from: 0, to: count, by: length).map {
            let start = index(startIndex, offsetBy: $0)
            let end = index(start, offsetBy: length, limitedBy: endIndex) ?? endIndex
            return String(self[start..<end])
        }
    }
}
