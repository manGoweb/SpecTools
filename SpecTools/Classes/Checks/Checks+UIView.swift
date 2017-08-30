//
//  Checks+UIView.swift
//  Pods
//
//  Created by Ondrej Rafaj on 25/08/2017.
//
//

import Foundation
import UIKit

/*
 #Check helper methods for UIView
 */
extension SpecCheck where T: UIView {
    
    public func isVisible(on parentView: UIView? = nil, visualize: SpecVisualize = .none) -> Bool {
        let result = isVisible(on: parentView, visualize: visualize, level: 0)
        if visualize != .none {
            print("Visibility check finished: \(result ? "visible" : "hidden")\n\n")
        }
        return result
    }
    
    private func isVisible(on parentView: UIView?, visualize: SpecVisualize, level: Int) -> Bool {
        // Print visualization if neccessary
        if visualize != .none {
            if level == 0 {
                print("\n\nTraverse check for element visibility has started")
            }
            
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
        
        // If superview is present
        if let superview = element.superview {
            // If placed on scrollview
            var offset: CGPoint = CGPoint.zero
            if let scrollViewSuperview = superview as? UIScrollView {
                offset = scrollViewSuperview.contentOffset
            }
            
            // Check if the element is out of bounds
            var origin: CGPoint = element.frame.origin
            origin.x += offset.x
            origin.y += offset.y
            if origin.x > superview.frame.width || origin.y > superview.frame.height {
                return false
            }
            if (origin.x + element.frame.width) < 0 || (origin.y + element.frame.height) < 0 {
                return false
            }
            
            if element != parentView {
                return superview.spec.check.isVisible(on: parentView, visualize: visualize, level: (level + 1))
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
        
        // If we don't have a top view, we'll expect that last one is (like a view controllers view)
        return true
    }
    
}
