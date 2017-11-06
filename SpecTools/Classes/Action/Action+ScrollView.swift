//
//  Action+ScrollView.swift
//  SpecTools
//
//  Created by DevPair9 on 06/11/2017.
//

import Foundation
import UIKit


extension Action where T: UIScrollView {
    
    // MARK: UIScrollView
    
    /// Simulate scroll to a given point
    /// - Parameter to: Target offset value
    /// - Parameter decelerate: Enables deceleration after dragging
    @discardableResult public func scroll(to point: CGPoint, decelerate: Bool = false) -> Action {
        element.delegate?.scrollViewWillBeginDragging?(element)
        
        element.contentOffset = point
        
        element.delegate?.scrollViewDidScroll?(element)
        
        element.delegate?.scrollViewDidEndDragging?(element, willDecelerate: decelerate)
        
        var target = point
        element.delegate?.scrollViewWillEndDragging?(element, withVelocity: CGPoint.zero, targetContentOffset: &target)
        
        if decelerate {
            element.delegate?.scrollViewWillBeginDecelerating?(element)
            element.delegate?.scrollViewDidEndDecelerating?(element)
        }
        return self
    }
    
    /// Simulate scroll to a given page horizontally
    /// - Parameter to: Target page index
    /// - Parameter decelerate: Enables deceleration after dragging
    @discardableResult public func scroll(horizontalPageIndex index: Int, decelerate: Bool = false) -> Action {
        let x = CGFloat(index) * element.frame.width
        scroll(to: CGPoint(x: x, y: element.contentOffset.y))
        return self
    }
    
    /// Simulate scroll to a given page vertically
    /// - Parameter to: Target page index
    /// - Parameter decelerate: Enables deceleration after dragging
    @discardableResult public func scroll(verticalPageIndex index: Int, decelerate: Bool = false) -> Action {
        let y = CGFloat(index) * element.frame.height
        scroll(to: CGPoint(x: element.contentOffset.x, y: y))
        return self
    }
    
}
