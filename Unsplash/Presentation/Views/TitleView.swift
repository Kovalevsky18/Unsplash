//
//  TitleView.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/14/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

final class TitleView: UIView {
    
    private(set) lazy var primaryLabel: UILabel = {
        var primaryLabel = UILabel()
        primaryLabel.textColor = .white
        primaryLabel.textAlignment = .center
        primaryLabel.font = UIFont(name: AppConfiguration.font, size: 20)
        return primaryLabel
    }()
    
    private(set) lazy var secondaryLabel: UILabel = {
        var secondaryLabel = UILabel()
        secondaryLabel.textColor = .white
        secondaryLabel.textAlignment = .center
        secondaryLabel.font = UIFont(name: AppConfiguration.font, size: 15)
        return secondaryLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureFrame { (maker) in
            maker.width(bounds.width)
            maker.height(44) // поискать решение
        }
        primaryLabel.configureFrame { (maker) in
            maker.top(inset: 5)
            maker.centerX()
            maker.sizeToFit()
        }   
        secondaryLabel.configureFrame { (maker) in
            maker.top(to: primaryLabel.nui_bottom)
            maker.centerX()
            maker.sizeToFit()
        }
    }
    
    func setTitles(primaryTitle:String, secondaryTitle: String) {
        primaryLabel.text = primaryTitle
        secondaryLabel.text = secondaryTitle
    }
}
