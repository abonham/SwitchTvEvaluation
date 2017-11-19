//
//  SwitchTvEvaluation
//
//  Created by Aaron Bonham on 20/11/17.
//  Copyright © 2017 Aaron Bonham. All rights reserved.
//

import UIKit

enum ContentOrientation {
    case portrait
    case landscape
    
    var size: CGSize {
        switch self {
        case .portrait:
            return CGSize(width: 270, height: 480)
        case .landscape:
            return CGSize(width: 480, height: 270)
        }
    }
}

class SectionCollectionViewCell: UITableViewCell, UICollectionViewDelegate {
    
    fileprivate let reuseID = "collectionCell"
    fileprivate var orientation = ContentOrientation.landscape
    
    fileprivate var catalogueCollectionView: UICollectionView? {
        didSet {
            catalogueCollectionView!.register(CatalogueItemCell.self,   forCellWithReuseIdentifier: reuseID)
            catalogueCollectionView!.delegate = self
            catalogueCollectionView!.dataSource = self
            addSubview(catalogueCollectionView!)
        }
    }
    
    fileprivate var category: ContentCategory?
    
    fileprivate func setupView(orientation: ContentOrientation?) {
        catalogueCollectionView?.removeFromSuperview()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = orientation?.size ?? ContentOrientation.landscape.size
        layout.minimumLineSpacing = 16
        catalogueCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView(orientation: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView(orientation: nil)
    }
    
    func configureForSection(orientation: ContentOrientation, category: ContentCategory) {
        self.category = category
        self.orientation = orientation
        setupView(orientation: orientation)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        catalogueCollectionView?.frame = bounds
        updateConstraintsIfNeeded()
    }
}

extension SectionCollectionViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseID, for: indexPath) as! CatalogueItemCell
        cell.configureCell(for: category?.items?[indexPath.item], orientation: orientation)
        return cell
    }
}

