//
//  RequiredFieldError.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/21/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

struct RequiredFieldError: LocalizedError {
    
    let errorDescription: String? = "This field is required"
    let emailDescription: String? = "Invalid Email"
    let passwordDescription: String? = "Invalid Password"
    let name: RegistrationFieldType
    
    init(name: RegistrationFieldType) {
        self.name = name
    }
}
