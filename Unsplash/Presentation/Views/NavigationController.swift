//
//  NavigationController.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/16/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.backgroundColor = .black
        self.navigationBar.tintColor = .white
        self.navigationBar.barStyle = .black
        self.navigationBar.barTintColor = UIColor.black
        let backImage = Asset.backIcon.image.withRenderingMode(.alwaysOriginal)
        self.navigationBar.backIndicatorImage = backImage
        self.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationBar.isTranslucent = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
