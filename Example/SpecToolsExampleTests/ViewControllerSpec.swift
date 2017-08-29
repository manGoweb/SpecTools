//
//  ViewControllerSpec.swift
//  SpecTools
//
//  Created by Ondrej Rafaj on 25/08/2017.
//  Copyright © 2017 manGoweb. All rights reserved.
//

import Foundation
import UIKit
import Quick
import Nimble
import SpecTools

@testable import SpecToolsExample


class ViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        let subject = ViewController()
        
        describe("basic view controller") {
            beforeEach {
                // Simulate view controller being presented to the screen
                subject.spec.prepare.simulatePresentViewController()
                // Reset the view to specific size
                subject.spec.prepare.set(viewSize: .iPhone6Plus)
            }
            
            it("has a visible label1") {
                // Get your first label
                let element = subject.view.spec.find.first(labelWithText: "My first label")
                // Check if the label is truly visible
                expect(element?.spec.check.isVisible(visualize: .text)).to(beTrue())
            }
            
            it("has a visible scrollView") {
                // Get a scroll view
                let element = subject.view.spec.find.firstScrollView()
                // Check visibility
                expect(element?.spec.check.isVisible()).to(beTrue())
            }
            
            it("has a visible label2", closure: {
                // Get a label that contains "second label" and print how we get to it in the console including any text on visible elements
                let element = subject.view.spec.find.first(labelWithText: "My second label", exactMatch: false, visualize: .text)
                // Check if the label is visible on subjects view
                expect(element?.spec.check.isVisible(on: subject.view, visualize: .text)).to(beTrue())
            })
            
        }
        
    }
    
}
