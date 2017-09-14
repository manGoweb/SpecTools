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
    public func tap(event: UIControlEvents = .touchUpInside) {
        element.sendActions(for: event)
    }
    
}
