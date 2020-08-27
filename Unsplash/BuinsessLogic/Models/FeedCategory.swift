//
//  Collections.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/9/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

struct FeedCategory: Codable {
    let id: Int?
    let title: String?
    let tags: [Tag?]
}
