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
        return element.childViewControllers.contains(viewController)
    }
    
    public func contains<T>(siblingClassInNavigationStack viewControllerClass: T.Type) -> Bool where T: UIViewController {
        guard let nc = element.navigationController else {
            return false
        }
        return nc.viewControllers.contains(where: { type(of: $0) == viewControllerClass })
    }
    
    public func contains<T>(childViewControllerClass viewControllerClass: T.Type) -> Bool where T: UIViewController {
        return element.childViewControllers.contains(where: { type(of: $0) == viewControllerClass })
    }
    
}

// MARK: - Navigation view controller

extension SpecFind where T: UINavigationController {
    
    public func has(viewController: UIViewController) -> Bool {
        return element.viewControllers.contains(viewController)
    }
    
    public func contains<T>(viewControllerClass: T.Type) -> Bool where T: UIViewController {
        return element.viewControllers.contains(where: { type(of: $0) == viewControllerClass })
    }
    
}
