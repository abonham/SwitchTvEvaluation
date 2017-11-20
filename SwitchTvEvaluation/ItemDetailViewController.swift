//
//  AppDelegate.swift
//  SwitchTvEvaluation
//
//  Created by Aaron Bonham on 20/11/17.
//  Copyright © 2017 Aaron Bonham. All rights reserved.
//

import UIKit
import AlamofireImage

class ItemDetailViewController: UIViewController {
    var item: ContentItem?
    
    let bannerImageView = UIImageView()
    let previewImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    func configure(for item: ContentItem) {
        self.item = item
        updateView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupConstraints()
    }
    
    func updateView() {
        titleLabel.text = item?.title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 72)
        descriptionLabel.text = item?.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        if let urlString = item?.images?.landscape, let url = URL(string: urlString) {
            bannerImageView.af_setImage(withURL: url)
        }
        if let previewUrlString = item?.images?.portrait, let previewUrl = URL(string: previewUrlString) {
            previewImageView.af_setImage(withURL: previewUrl)
        }
        view.setNeedsUpdateConstraints()
        updateViewConstraints()
    }
    
    func setupConstraints() {
        let previewSize = ContentOrientation.portrait.size
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        previewImageView.contentMode = .scaleAspectFit
        bannerImageView.contentMode = .scaleAspectFill
        view.addSubview(bannerImageView)
        view.addSubview(previewImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        let margins = view.layoutMarginsGuide
        descriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        bannerImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bannerImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bannerImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bannerImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        previewImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        previewImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -16).isActive = true
        previewImageView.heightAnchor.constraint(equalToConstant: previewSize.height).isActive = true
        previewImageView.widthAnchor.constraint(equalToConstant: previewSize.width).isActive = true
        view.setNeedsUpdateConstraints()
    }
}

