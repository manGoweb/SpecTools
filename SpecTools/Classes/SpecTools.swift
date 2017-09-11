//
//  SpecTools.swift
//  Pods
//
//  Created by Ondrej Rafaj on 25/08/2017.
//
//

import Foundation
import UIKit


/// Checking properties of an object or a view
public struct Check<T> {
    
    let element: T
    
    init(_ obj: T) {
        element = obj
    }
    
}

/// Searching for views by their text or type
public struct Find<T> {
    
    let element: T
    
    init(_ obj: T) {
        element = obj
    }
    
}

/// Prepare objects or views for certain state
public struct Prepare<T> {
    
    let element: T
    
    init(_ obj: T) {
        element = obj
    }
    
}

/// Simulate actions on views or objects
public struct Action<T> {
    
    let element: T
    
    init(_ obj: T) {
        element = obj
    }
    
}

/// Main holding property. Any supported view or object will have .spec property available
public struct SpecProperty<T> {
    
    let element: T
    
    public let check: Check<T>
    public let find: Find<T>
    public let prepare: Prepare<T>
    public let action: Action<T>
    
    init(_ obj: T) {
        element = obj
        
        check = Check(obj)
        find = Find(obj)
        prepare = Prepare(obj)
        action = Action(obj)
    }
    
}

public protocol PropertyProtocol {
    
    associatedtype PropertyParentType
    var spec: SpecProperty<PropertyParentType> { get }
    
}

extension PropertyProtocol {
    
    public var spec: SpecProperty<Self> {
        get {
            return SpecProperty(self)
        }
    }
    
}

extension UIGestureRecognizer: PropertyProtocol { }
extension UIView: PropertyProtocol { }
extension UIViewController: PropertyProtocol { }

