//
//  NewCell.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/8/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

final class NewCell: UICollectionViewCell {
    
    private enum Constants {
        static let insets:UIEdgeInsets = .init(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var gradientView: UIView = {
        let gradientView = UIView()
        gradientView.backgroundColor = UIColor(white: 0.1, alpha: 0.3)
        return gradientView
    }()
    
    private(set) lazy var likeLabel: UILabel = {
        let likeLabel = UILabel()
        likeLabel.textColor = .white
        likeLabel.font = UIFont(name: AppConfiguration.font, size: 16)
        return likeLabel
    }()
    
    private(set) lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: AppConfiguration.font, size: 16)
        return label
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: AppConfiguration.font, size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.addSubview(gradientView)
        gradientView.addSubview(usernameLabel)
        gradientView.addSubview(dateLabel)
        gradientView.addSubview(likeLabel)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.configureFrame { (maker) in
            maker.edges(insets: .zero)
        }
        gradientView.configureFrame { (maker) in
            maker.edges(insets: .zero)
        }
        usernameLabel.configureFrame { (maker) in
            maker.sizeToFit()
            maker.left(inset: Constants.insets.left)
            maker.bottom(inset: Constants.insets.bottom)
        }
        dateLabel.configureFrame { (maker) in
            maker.sizeToFit()
            maker.right(inset: Constants.insets.right)
            maker.bottom(inset: Constants.insets.bottom)
        }
        likeLabel.configureFrame { (maker) in
            maker.sizeToFit()
            maker.left(inset: Constants.insets.left)
            maker.top(inset: Constants.insets.top)
        }
    }
}
