import UIKit
import SnapKit


class ViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    
    let button1 = UIButton()
    let longPressButton = UIButton()
    
    let barButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
    
    
    // MARK: Test properties
    var didLoadView: Bool = false
    var didViewDidLoad: Bool = false
    var didViewWillAppear: Bool = false
    var didViewDidAppear: Bool = false
    
    // MARK: View lifecycle
    
    override func loadView() {
        super.loadView()
        
        didLoadView = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        didViewDidLoad = true
        
        title = "SpecTools!"
        
        view.backgroundColor = .white
        
        // Label 1
        label1.text = "My first label"
        label1.textAlignment = .center
        label1.isUserInteractionEnabled = true
        view.addSubview(label1)
        label1.snp.makeConstraints { (make) in
            make.top.equalTo(74)
            make.left.right.equalToSuperview()
        }
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(didTapLabel1Action(_:)))
        label1.addGestureRecognizer(tap1)
        
        // Screate scroll view
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(label1.snp.bottom).offset(12)
            make.left.right.bottom.equalToSuperview()
        }
        
        // Label 2
        label2.text = "My second label sitting in a scrollview"
        label2.textAlignment = .center
        scrollView.addSubview(label2)
        label2.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.right.equalTo(label1)
        }
        
        button1.setTitle("Launch table view controller", for: .normal)
        button1.addTarget(self, action: #selector(didTapButton1(_:)), for: .touchUpInside)
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.layer.borderWidth = 1
        button1.layer.cornerRadius = 5
        button1.setTitleColor(.gray, for: .normal)
        scrollView.addSubview(button1)
        button1.snp.makeConstraints { (make) in
            make.top.equalTo(label2.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(36)
        }
        
        longPressButton.setTitle("Long press button", for: .normal)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        longPressButton.addGestureRecognizer(longPressGesture)
        longPressButton.layer.borderColor = UIColor.lightGray.cgColor
        longPressButton.layer.borderWidth = 1
        longPressButton.layer.cornerRadius = 5
        longPressButton.setTitleColor(.gray, for: .normal)
        scrollView.addSubview(longPressButton)
        longPressButton.snp.makeConstraints { (make) in
            make.top.equalTo(button1.snp.bottom).offset(20)
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(36)
        }
        
        self.navigationItem.rightBarButtonItem = self.barButtonItem
        self.barButtonItem.target = self
        self.barButtonItem.action = #selector(didTapBarButtonItem(_:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        didViewWillAppear = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        didViewDidAppear = true
    }
    
    // MARK: Actions
    
    var didTapLabel1: Bool = false
    
    @objc func didTapLabel1Action(_ sender: UITapGestureRecognizer) {
        print("Did tap label1")
        didTapLabel1 = true
    }
    
    @objc func didTapButton1(_ sender: UIButton) {
        let c = TableViewController()
        navigationController?.pushViewController(c, animated: true)
    }
    
    var didLongTap: Bool  = false
    
    @objc func longTap(_ sender: UIGestureRecognizer) {
        didLongTap = true
    }
    
    var didTapBarButtonItem: Bool = false

    @objc func didTapBarButtonItem(_ sender: UIBarButtonItem) {
        didTapBarButtonItem = true
    }
}
