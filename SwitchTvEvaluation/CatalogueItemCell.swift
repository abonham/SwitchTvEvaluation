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
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func configureCell(for item: ContentItem?, orientation: ContentOrientation) {
        if item != nil { self.item = item }
        self.orientation = orientation
        thumbnailImageView.image = nil
        titleLabel.text = self.item?.title
        titleLabel.textColor = .white
        
        let placehoder = UIImage(named: "darkgray_placeholder")
        let filter = AspectScaledToFitSizeFilter(size: orientation.size)
        
        if let imageUrl = self.item?.images?.imageUrl(for: self.orientation) {
            thumbnailImageView.af_setImage(withURL: imageUrl, placeholderImage: placehoder, filter: filter)
        } else {
            thumbnailImageView.image = placehoder
        }
        
        // removing views from super is used to clear existing constraints
        thumbnailImageView.removeFromSuperview()
        titleLabel.removeFromSuperview()
        
        setupConstraints()
    }
    
    func setupView() {
        thumbnailImageView.adjustsImageWhenAncestorFocused = true
        thumbnailImageView.contentMode = .scaleAspectFit
        titleLabel.lineBreakMode = .byTruncatingTail
        
    }
    
    func setupConstraints() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)

        let horizontalInset = orientation.cellInsets.x
        let verticalInset = orientation.cellInsets.y
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

