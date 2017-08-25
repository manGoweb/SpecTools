//
//  BasicTests.swift
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


class BasicSpec: QuickSpec {
    
    override func spec() {
        
        describe("In a basic setup") {
            var superview: UIView!
            var view: UIView!
            
            beforeEach() {
                superview = UIView()
                superview.frame = CGRect(x: 10, y: 10, width: 120, height: 220)
                
                view = UIView()
                view.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
            }
            
            describe("when view is not placed on screen") {
                it("it should not be visible") {
                    expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                }
            }
            
            describe("when view is placed on screen") {
                beforeEach() {
                    superview.addSubview(view)
                }
                
                it("it should be visible") {
                    expect(view.spec.check.isVisible(on: superview)).to(beTruthy())
                }
                
                it("it should not be visible if it is hidden=true") {
                    view.isHidden = true
                    expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                }
                
                it("it should not be visible if it is alpha=0") {
                    view.alpha = 0
                    expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                }
                
                it("it should not be visible if it is hidden=true") {
                    view.frame = CGRect.zero
                    expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                }
            }
        }
    }
}
