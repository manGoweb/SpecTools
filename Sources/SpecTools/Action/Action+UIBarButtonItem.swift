import UIKit

extension Action where T: UIBarButtonItem {
    
    // MARK: UIBarButtonItem
    
    /// Simulate tap on a bar button item
    /// - Parameter event: Event type to trigger
    @discardableResult public func tap() -> Action {
        if let target = element.target, let action = element.action {
            _ = target.perform(action, with: element)
        }
        
        return self
    }
}
