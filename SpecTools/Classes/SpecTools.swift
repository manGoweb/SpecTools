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
public struct Property<T> {
    
    let element: T
    
    /// Contains checks on supported elements
    /// (like isVisible or hasSiblings, etc)
    public let check: Check<T>
    /// If you are looking for something, find is your guy
    /// (You can find text, recurse through UIView structures, etc)
    public let find: Find<T>
    /// Prepares supported elements
    /// (like prepare view controllers for testing, etc)
    public let prepare: Prepare<T>
    /// Actions on supported elements
    /// (like tap on a button or execute a gesture recognizers targets)
    public let action: Action<T>
    
    init(_ obj: T) {
        element = obj
        
        check = Check(obj)
        find = Find(obj)
        prepare = Prepare(obj)
        action = Action(obj)
    }
    
}

/// Main property protocol which delivers basic element accessors
public protocol PropertyProtocol {
    
    associatedtype PropertyParentType
    var spec: Property<PropertyParentType> { get }
    
}

extension PropertyProtocol {
    
    /// Main property used to access checks, finds, prepares and and actions for any supported elements
    public var spec: Property<Self> {
        get {
            return Property(self)
        }
    }
    
}

extension UIGestureRecognizer: PropertyProtocol { }
extension UIView: PropertyProtocol { }
extension UIViewController: PropertyProtocol { }

