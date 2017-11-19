//
//  CatalogueItemCell.swift
//  SwitchTvEvaluation
//
//  Created by Aaron Bonham on 20/11/17.
//  Copyright © 2017 Aaron Bonham. All rights reserved.
//

import UIKit
import AlamofireImage

class CatalogueItemCell: UICollectionViewCell {
    let thumbnailImageView = UIImageView()
    let titleLabel = UILabel()
    var item: ContentItem?
    var orientation = ContentOrientation.landscape
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureCell(for item: ContentItem?, orientation: ContentOrientation) {
        if item != nil { self.item = item }
        self.orientation = orientation
        thumbnailImageView.image = nil
        titleLabel.text = self.item?.title
        titleLabel.textColor = .white
        var urlString: String?
        switch orientation {
        case .landscape:
            urlString = self.item?.images?.landscape
        case .portrait:
            urlString = self.item?.images?.portrait
        }
        if urlString != nil, let imageUrl = URL(string: urlString!) {
            thumbnailImageView.af_setImage(withURL: imageUrl)
        }
        setupView()
    }
    
    func setupView() {
        thumbnailImageView.removeFromSuperview()
        titleLabel.removeFromSuperview()
        thumbnailImageView.adjustsImageWhenAncestorFocused = true
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.backgroundColor = .lightGray
        titleLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        setupConstraints()
    }
    
    func setupConstraints() {
        var horizontalInset: CGFloat
        var verticalInset: CGFloat
        switch orientation {
        case .landscape:
            horizontalInset = 16
            verticalInset = 8
        case .portrait:
            horizontalInset = 8
            verticalInset = 32
        }
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let margins = layoutMarginsGuide
        margins.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        thumbnailImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: horizontalInset).isActive = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -horizontalInset).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: margins.topAnchor, constant: verticalInset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: verticalInset).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44).isActive = true
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
}

