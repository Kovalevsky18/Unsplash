//
//  UILabel+Image.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/12/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

extension UILabel {
    
    func imageInString(string: String , image : UIImage , imageHeight:CGFloat) {
        let textAttachment = NSTextAttachment()
        textAttachment.image = image
        textAttachment.setImageHeight(height:imageHeight)
        let firstString = NSMutableAttributedString(string: string)
        let imageString = NSAttributedString(attachment: textAttachment)
        firstString.append(imageString)
        self.attributedText = firstString
    }
}
