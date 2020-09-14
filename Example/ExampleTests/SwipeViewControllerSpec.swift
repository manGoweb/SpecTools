@testable import Example
import Nimble
import Quick
import SpecTools

class SwipeViewControllerSpec: QuickSpec {

    override func spec() {
        describe("SwipeViewController") {
            var subject: SwipeViewController!

            beforeEach {
                subject = SwipeViewController(nibName: nil, bundle: nil)
            }

            afterEach {
                subject = nil
            }

            describe("view is loaded") {
                beforeEach {
                    _ = subject.view
                }

                describe("callbacks are configured") {
                    var swipedUpCount: Int = 0
                    var swipedLeftCount: Int = 0
                    var swipedRightCount: Int = 0
                    var swipedDownCount: Int = 0

                    beforeEach {
                        subject.didSwipeUp = { swipedUpCount += 1 }
                        subject.didSwipeLeft = { swipedLeftCount += 1 }
                        subject.didSwipeRight = { swipedRightCount += 1 }
                        subject.didSwipeDown = { swipedDownCount += 1 }
                    }

                    afterEach {
                        swipedUpCount = 0
                        swipedLeftCount = 0
                        swipedRightCount = 0
                        swipedDownCount = 0

                        subject.didSwipeUp = nil
                        subject.didSwipeLeft = nil
                        subject.didSwipeRight = nil
                        subject.didSwipeDown = nil
                    }

                    describe("when swipe up on upView") {
                        beforeEach {
                            subject.swipeView.upView.spec.action.triggerSwipe(direction: .up)
                        }

                        it("should trigger didSwipeUp callback once") {
                            expect(swipedUpCount) == 1
                            expect(swipedLeftCount) == 0
                            expect(swipedRightCount) == 0
                            expect(swipedDownCount) == 0
                        }
                    }

                    describe("when swipe left on leftView") {
                        beforeEach {
                            subject.swipeView.leftView.spec.action.triggerSwipe(direction: .left)
                        }

                        it("should trigger didSwipeLeft callback once") {
                            expect(swipedUpCount) == 0
                            expect(swipedLeftCount) == 1
                            expect(swipedRightCount) == 0
                            expect(swipedDownCount) == 0
                        }
                    }

                    describe("when swipe right on rightView") {
                        beforeEach {
                            subject.swipeView.rightView.spec.action.triggerSwipe(direction: .right)
                        }

                        it("should trigger didSwipeRight callback once") {
                            expect(swipedUpCount) == 0
                            expect(swipedLeftCount) == 0
                            expect(swipedRightCount) == 1
                            expect(swipedDownCount) == 0
                        }
                    }

                    describe("when swipe down on downView for the first time") {
                        beforeEach {
                            subject.swipeView.downView.spec.action.triggerSwipe(direction: .down)
                        }

                        it("should trigger didSwipeDown callback once") {
                            expect(swipedUpCount) == 0
                            expect(swipedLeftCount) == 0
                            expect(swipedRightCount) == 0
                            expect(swipedDownCount) == 1
                        }

                        describe("when swipe down on downView for the second time") {
                            beforeEach {
                                subject.swipeView.downView.spec.action.triggerSwipe(direction: .down)
                            }

                            it("should trigger didSwipeDown callback for the second time") {
                                expect(swipedUpCount) == 0
                                expect(swipedLeftCount) == 0
                                expect(swipedRightCount) == 0
                                expect(swipedDownCount) == 2
                            }
                        }
                    }

                    describe("when swipe up on downView") {
                        beforeEach {
                            subject.swipeView.downView.spec.action.triggerSwipe(direction: .up)
                        }

                        it("should NOT trigger any callback") {
                            expect(swipedUpCount) == 0
                            expect(swipedLeftCount) == 0
                            expect(swipedRightCount) == 0
                            expect(swipedDownCount) == 0
                        }
                    }
                }
            }
        }
    }

}
