//
//  CategoryImages.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/13/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

struct CategoryImages: Codable {
    let total, totalPages: Int
    let results: [Image]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}
