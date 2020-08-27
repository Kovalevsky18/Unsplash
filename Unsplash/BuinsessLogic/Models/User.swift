//
//  User.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/8/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation
struct User: Codable {
    let id: String?
    let username: String?
    let name: String?
    let firstName: String?
  
    enum CodingKeys: String, CodingKey {
        case id, username, name
        case firstName = "first_name"
    }
}

