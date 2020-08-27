//
//  PostServiceProtocol.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/20/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

protocol AuthServiceProtocol: class {
    func registerUser(user: RegisterUser)
}
