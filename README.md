# SpecTools

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/SpecTools.svg?style=flat)](http://cocoapods.org/pods/SpecTools)
[![License](https://img.shields.io/cocoapods/l/SpecTools.svg?style=flat)](http://cocoapods.org/pods/SpecTools)
[![Platform](https://img.shields.io/cocoapods/p/SpecTools.svg?style=flat)](http://cocoapods.org/pods/SpecTools)

Library that helps you write less code when testing interface in your iOS apps.

## Implementation

After you add SpecTools framework a set of options will become available for most of the UI elements through a spec property.

These are:
* action
    * simulate tap on a button or view with a gesture recognizer
* check
    * check if a view is trully visible on screen
* find
    * locate any element on the screen based on their content or type
* prepare
    * prepare your view controller like it would get setup in a real enviroment
    * change size of the view for any device screen during runtime to check all is still visible

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
            
        }
        
    }
    
}
```

## Demo app with tests

To run the example project: 
* Clone the repo, and run `pod install` from the Example directory.
* Cmd+U to run example tests

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

## Author

Ondrej Rafaj, dev@mangoweb.cz

## License

SpecTools is available under the MIT license. See the LICENSE file for more info.
