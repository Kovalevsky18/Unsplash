//
//  NSTextAttachment+ImageSize.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/12/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

extension NSTextAttachment {
    func setImageHeight(height: CGFloat) {
        guard let image = image else { return }
        let ratio = image.size.width / image.size.height
        bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y - 2, width: ratio * height, height: height)
    }
}
