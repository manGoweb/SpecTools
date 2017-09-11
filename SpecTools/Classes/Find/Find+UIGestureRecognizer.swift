//
//  Find+UIGestureRecognizer.swift
//  SpecTools
//
//  Created by Ondrej Rafaj on 11/09/2017.
//

import Foundation
import UIKit


extension Find where T: UIView {
    
    // MARK: Find gesture recognizers
    
    /// Find all gesture recognizers of a certain type
    /// - Parameter ofRowsIn: Section index
    /// - Returns: Int
    public func all<T>(gestureRecognizersOfType type: T.Type) -> [T] {
        var recognizers: [T] = []
        for recognizer in element.gestureRecognizers ?? [] {
            guard let recognizer = recognizer as? T else {
                continue
            }
            recognizers.append(recognizer)
        }
        return recognizers
    }
    
}
