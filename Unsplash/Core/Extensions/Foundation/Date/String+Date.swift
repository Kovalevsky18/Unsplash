//
//  String+Date.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/12/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

extension String {
    
    fileprivate static var defaultDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    func stringToDate()-> Date? {
        let formatter = type(of: self).defaultDateFormatter
        let datetime = formatter.date(from: self)
        return datetime
    }
}

