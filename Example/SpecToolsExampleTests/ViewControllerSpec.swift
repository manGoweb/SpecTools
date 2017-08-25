//
//  ViewControllerSpec.swift
//  SpecTools
//
//  Created by Ondrej Rafaj on 25/08/2017.
//  Copyright © 2017 manGoweb. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SpecTools

@testable import SpecToolsExample


class ViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        let subject = ViewController()
        
        describe("basic view controller") {
            beforeEach {
                _ = subject.view
            }
            
            it("has a visible label1") {
                let element = subject.view.spec.find.first(labelWithText: "My first label")
                expect(element?.spec.check.trulyVisible()).to(beTrue())
            }
            
            it("has a visible scrollView") {
                let element = subject.view.spec.find.firstScrollView()
                expect(element?.spec.check.trulyVisible()).to(beTrue())
            }
            
        }
        
    }
    
}
