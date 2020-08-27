//
//  CoverPhoto.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/9/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

struct CoverPhoto: Codable {
    let width: Int?
    let height: Int?
    let color: String?
    let urls: CollectionsURLs?
    let user: User?
}
