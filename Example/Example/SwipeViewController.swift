import UIKit

class SwipeViewController: UIViewController {

    var didSwipeUp: (() -> Void)?
    var didSwipeLeft: (() -> Void)?
    var didSwipeRight: (() -> Void)?
    var didSwipeDown: (() -> Void)?

    var swipeView: SwipeView { return view as! SwipeView }

    // MARK: - Lifecycle

    override func loadView() {
        view = SwipeView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSwipeGestures()
    }

    // MARK: - Private

    private func setUpSwipeGestures() {
        setUpSwipeGesture(direction: .up, action: #selector(swipedUp), in: swipeView.upView)
        setUpSwipeGesture(direction: .left, action: #selector(swipedLeft), in: swipeView.leftView)
        setUpSwipeGesture(direction: .right, action: #selector(swipedRight), in: swipeView.rightView)
        setUpSwipeGesture(direction: .down, action: #selector(swipedDown), in: swipeView.downView)
    }

    // MARK: Actions

    private func setUpSwipeGesture(direction: UISwipeGestureRecognizer.Direction, action: Selector?, in view: UIView) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: action)
        swipeGesture.direction = direction
        view.addGestureRecognizer(swipeGesture)
    }

    @objc
    private func swipedUp() {
        print("SWIPED UP")
        didSwipeUp?()
    }

    @objc
    private func swipedLeft() {
        print("SWIPED LEFT")
        didSwipeLeft?()
    }

    @objc
    private func swipedRight() {
        print("SWIPED RIGHT")
        didSwipeRight?()
    }

    @objc
    private func swipedDown() {
        print("SWIPED DOWN")
        didSwipeDown?()
    }

}
