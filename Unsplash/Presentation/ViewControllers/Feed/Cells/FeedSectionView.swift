//
//  SectionView.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/10/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit
import Framezilla

final class FeedSectionView: UICollectionReusableView {
    
    private enum Constants {
        static let insets:UIEdgeInsets = .init(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: AppConfiguration.font, size: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.configureFrame { (maker) in
            maker.left(inset: Constants.insets.left)
            maker.centerY()
            maker.sizeToFit()
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var fittingSize: CGSize = .zero
        fittingSize.height += Constants.insets.top + Constants.insets.bottom
        fittingSize.height += titleLabel.sizeThatFits(size).height
        return fittingSize
    }
}

