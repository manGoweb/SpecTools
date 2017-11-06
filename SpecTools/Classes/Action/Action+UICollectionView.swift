//
//  Action+UICollectionView.swift
//  SpecTools
//
//  Created by Jonathan Aguele on 02/11/2017.
//

import Foundation
import UIKit


extension Action where T: UICollectionView {
    
    // MARK: UICollectionView
    
    /// Simulate tap on a cell in collection view
    /// - Parameter item: Index of an item to tap on
    /// - Parameter section: Index of the section to tap on
    @discardableResult public func tap(item: Int, section: Int = 0) -> Action {
        element.delegate?.collectionView?(element, didSelectItemAt: IndexPath(item: item, section: section))
        return self
    }
    
}
