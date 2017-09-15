//
//  Checks+UICollectionView.swift
//  SpecTools
//
//  Created by Ondrej Rafaj on 15/09/2017.
//

import Foundation
import UIKit


extension Check where T: UICollectionView {
    
    // MARK: UICollectionView
    
    /// Check if there are any cells that don't fit criteria specified in a closure
    /// - Parameter fit: Closure that needs to evaluate the cell which is passed onto it
    /// - Returns: Bool (true if no issue is found)
    public func allCells(fit evaluateClosure: (UICollectionViewCell)->Bool) -> Bool {
        return allCells(thatDontFit: evaluateClosure).count == 0
    }
    
    /// Check if there are any cells that don't fit criteria specified in a closure
    /// - Parameter fit: Closure that needs to evaluate the cell which is passed onto it
    /// - Returns: [IndexPath] Index path of all cells that do not match the given criteria
    public func allCells(thatDontFit evaluateClosure: (UICollectionViewCell)->Bool) -> [IndexPath] {
        var indexPaths: [IndexPath] = []
        for sectionIndex in 0...element.spec.find.numberOfSections() {
            row: for rowIndex in 0...element.spec.find.number(ofRowsIn: sectionIndex) {
                let indexPath = IndexPath(item: rowIndex, section: sectionIndex)
                guard let cell = element.dataSource?.collectionView(element, cellForItemAt: indexPath) else {
                    fatalError("Data source is not set")
                }
                
                let ok = evaluateClosure(cell)
                if !ok {
                    indexPaths.append(indexPath)
                }
            }
        }
        return indexPaths
    }
    
}

