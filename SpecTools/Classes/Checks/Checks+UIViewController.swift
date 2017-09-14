//
//  Find+UIViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 25/08/2017.
//
//

import Foundation


// MARK: View controller

extension Check where T: UIViewController {
    
    // MARK: UIViewController
    
    /// Look for a specific view controller in your navigation stack
    /// - Parameter siblingInNavigationStack: View controller you are looking for
    /// - Returns: Bool (true if found)
    public func has(siblingInNavigationStack viewController: UIViewController) -> Bool {
        guard let nc = element.navigationController else {
            return false
        }
        return nc.spec.check.has(viewController: viewController)
    }
    
    /// Check if a view controller has a child view controller
    /// - Parameter childViewController: View controller you are looking for
    /// - Returns: Bool (true if found)
    public func has(childViewController viewController: UIViewController) -> Bool {
        return element.childViewControllers.contains(viewController)
    }
    
    /// Check if a view controller has a specific class type in its navigation stack
    /// - Parameter siblingClassInNavigationStack: Class of a view controller you are looking for
    /// - Returns: Bool (true if found)
    public func contains<T>(siblingClassInNavigationStack viewControllerClass: T.Type) -> Bool where T: UIViewController {
        guard let nc = element.navigationController else {
            return false
        }
        return nc.viewControllers.contains(where: { type(of: $0) == viewControllerClass })
    }
    
    /// Check if a view controller has specifit class type of a child view controller
    /// - Parameter childViewControllerClass: Class of a view controller you are looking for
    /// - Returns: Bool (true if found)
    public func contains<T>(childViewControllerClass viewControllerClass: T.Type) -> Bool where T: UIViewController {
        return element.childViewControllers.contains(where: { type(of: $0) == viewControllerClass })
    }
    
}

// MARK: - Navigation view controller

extension Check where T: UINavigationController {
    
    // MARK: UINavigationController
    
    /// Check is navigation view controller contains certain view controller
    /// - Parameter viewController: View controller you are looking for
    /// - Returns: Bool (true if found)
    public func has(viewController: UIViewController) -> Bool {
        return element.viewControllers.contains(viewController)
    }
    
    /// Check is navigation view controller contains certain type of a view controller
    /// - Parameter viewControllerClass: Class of a view controller you are looking for
    /// - Returns: Bool (true if found)
    public func contains<T>(viewControllerClass: T.Type) -> Bool where T: UIViewController {
        return element.viewControllers.contains(where: { type(of: $0) == viewControllerClass })
    }
    
}
