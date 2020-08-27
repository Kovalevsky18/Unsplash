//
//  PostService.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/20/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

final class AuthService: NetworkService, AuthServiceProtocol {
    
    func registerUser(user: RegisterUser) {
        let endpoint:AuthEndpoint = .register(user: user)
        
        request(endpoint: endpoint, success: { (response: Data) in
            do {
                let result = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                print(result)
            } catch {
                print(error)
            }
        }, failure: { (error) in
        })
    }
    
    
}
