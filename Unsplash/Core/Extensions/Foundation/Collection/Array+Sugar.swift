//
//  Array+Sugar.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/10/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

extension Array {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    subscript (safe range: ClosedRange<Int>) -> [Element] {
        return Array<Int>(range).compactMap { index -> Element? in // swiftlint:disable:this syntactic_sugar
            return indices.contains(index) ? self[index] : nil
        }
    }
}
