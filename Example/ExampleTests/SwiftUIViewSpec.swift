import UIKit
import Quick
import Nimble
import SpecTools

@testable import Example


class SwiftUIViewSpec: QuickSpec {
    
    override func spec() {
        
        var subject: UIView!
        
        describe("ViewController") {
            beforeEach {
                // Create the subject
                subject = Prepare(DetailScreenView())
                
                
            }
            
            it("should have gone through the whole initial lifecycle procedure") {
//                expect(subject.didLoadView).to(beTrue())
            }
            
        }
    }
}
