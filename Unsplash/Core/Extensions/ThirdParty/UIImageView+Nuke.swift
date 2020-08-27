//
//  UIImageView+Nuke.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/10/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit.UIImageView
import Nuke

extension UIImageView {
    
    static fileprivate var options: ImageLoadingOptions {
        var options = ImageLoadingOptions()
        options.transition = ImageLoadingOptions.Transition.fadeIn(duration: 0.3)
        return options
    }
    
    func nuke_setImage(with url: URL?) {
        guard let url = url else {
            return
        }
        
        Nuke.loadImage(with: url,options: type(of: self).options, into: self)
    }
}
