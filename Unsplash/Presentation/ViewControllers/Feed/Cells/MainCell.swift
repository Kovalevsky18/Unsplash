//
//  MainViewCell.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/8/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit
import Framezilla

final class MainCell: UICollectionViewCell {
    
    let reuseId = "MainCell"
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos for everyone"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel.configureFrame { (maker) in
            maker.sizeToFit()
            maker.centerX().and.centerY()
        }
    }
}
