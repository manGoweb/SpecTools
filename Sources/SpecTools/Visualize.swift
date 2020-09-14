import UIKit


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
            return "\(className): \(NSCoder.string(for: item.frame)); \(textToPrint)"
        case .classes:
            return "\(className)"
        case .text:
            let textToPrint: String = (text != nil) ? ": " + text! : ""
            return "\(className)\(textToPrint)"
        case .frames:
            return "\(className): \(NSCoder.string(for: item.frame))"
        default:
            return ""
        }
        
    }
    
}
