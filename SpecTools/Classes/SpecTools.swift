//
//  SpecTools.swift
//  Pods
//
//  Created by Ondrej Rafaj on 25/08/2017.
//
//

import Foundation
import UIKit


public struct SpecCheck<T> {
    
    let element: T
    
    init(_ obj: T) {
        element = obj
    }
    
}

public struct SpecFind<T> {
    
    let element: T
    
    init(_ obj: T) {
        element = obj
    }
    
}

public struct SpecPrepare<T> {
    
    let element: T
    
    init(_ obj: T) {
        element = obj
    }
    
}

public struct SpecAction<T> {
    
    let element: T
    
    init(_ obj: T) {
        element = obj
    }
    
}

public struct SpecProperty<T> {
    
    let element: T
    
    public let check: SpecCheck<T>
    public let find: SpecFind<T>
    public let prepare: SpecPrepare<T>
    public let action: SpecAction<T>
    
    init(_ obj: T) {
        element = obj
        
        check = SpecCheck(obj)
        find = SpecFind(obj)
        prepare = SpecPrepare(obj)
        action = SpecAction(obj)
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

extension UIView: PropertyProtocol { }
extension UIViewController: PropertyProtocol { }

