//
//  TableViewControllerSpec.swift
//  SpecToolsExampleTests
//
//  Created by Ondrej Rafaj on 11/09/2017.
//  Copyright © 2017 manGoweb. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble
import SpecTools

@testable import SpecToolsExample


class TableViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var subject: TableViewController!
        
        describe("TableViewController") {
            beforeEach {
                // Create the subject
                subject = TableViewController()
                
                // Give subject a navigation controller
                _ = subject.spec.prepare.assignMockNavigationController()
                
                // Simulate view controller being presented to the screen
                subject.spec.prepare.simulatePresentViewController()
                // Reset the view to specific size
                subject.spec.prepare.set(viewSize: .iPhone6Plus)
            }
            
            it("has a visible table view cell") {
                // Find fifth cell in table view
                let cell = subject.view.spec.find.first(tableViewCellWithText: "4", exactMatch: false, visualize: .text)
                expect(cell?.spec.check.isVisible(on: subject.view))
            }
            
            
        }
    }
}
