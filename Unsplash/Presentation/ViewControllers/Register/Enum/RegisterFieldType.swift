//
//  RegisterFieldType.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/21/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

enum RegistrationFieldType: String, CaseIterable {
   
    case firstName, lastName, userName, email, password
    
    var title: String {
        switch self {
        case .firstName:
            return "First name"
        case .lastName:
            return "Last name"
        case .userName:
            return "User name"
        case .email:
            return "Email"
        case .password:
            return "Password"
        }
    }
}
