//
//  LoginViewModel.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/16/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

final class LoginViewModel {
    
    init() {
    }
}

extension LoginViewModel: Equatable {
   
    static func == (lhs: LoginViewModel, rhs: LoginViewModel) -> Bool {
        return false
    }
}
