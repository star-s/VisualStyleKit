//
//  File.swift
//  
//
//  Created by Sergey Starukhin on 24.03.2021.
//

import UIKit

public protocol CastedViewController: UIViewController {
    associatedtype View: UIView
    
    var castedView: View { get }
}

public extension CastedViewController {

    var castedView: View {
        guard let result = view as? View else {
            fatalError("Wrong view type \(String(describing: view)) must be \(View.self)")
        }
        return result
    }
}
