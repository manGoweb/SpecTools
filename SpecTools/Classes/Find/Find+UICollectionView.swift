//
//  Find+UICollectionView.swift
//  SpecTools
//
//  Created by Ondrej Rafaj on 15/09/2017.
//

import Foundation
import UIKit


extension Find where T: UICollectionView {
    
    // MARK: UICollectionView
    
    /// Return number of sections on a collection view data source
    /// - Returns: Int
    public func numberOfSections() -> Int {
        return element.dataSource?.numberOfSections?(in: element) ?? 0
    }
    
    /// Number of rows on a section in a collection view data source
    /// - Parameter ofRowsIn: Section index
    /// - Returns: Int
    public func number(ofRowsIn section: Int) -> Int {
        return element.dataSource?.collectionView(element, numberOfItemsInSection: section) ?? 0
    }
    
}
