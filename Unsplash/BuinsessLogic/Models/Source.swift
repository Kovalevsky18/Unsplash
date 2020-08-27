//
//  Source.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/9/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

struct Source: Codable {
    let coverPhoto: CoverPhoto?
    
    enum CodingKeys: String, CodingKey {
        case coverPhoto = "cover_photo"
    }
}
