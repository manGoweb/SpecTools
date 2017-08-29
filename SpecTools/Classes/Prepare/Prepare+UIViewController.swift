//
//  Prepare+UIViewController.swift
//  Pods
//
//  Created by Ondrej Rafaj on 25/08/2017.
//
//

import Foundation
import UIKit


public enum SpecDeviceScreenSize {
    case iPhone4
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case iPad
    case iPadProLarge
    
    public static func size(for type: SpecDeviceScreenSize) -> CGSize {
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


extension SpecPrepare where T: UIViewController {
    
    public func simulatePresentViewController() {
        _ = element.view
        element.viewWillAppear(false)
        element.viewDidAppear(false)
    }
    
    public func set(viewSize: CGSize) {
        element.view.frame.size = viewSize
        element.view.setNeedsLayout()
        element.view.layoutIfNeeded()
    }
    
    public func set(viewSize: SpecDeviceScreenSize, height: CGFloat? = nil) {
        var size = SpecDeviceScreenSize.size(for: viewSize)
        if height != nil && height! >= 0 {
            size.height = height!
        }
        set(viewSize: size)
    }
    
}


