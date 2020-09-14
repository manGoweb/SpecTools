import SnapKit
import UIKit

class LabeledView: UIView {

    let label: UILabel = Subviews.label

    init() {
        super.init(frame: .zero)

        addSubviews()
        setUpLayout()
    }

    // MARK: - Subviews

    private func addSubviews() {
        addSubview(label)
    }

    // MARK: - Layout

    private func setUpLayout() {
        label.snp.makeConstraints {
            $0.top.trailing.lessThanOrEqualToSuperview()
            $0.bottom.leading.lessThanOrEqualToSuperview()
            $0.center.equalToSuperview()
        }
    }

    // MARK: - Required initializer

    required init?(coder _: NSCoder) { return nil }

}

private extension LabeledView {

    enum Subviews {
        static var label: UILabel {
            let label = UILabel(frame: .zero)
            label.textColor = .white
            label.font = UIFont.systemFont(ofSize: 15.0, weight: .bold)
            label.textAlignment = .center

            return label
        }
    }

}
