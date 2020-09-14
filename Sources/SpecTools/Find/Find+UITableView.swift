import UIKit


extension Find where T: UITableView {
    
    // MARK: UITableView
    
    /// Return number of sections on a table view data source
    /// - Returns: Int
    public func numberOfSections() -> Int {
        return element.dataSource?.numberOfSections?(in: element) ?? 0
    }
    
    /// Number of rows on a section in a table view data source
    /// - Parameter ofRowsIn: Section index
    /// - Returns: Int
    public func number(ofRowsIn section: Int) -> Int {
        return element.dataSource?.tableView(element, numberOfRowsInSection: section) ?? 0
    }
    
}
