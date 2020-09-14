import SwiftUI


extension Prepare where T: View {
    
    public func testableView() -> UIView {
        let c = UIHostingController(rootView: element)
        c.spec.prepare.simulatePresentViewController()
        c.spec.prepare.set(viewSize: DeviceScreenSize.iPhone6)
        return c.view
    }
    
}
