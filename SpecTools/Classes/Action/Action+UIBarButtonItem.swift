//
//  Action+UIBarButtonItem.swift
//  Nimble-iOS
//
//  Created by Yohta Watanave on 2019/04/03.
//

import Foundation
import UIKit

extension Action where T: UIBarButtonItem {
    
    // MARK: UIBarButtonItem
    
    /// Simulate tap on a bar button item
    /// - Parameter event: Event type to trigger
    @discardableResult public func tap() -> Action {
        if let target = element.target, let action = element.action {
            _ = target.perform(action, with: element)
        }
        
        return self
    }
}
