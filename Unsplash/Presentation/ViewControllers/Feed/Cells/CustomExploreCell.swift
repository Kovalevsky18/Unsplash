//
//  CustomExploreCell.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/8/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

final class CustomExploreCell: UICollectionViewCell {
    
    private enum Constants {
        static let insets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: AppConfiguration.font, size: 24)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.addSubview(titleLabel)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.configureFrame { (maker) in
            maker.edges(insets: Constants.insets)
            maker.cornerRadius(5)
        }
        titleLabel.configureFrame { (maker) in
            maker.center(to: imageView)
            maker.sizeToFit()
        }
    }
}
