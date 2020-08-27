//
//  Welcome element.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/8/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

struct Image: Codable {
    let id: String?
    let createdAt: String?
    let height: Int?
    let width: Int?
    let urls: PhotoURLs?
    let likes: Int?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case width, height
        case urls,likes
        case user
    }
}
