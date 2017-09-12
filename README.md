![Alamofire: Elegant Networking in Swift](https://raw.githubusercontent.com/manGoweb/SpecTools/master/Assets/Icon.png)

# SpecTools

[![CircleCI](https://img.shields.io/circleci/project/github/manGoweb/SpecTools/master.svg?style=plastic)](https://circleci.com/gh/manGoweb/SpecTools)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/SpecTools.svg?style=flat)](http://cocoapods.org/pods/SpecTools)
[![License](https://img.shields.io/cocoapods/l/SpecTools.svg?style=flat)](http://cocoapods.org/pods/SpecTools)
[![Platform](https://img.shields.io/cocoapods/p/SpecTools.svg?style=flat)](http://cocoapods.org/pods/SpecTools)
[![Docs](http://mangoweb.github.io/SpecTools/docs/latest/badge.svg)](http://mangoweb.github.io/SpecTools/docs/latest/)
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

Jazzy based documentation is available here [![Docs](http://mangoweb.github.io/SpecTools/docs/latest/badge.svg)](http://mangoweb.github.io/SpecTools/docs/latest/).

Online documentation should always reflect the latest code available on `master` branch.

## Requirements

This library can be run completely independently. It does not need quick and nimble although we highly recommend your give these libraries a go!

## Installation

For Swift 4 support please refer to `swift4` branch!

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

### Debugging

Some methods have a debugging mechanisms available. The most common one is `visualize` parameter which allows you to print out usually a tree of elements SpecTools have recursed through

Following section should contain all of the methods available

### Actions

#### Simulating taps

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

#### Executing gesture recognizers

Execute action on any UIGestureRecognizer
```Swift
recognizer.spec.action.execute()
```

Get array of targets from any UIGestureRecognizer
 - Return `[(target: AnyObject, action: Selector)]`
```Swift
recognizer.spec.action.getTargetInfo()
```

### Checks

#### Checking view visibility

Is view truly visible on the screen? Checks if the element (and all parent views) have superview, have alpha, are not hidden and have a valid on-screen frame.
```Swift
view.spec.check.isVisible() // Example 1
// or
view.spec.check.isVisible(on: viewController.view, visualize: .all) // Example 2
```
Example 1) Ignores the last view having no superview, expects it to be view controllers view for example

Example 2) Checks visibility against another view, also an entire recursed view structure can be printed to the console

#### Checking table view cells

Check if all UITableViewCells available through the UITableView data source evaluate correctly
```Swift
// Create an anumerate closure
let doesFitClosure: (UITableViewCell)->Bool = { (cell) -> Bool in
	guard let cell = cell as? TableViewCell else {
		return false
	}
	if cell.customLabel.text?.characters.count == 0 {
		return false
	}
	return true
}

// Test all cells generated by the data source are ok
let ok = subject.tableView.spec.check.allCells(fit: doesFitClosure)
```

You can also ask for an array of IndexPaths that don't fit the criteria
```Swift
let indexPaths: [IndexPath] = subject.tableView.spec.check.allCells(thatDontFit: doesFitClosure)
```

#### UIViewController checks

Look for a specific view controller in your navigation stack
```Swift
let ok: Bool = viewController.spec.check.has(siblingInNavigationStack: anotherViewController)
```

Check if a view controller has a child view controller
```Swift
let ok: Bool = viewController.spec.check.has(childViewController: childViewController)
```

Check if a view controller has a specific class type in its navigation stack
```Swift
let ok: Bool = viewController.spec.check.contains(siblingClassInNavigationStack: AnotherViewController.self)
```

Check if a view controller has specific class type of a child view controller
```Swift
let ok: Bool = viewController.spec.check.contains(childViewControllerClass: ChildViewController.self)
```

#### UINavigationController checks

Check is navigation view controller contains certain view controller
```Swift
let ok: Bool = navigationController.spec.check.has(viewController: vc)
```

Check is navigation view controller contains certain type of a view controller
```Swift
let ok: Bool = viewController.spec.check.contains(viewControllerClass: MyCustomViewController.self)
```

### Find

#### Gesture recognizers

Find all gesture recognizers of a certain type (generic method)
```Swift
let recognizers: [UISwipeGestureRecognizer] = view.spec.find.all(gestureRecognizersOfType: UISwipeGestureRecognizer.self)
```

### Prepare

#### Prepare view controllers for testing

Will touch view of a view controller in order to get loadView and viewDidLoad called, than manually calls viewWillAppear and viewDidAppear with animations disabled
```Swift
viewController.spec.prepare.simulatePresentViewController()
```

Set a new, specific size for a view controllers view during runtime
```Swift
viewController.spec.prepare.set(viewSize: CGSize(width: 375.0, height: 1500))
```

Set a screensize of a desired device on a view of your view controller, you can specify a custom height. Custom height might be useful when scrollviews are present
```Swift
viewController.spec.prepare.set(viewSize: .iPhone6Plus)
// or
let customHeight: CGFloat = 5000.0
viewController.spec.prepare.set(viewSize: .iPhone6Plus, height: customHeight)
```

Give view controller a navigation controller
```Swift
viewController.spec.prepare.assignNavigationController()
// or
viewController.spec.prepare.assignNavigationController(ofClass: CustomNavigationViewController.self)
```

Give view controller a mock navigation controller which mainly allows for testing push/pop functionality
```Swift
viewController.spec.prepare.assignMockNavigationController()
```




## Author

Ondrej Rafaj, dev@mangoweb.cz

## License

SpecTools is available under the MIT license. See the LICENSE file for more info.

