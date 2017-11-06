//
//  Action+Button.swift
//  Pods
//
//  Created by Ondrej Rafaj on 27/08/2017.
//
//

import Foundation
import UIKit


extension Action where T: UIButton {
    
    // MARK: UIButton
    
    /// Simulate tap on a button
    /// - Parameter event: Event type to trigger
    @discardableResult public func tap(event: UIControlEvents = .touchUpInside) -> Action {
        element.sendActions(for: event)
        return self
    }
    
}
