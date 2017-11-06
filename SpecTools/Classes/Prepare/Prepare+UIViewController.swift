//
//  Prepare+UIViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 25/08/2017.
//
//

import Foundation
import UIKit

/// Apple devices, this enum only contais first in a line/screensize for each device (iPhone 6 is a predecesor of iPhone 7 thus only 6 is shown)
public enum DeviceScreenSize {
    /// iPhone 4
    case iPhone4
    /// iPhone 5
    case iPhone5
    /// iPhone 6
    case iPhone6
    /// iPhone 6+
    case iPhone6Plus
    /// iPad
    case iPad
    /// iPad Pro (large screen)
    case iPadProLarge
    
    /// Return pixel size of the selected device
    public static func size(for type: DeviceScreenSize) -> CGSize {
        switch type {
        case .iPhone4:
            return CGSize(width: 320, height: 480)
        case .iPhone5:
            return CGSize(width: 320, height: 480)
        case .iPhone6:
            return CGSize(width: 320, height: 480)
        case .iPhone6Plus:
            return CGSize(width: 320, height: 480)
        case .iPad:
            return CGSize(width: 1024, height: 768)
        case .iPadProLarge:
            return CGSize(width: 2732, height: 2048)
        }
    }
}


extension Prepare where T: UIViewController {
    
    // MARK: Preparation methods for UIViewController
    
    /// Will touch view of a view controller in order to get loadView and viewDidLoad called, than manually calls viewWillAppear and viewDidAppear with animations disabled
    @discardableResult public func simulatePresentViewController() -> Prepare {
        element.loadViewIfNeeded()
        element.viewWillAppear(false)
        element.viewDidAppear(false)
        return self
    }
    
    /// Set a new size for a view controllers view during runtime
    @discardableResult public func set(viewSize: CGSize) -> Prepare {
        element.view.frame.size = viewSize
        element.view.setNeedsLayout()
        element.view.layoutIfNeeded()
        return self
    }
    
    /// Set a screensize of a desired device on a view of your view controller, you can specify a custom height. Custom height might be useful when scrollviews are present
    @discardableResult public func set(viewSize: DeviceScreenSize, height: CGFloat? = nil) -> Prepare {
        var size = DeviceScreenSize.size(for: viewSize)
        if height != nil && height! >= 0 {
            size.height = height!
        }
        set(viewSize: size)
        return self
    }
    
    /// Give view controller a navigation controller
    @discardableResult public func assignNavigationController<T>(ofClass classType: T.Type? = nil) -> Prepare where T: UINavigationController {
        var nc: UINavigationController
        if classType == nil {
            nc = UINavigationController(rootViewController: element)
        }
        else {
            nc = classType!.init(rootViewController: element)
        }
        nc.spec.prepare.simulatePresentViewController()
        return self
    }
    
    /// Give view controller a mock navigation controller which mainly allows for testing push/pop functionality
    @discardableResult public func assignMockNavigationController() -> Prepare {
        let nc = MockNavigationController(rootViewController: element)
        nc.spec.prepare.simulatePresentViewController()
        return self
    }
    
}

