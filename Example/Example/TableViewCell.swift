import UIKit
import SnapKit


class TableViewCell: UITableViewCell {
    
    let customView = UIView()
    let customLabel = UILabel()
    let customImageView = UIImageView()
    
    // MARK: Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        customView.backgroundColor = .lightGray
        contentView.addSubview(customView)
        customView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalTo(-36)
            make.width.equalTo(60)
        }
        
        customLabel.font = UIFont.systemFont(ofSize: 10)
        customLabel.textColor = .gray
        customView.addSubview(customLabel)
        customLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(12)
        }
        
        customImageView.contentMode = .scaleAspectFill
        customImageView.clipsToBounds = true
        customView.addSubview(customImageView)
        customImageView.snp.makeConstraints { (make) in
            make.top.equalTo(customLabel.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
