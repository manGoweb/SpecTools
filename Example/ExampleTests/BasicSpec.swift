import UIKit
import Quick
import Nimble
import SpecTools


class BasicSpec: QuickSpec {
    
    override func spec() {
        
        describe("In a basic setup") {
            var superview: UIView!
            var scrollView: UIScrollView!
            var view: UIView!
            
            beforeEach() {
                superview = UIView()
                superview.frame = CGRect(x: 10, y: 10, width: 120, height: 220)
                
                view = UIView()
                view.backgroundColor = .red
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
                
                it("it should not be visible if it is out of bounds off parent view (right)") {
                    view.frame = CGRect(x: 5000, y: 0, width: 100, height: 200)
                    expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                }
                
                it("it should not be visible if it is out of bounds off parent view (bottom)") {
                    view.frame = CGRect(x: 0, y: 5000, width: 100, height: 200)
                    expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                }
                
                it("it should not be visible if it is out of bounds off parent view (top)") {
                    view.frame = CGRect(x: 0, y: -5000, width: 100, height: 200)
                    expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                }
                
                it("it should not be visible if it is out of bounds off parent view (left)") {
                    view.frame = CGRect(x: -5000, y: 0, width: 100, height: 200)
                    expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                }
                
                describe("and parent is not visible") {
                    beforeEach() {
                        superview.alpha = 0
                        superview.addSubview(view)
                    }
                    
                    it("it should be visible") {
                        expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                    }
                    
                    it("it should not be visible if it is hidden=true") {
                        view.isHidden = true
                        expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                    }
                    
                    it("it should not be visible if it is alpha=0") {
                        view.alpha = 0
                        expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                    }
                    
                    it("it should not be visible if it is out of bounds off parent view (right)") {
                        view.frame = CGRect(x: 5000, y: 0, width: 100, height: 200)
                        expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                    }
                    
                    it("it should not be visible if it is out of bounds off parent view (bottom)") {
                        view.frame = CGRect(x: 0, y: 5000, width: 100, height: 200)
                        expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                    }
                    
                    it("it should not be visible if it is out of bounds off parent view (top)") {
                        view.frame = CGRect(x: 0, y: -5000, width: 100, height: 200)
                        expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                    }
                    
                    it("it should not be visible if it is out of bounds off parent view (left)") {
                        view.frame = CGRect(x: -5000, y: 0, width: 100, height: 200)
                        expect(view.spec.check.isVisible(on: superview)).to(beFalsy())
                    }
                }
            }
            
            describe("when on scroll view") {
                beforeEach() {
                    scrollView = UIScrollView()
                    scrollView.contentSize = CGSize(width: 5000, height: 5000)
                    
                    scrollView.frame = CGRect(x: 0, y: 0, width: 320, height: 320)
                    
                    scrollView.addSubview(view)
                }
                
                it("it should not be visible if it is out of bounds off parent view (right)") {
                    view.frame = CGRect(x: 5000, y: 0, width: 100, height: 200)
                    expect(view.spec.check.isVisible(on: scrollView)).to(beFalsy())
                }
                
                it("it should not be visible if it is out of bounds off parent view (bottom)") {
                    view.frame = CGRect(x: 0, y: 5000, width: 100, height: 200)
                    expect(view.spec.check.isVisible(on: scrollView)).to(beFalsy())
                }
                
                it("it should not be visible if it is out of bounds off parent view (top)") {
                    view.frame = CGRect(x: 0, y: -5000, width: 100, height: 200)
                    expect(view.spec.check.isVisible(on: scrollView)).to(beFalsy())
                }
                
                it("it should not be visible if it is out of bounds off parent view (left)") {
                    view.frame = CGRect(x: -5000, y: 0, width: 100, height: 200)
                    expect(view.spec.check.isVisible(on: scrollView)).to(beFalsy())
                }
                
                describe("with an offset") {
                    it("it should not be visible if it is out of bounds off parent view (right)") {
                        view.frame = CGRect(x: 5000, y: 0, width: 100, height: 200)
                        scrollView.contentOffset = CGPoint(x: -5000, y: 0)
                        
                        expect(view.spec.check.isVisible(on: scrollView)).to(beTruthy())
                    }
                    
                    it("it should not be visible if it is out of bounds off parent view (bottom)") {
                        view.frame = CGRect(x: 0, y: 5000, width: 100, height: 200)
                        scrollView.contentOffset = CGPoint(x: 0, y: -5000)
                        
                        expect(view.spec.check.isVisible(on: scrollView)).to(beTruthy())
                    }
                    
                    it("it should not be visible if it is out of bounds off parent view (top)") {
                        view.frame = CGRect(x: 0, y: -5000, width: 100, height: 200)
                        scrollView.contentOffset = CGPoint(x: 0, y: 4800)
                        
                        expect(view.spec.check.isVisible(on: scrollView)).to(beTruthy())
                    }
                    
                    it("it should not be visible if it is out of bounds off parent view (left)") {
                        view.frame = CGRect(x: -5000, y: 0, width: 100, height: 200)
                        scrollView.contentOffset = CGPoint(x: 4900, y: 0)
                        
                        expect(view.spec.check.isVisible(on: scrollView)).to(beTruthy())
                    }
                }
            }
        }
    }
}
