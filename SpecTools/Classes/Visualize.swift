//
//  Visualize.swift
//  Pods
//
//  Created by Ondrej Rafaj on 25/08/2017.
//
//

import Foundation


// MARK: - Settings

/// Visualization types
public enum VisualizationType: Int {
    /// No visualization
    case none
    /// Show classes only
    case classes
    /// Show classes and frames
    case frames
    /// Show classes and text if available
    case text
    /// Show classes, frames and text if available
    case all
}

class Visualize {
    
    static func description(_ item: UIView, _ text: String?, _ visualize: VisualizationType) -> String {
        let className = String(describing: type(of: item))
        switch visualize {
        case .all:
            let textToPrint: String = (text != nil) ? ": " + text! : ""
            return "\(className): \(NSStringFromCGRect(item.frame)); \(textToPrint)"
        case .classes:
            return "\(className)"
        case .text:
            let textToPrint: String = (text != nil) ? ": " + text! : ""
            return "\(className)\(textToPrint)"
        case .frames:
            return "\(className): \(NSStringFromCGRect(item.frame))"
        default:
            return ""
        }
        
    }
    
}
