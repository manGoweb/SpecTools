import UIKit
import Quick
import Nimble
import SpecTools

@testable import Example


class CollectionViewControllerSpec: QuickSpec {
    
    override func spec() {
        var subject: CollectionViewController!
        
        describe("CollectionViewController") {
            var tapped: Bool = false
            
            beforeEach {
                // Create the subject
                subject = CollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
                
                // Give subject a navigation controller
                _ = subject.spec.prepare.assignMockNavigationController()
                
                // Simulate view controller being presented to the screen
                subject.spec.prepare.simulatePresentViewController()
                // Reset the view to specific size
                subject.spec.prepare.set(viewSize: .iPhone6Plus)
                
                subject.didTapOnCell = { indexPath in
                    tapped = true
                }
                subject.collectionView!.spec.action.tap(item: 0)
            }
            
            it("should receive tap on a cell") {
                expect(tapped).toEventually(equal(true))
            }
        }
    }
}
