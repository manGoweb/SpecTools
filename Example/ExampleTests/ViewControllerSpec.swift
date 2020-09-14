import UIKit
import Quick
import Nimble
import SpecTools

@testable import Example


class ViewControllerSpec: QuickSpec {
    
    override func spec() {
        
        var subject: ViewController!
        
        var button1: UIButton!
        var longPressButton: UIButton!
        var barButtonItem: UIBarButtonItem!
        
        describe("ViewController") {
            beforeEach {
                // Create the subject
                subject = ViewController()
                
                // Give subject a navigation controller
                _ = subject.spec.prepare.assignMockNavigationController()
                
                // Simulate view controller being presented to the screen
                subject.spec.prepare.simulatePresentViewController()
                // Reset the view to specific size
                subject.spec.prepare.set(viewSize: .iPhone6Plus)
                
                // Get a button that equals "Launch table view controller" and print how we get to it in the console including all frames and any text if present
                button1 = subject.view.spec.find.first(buttonWithText: "Launch table view controller", visualize: .all)!
                
                // Get a button that equals "Long press button"
                longPressButton = subject.view.spec.find.first(buttonWithText: "Long press button")!
                
                barButtonItem = subject.barButtonItem
            }
            
            it("should have gone through the whole initial lifecycle procedure") {
                // Just checking if all view lifecycle methods get called
                expect(subject.didLoadView).to(beTrue())
                expect(subject.didViewDidLoad).to(beTrue())
                expect(subject.didViewWillAppear).to(beTrue())
                expect(subject.didViewDidAppear).to(beTrue())
            }
            
            it("has a visible label1") {
                // Get your first label
                let element = subject.view.spec.find.first(labelWithText: "My first label")
                // Check if the label is truly visible
                expect(element?.spec.check.isVisible(visualize: .text)).to(beTrue())
            }
            
            describe("on label1") {
                beforeEach {
                    // Get your first label
                    let element = subject.view.spec.find.first(labelWithText: "My first label")
                    // Trigger a tap
                    element?.spec.action.triggerTap()
                }
                
                it("should be able to trigget tap gesture recognizer") {
                    // Check if action has been triggered
                    expect(subject.didTapLabel1).to(beTrue())
                }
            }
            
            it("has a visible scrollView") {
                // Get a scroll view
                let element = subject.view.spec.find.firstScrollView()
                // Check visibility
                expect(element?.spec.check.isVisible()).to(beTrue())
            }
            
            it("has a visible label2") {
                // Get a label that contains "second label" and print how we get to it in the console including any text on visible elements
                let element = subject.view.spec.find.first(labelWithText: "second label", exactMatch: false, visualize: .text)
                // Check if the label is visible on subjects view
                expect(element?.spec.check.isVisible(on: subject.view, visualize: .text)).to(beTrue())
            }
            
            it("has a visible button1") {
                // Check if the button is visible on subjects view
                expect(button1.spec.check.isVisible(on: subject.view)).to(beTrue())
            }
            
            describe("when we tap on button1") {
                beforeEach {
                    // Simulate button tap
                    button1.spec.action.tap()
                }
                
                it("should have pushed a new view controller") {
                    // Check we got two view controllers in the navigation stack now
                    expect(subject.navigationController?.viewControllers.count).to(equal(2))
                }
                
                it("should have pushed TableViewController") {
                    // Check we have TableViewController in the navigation stack
                    expect(subject.navigationController?.spec.check.contains(viewControllerClass: TableViewController.self)).to(beTrue())
                }
            }
            
            describe("when we long press on long press button") {
                beforeEach {
                    // Simulate long press on button
                    longPressButton.spec.action.triggerLongPress()
                }
                
                it("should have pushed a new view controller") {
                    // Check longTap function was called
                    expect(subject.didLongTap).toEventually(beTrue())
                }
            }
            
            describe("when we tap on barButtonItem") {
                beforeEach {
                    // Simulate long press on button
                    barButtonItem.spec.action.tap()
                }
                
                it("should be able to trigget tap bar button item") {
                    // Check didTabBarButtonItem function was called
                    expect(subject.didTapBarButtonItem).to(beTrue())
                }
            }
        }
    }
}
