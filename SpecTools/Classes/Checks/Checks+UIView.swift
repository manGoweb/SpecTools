//
//  Checks+UIView.swift
//  Pods
//
//  Created by Ondrej Rafaj on 25/08/2017.
//
//

import Foundation
import UIKit


extension SpecCheck where T: UIView {
    
    public func isVisible(on parentView: UIView? = nil, visualize: SpecVisualize = .none) -> Bool {
        return isVisible(on: parentView, visualize: visualize, level: 0)
    }
    
    private func isVisible(on parentView: UIView?, visualize: SpecVisualize, level: Int) -> Bool {
        // Print visualization if neccessary
        if visualize != .none {
            var space = ""
            for i in 0...level {
                space.append("  ")
            }
            let text = element.spec.find.anyText()
            print("\(space)- \(Visualize.description(element, text, visualize))")
        }
        
        // Check visibility
        if element.isHidden || element.alpha < 0.01 || element.frame.size == CGSize.zero {
            return false
        }
        // TODO: Handle scroll views and the element being off the screen
        
        // If superview is present
        if element.superview != nil {
            if element != parentView {
                return element.superview!.spec.check.isVisible(on: parentView, visualize: visualize, level: (level + 1))
            }
        }
        
        
        // Check if we already reached the top view
        if parentView != nil {
            if parentView == element {
                return true
            }
            else {
                return false
            }
        }
        
        // If we don't have a top view, we'll expect that last one is
        return true
    }
    
}
