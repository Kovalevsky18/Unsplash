//
//  RegisterUser.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/20/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

struct RegisterUser: Codable {
    var firstName: String?
    var lastName: String?
    var username: String?
    var email: String?
    var password: String?
    
    enum CodingKeys: String, CodingKey {
        case username, email, password
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
