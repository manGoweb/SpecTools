//
//  Action+UITableView.swift
//  SpecTools
//
//  Created by DevPair9 on 02/11/2017.
//

import Foundation
import UIKit


extension Action where T: UITableView {
    
    // MARK: UITableView
    
    /// Simulate tap on a cell in table view
    /// - Parameter row: Index of the row to tap on
    /// - Parameter section: Index of the section to tap on
    @discardableResult public func tap(row: Int, section: Int = 0) -> Action {
        element.delegate?.tableView?(element, didSelectRowAt: IndexPath(row: row, section: section))
        return self
    }
    
}
