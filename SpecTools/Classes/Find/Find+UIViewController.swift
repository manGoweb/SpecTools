//
//  Find+UIViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 25/08/2017.
//
//

import Foundation


// MARK: View controller

extension SpecFind where T: UIViewController {
    
    public func has(siblingInNavigationStack viewController: UIViewController) -> Bool {
        guard let nc = element.navigationController else {
            return false
        }
        return nc.spec.find.has(viewController: viewController)
    }
    
    public func has(childViewController viewController: UIViewController) -> Bool {
        // TODO: Check if views are added
        // TODO: Check if childViewControllers contain viewController
        return false
    }
    
    public func contains<T>(siblingClassInNavigationStack viewControllerClass: T.Type) -> Bool where T: UIViewController {
        guard let nc = element.navigationController else {
            return false
        }
        // TODO: Check if navigationController.viewControllers contain any class of type T
        return false
    }
    
    public func contains<T>(childViewControllerClass viewControllerClass: T.Type) -> Bool where T: UIViewController {
        // TODO: Check if childViewControllers contain any class of type T
        return false
    }
    
}

// MARK: - Navigation view controller

extension SpecFind where T: UINavigationController {
    
    public func has(viewController: UIViewController) -> Bool {
        // TODO: Check if self.viewControllers contain viewController
        return false
    }
    
    public func contains<T>(viewControllerClass: T.Type) -> Bool where T: UIViewController {
        // TODO: Check if self.viewControllers contain any class of type T
        return false
    }
    
}
