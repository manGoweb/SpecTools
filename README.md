![Alamofire: Elegant Networking in Swift](https://raw.githubusercontent.com/manGoweb/SpecTools/master/Assets/Icon.png)

# SpecTools

[![CircleCI](https://img.shields.io/circleci/project/github/manGoweb/SpecTools/master.svg?style=plastic)](https://circleci.com/gh/manGoweb/SpecTools)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/SpecTools.svg?style=flat)](http://cocoapods.org/pods/SpecTools)
[![License](https://img.shields.io/cocoapods/l/SpecTools.svg?style=flat)](http://cocoapods.org/pods/SpecTools)
[![Platform](https://img.shields.io/cocoapods/p/SpecTools.svg?style=flat)](http://cocoapods.org/pods/SpecTools)
[![Docs](https://raw.githubusercontent.com/manGoweb/SpecTools/master/docs/badge.svg?sanitize=true)](https://github.com/manGoweb/SpecTools/tree/master/docs)
[![Twitter](https://img.shields.io/badge/twitter-@rafiki270-blue.svg?style=flat)](http://twitter.com/rafiki270)

Library that helps you write less code when testing interface in your iOS apps.

## Implementation

After you add SpecTools framework a set of options will become available for most of the UI elements through a spec property.

These are:
* action
    * simulate tap on a button with specific action event
    * simulate gesture recognizer taps
* check
    * if a view is truly visible on screen
    * view controllers and navigation stacks
    * table views have the right content in their cells
* find
    * locate any element or elements on the screen based on their content or type
    * any text on any UI element
* prepare
    * prepare your view controller like it would get setup in a real environment
    * change size of the view for any device screen during runtime to check all is still visible
    * assign your test view controllers to a mock navigation controller in order to track `pushViewController` or `popViewController` methods

There is a space for a lot more additional functionality so please feel free to raise issues with feature requests.

An example implementation is shown below:

```Swift
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
                // Check if the label is truly visible and print out the entire view structure that is being checked
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
                // Check if the label is visible on subjects view and print all frames we encounter on the way
                expect(element?.spec.check.isVisible(on: subject.view, visualize: .frames)).to(beTrue())
            })
            
            describe("when we tap on button1") {
                beforeEach {
                    // Simulate button tap
                    button1.spec.action.tap()
                }
            
                it("should have pushed new view controller") {
                    // Check we have new view controller in the navigation stack
                    expect(subject.navigationController?.spec.check.contains(viewControllerClass: TableViewController.self)).to(beTrue())
                }
            }
            
        }
        
    }
    
}
```

## Demo app with tests

To run the example project: 
* Clone the repo, and run `pod install` from the Example directory.
* Cmd+U to run example tests

## Documentation

Jazzy based documentation is available here [![Docs](https://raw.githubusercontent.com/manGoweb/SpecTools/master/docs/badge.svg?sanitize=true)](https://github.com/manGoweb/SpecTools/tree/master/docs). Proper web based one is coming.

## Requirements

This library can be run completely independently. It does not need quick and nimble although we highly recommend your give these libraries a go!

## Installation

#### Cocoapods

SpecTools is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your test target in a Podfile:

```ruby
target 'SpecToolsExampleTests' do
	pod "SpecTools"
end
```

#### Carthage

SpecTools is also available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile and than import the framework into your test target.
```ruby
github "manGoweb/SpecTools"
```

## Usage

Following section should contain all of the methods available

#### Action

Simulate tap on a UIButton
```Swift
button1.spec.action.tap()
// or
button1.spec.action.tap(event: .touchUpInside)
```

Simulate tap on a view with UITapGestureRecognizer(s)
```Swift
view.spec.action.triggerTap()
// or
view.spec.action.triggerTap(taps: 3, touches: 2)
```

Execute action on any UIGestureRecognizer
```Swift
recognizer.spec.action.execute()
```

Get array of targets from any UIGestureRecognizer
 - Return `[(target: AnyObject, action: Selector)]`
```Swift
recognizer.spec.action.getTargetInfo()
```

#### Checks

Is view truly visible on the screen? Checks if the element (and all parent views) have superview, have alpha, are not hidden and have a valid on-screen frame.
```Swift
view.spec.check.isVisible() // Example 1
// or
view.spec.check.isVisible(on: viewController.view, visualize: .all) // Example 2
```
Example 1) Ignores the last view having no superview, expects it to be view controllers view for example
Example 2) Checks visibility against another view, also an entire recursed view structure can be printed to the console

## Author

Ondrej Rafaj, dev@mangoweb.cz

## License

SpecTools is available under the MIT license. See the LICENSE file for more info.

