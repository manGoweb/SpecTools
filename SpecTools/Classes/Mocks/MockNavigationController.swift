//
//  MockNavigationController.swift
//  SpecTools
//
//  Created by Ondrej Rafaj on 10/09/2017.
//

import Foundation
import UIKit


/// Mock navigation view controller
public class MockNavigationController: UINavigationController {
    
    /// Checks if a view controller has been pushed (can be used only once ... obviously)
    public var didPushViewController: Bool = false
    
    /// Last pushed view controller
    public var lastPushedViewController: UIViewController? = nil
    
    
    // MARK: UINavigationController Overrides
    
    /// Helps testing if view controller has been pushed. It updates the stack right away
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        didPushViewController = true
        lastPushedViewController = viewController
        
        viewControllers.append(viewController)
        
        viewController.spec.prepare.simulatePresentViewController()
    }
    
    /// Helps testing if view controller has been popped. It updates the stack right away
    public override func popViewController(animated: Bool) -> UIViewController? {
        guard viewControllers.count > 1, let vc = viewControllers.last, let index: Int = viewControllers.index(of: vc) else {
            return nil
        }
        viewControllers.remove(at: index)
        
        return vc
    }
    
}

