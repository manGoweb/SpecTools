//
//  BasicTests.swift
//  SpecTools
//
//  Created by Ondrej Rafaj on 25/08/2017.
//  Copyright © 2017 manGoweb. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SpecTools


class BasicSpec: QuickSpec {
    
    override func spec() {
        
        describe("when there is no setup") {
            it("view not placed on screen, view should not visible") {
                let v = UIView()
                expect(v.spec.check.trulyVisible()).to(beFalse())
            }
        }
        
    }
    
}
