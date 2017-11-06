//
//  Action+UIGestureRecognizer.swift
//  SpecTools
//
//  Created by Ondrej Rafaj on 11/09/2017.
//

import Foundation
import UIKit


public typealias TargetActionInfo = [(target: AnyObject, action: Selector)]


#if os(iOS)
    
    extension Action where T: UIView {
        
        // MARK: UIView
        
        /// Simulate tap on a gesture recognizer
        /// - Parameter taps: Number of taps
        /// - Parameter touches: Number of touches
        @discardableResult public func triggerTap(taps: Int = 1, touches: Int = 1) -> Action {
            if element.isUserInteractionEnabled == false {
                fatalError("User interactions are disabled. Gesture recognizer can't be used")
            }
            let recognizers = element.spec.find.all(gestureRecognizersOfType: UITapGestureRecognizer.self)
            for recognizer in recognizers {
                if recognizer.numberOfTapsRequired == taps && recognizer.numberOfTouchesRequired == touches {
                    recognizer.spec.action.execute()
                }
            }
            return self
        }
        
    }
    
    
    extension Action where T: UIGestureRecognizer {
        
        // MARK: UIGestureRecognizer
        
        /// Returns all actions and selectors for a gesture recognizer
        /// This method uses private API's and will most likely cause your app to be rejected if used outside of your test target
        /// - Returns: [(target: AnyObject, action: Selector)] Array of action/selector tuples
        public func getTargetInfo() -> TargetActionInfo {
            var targetsInfo: TargetActionInfo = []
            
            if let targets = element.value(forKeyPath: "_targets") as? [NSObject] {
                for target in targets {
                    // Getting selector by parsing the description string of a UIGestureRecognizerTarget
                    let selectorString = String.init(describing: target).components(separatedBy: ", ").first!.replacingOccurrences(of: "(action=", with: "")
                    let selector = NSSelectorFromString(selectorString)
                    
                    // Getting target from iVars
                    let targetActionPairClass: AnyClass = NSClassFromString("UIGestureRecognizerTarget")!
                    let targetIvar: Ivar = class_getInstanceVariable(targetActionPairClass, "_target")!
                    let targetObject: AnyObject = object_getIvar(target, targetIvar) as AnyObject
                    
                    targetsInfo.append((target: targetObject, action: selector))
                }
            }
            
            return targetsInfo
        }
        
        /// Executes all targets on a specific gesture recognizer
        @discardableResult public func execute() -> Action {
            let targetsInfo = element.spec.action.getTargetInfo()
            for info in targetsInfo {
                info.target.performSelector(onMainThread: info.action, with: nil, waitUntilDone: true)
            }
            return self
        }
        
    }
    
#endif
