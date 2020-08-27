//
//  Result.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/13/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

struct Result: Codable {
    let updatedAt: String
    let width, height: Int
    let color: String
    let urls: PhotoURLs
    let user: CategoryUser
    let likes: Int
    
    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated_at"
        case width, height, color, urls, user,likes
    }
}
