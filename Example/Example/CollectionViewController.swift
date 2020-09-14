import UIKit
import SnapKit


class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var didTapOnCell: ((_ indexPath: IndexPath)->())?
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//        collectionView?.delegate   = self
//        collectionView?.dataSource = self
//
//        view.addSubview(collectionView!)
//        collectionView?.snp.makeConstraints({ (make) in
//            make.edges.equalToSuperview()
//        })
    }
    
    // MARK: Collection view delegate & data source methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 300
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapOnCell?(indexPath)
    }
}
