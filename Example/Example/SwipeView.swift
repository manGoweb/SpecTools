import UIKit
import SnapKit

class SwipeView: UIView {

    let upView: UIView = Subviews.view(color: .green, text: "UP")
    let leftView: UIView = Subviews.view(color: .red, text: "LEFT")
    let rightView: UIView = Subviews.view(color: .blue, text: "RIGHT")
    let downView: UIView = Subviews.view(color: .gray, text: "DOWN")

    init() {
        super.init(frame: .zero)

        setUpSelf()
        addSubviews()
        setupLayout()
    }

    private func setUpSelf() {
        backgroundColor = .white
    }

    // MARK: Subviews

    private let stackView: UIStackView = Subviews.stackView

    private func addSubviews() {
        [upView, leftView, rightView, downView].forEach {
            stackView.addArrangedSubview($0)
        }

        addSubview(stackView)
    }

    // MARK: Layout

    private func setupLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        [upView, leftView, rightView, downView].forEach { view in
            view.snp.makeConstraints {
                $0.width.equalToSuperview()
            }
        }
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

private extension SwipeView {

    enum Subviews {
        static func view(color: UIColor, text: String) -> LabeledView {
            let view = LabeledView()
            view.backgroundColor = color
            view.label.text = text

            return view
        }

        static var stackView: UIStackView {
            let stackView = UIStackView(frame: .zero)
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fillEqually
            stackView.spacing = 5

            return stackView
        }
    }

}
