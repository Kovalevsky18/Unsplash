//
//  Validation.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/21/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

final class RequiredTextFieldValidator {
    
    let name: RegistrationFieldType
    
    init(name: RegistrationFieldType) {
        self.name = name
    }
    
    func validate(text: String?) throws {
        switch name {
        case .firstName:
            try validateText(text: text)
        case .lastName:
            try validateText(text: text)
        case .userName:
            try validateText(text: text)
        case .email:
            try validate(email: text)
        case .password:
            try validate(password: text)
        }
    }
    
    func validateText(text: String?) throws {
        if text?.isEmpty ?? false || text == nil {
            throw RequiredFieldError(name: name)
        }
    }
    
    private func validate(email: String?) throws {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        
        if !emailPredicate.evaluate(with: email) {
            throw RequiredFieldError(name: name)
        }
    }
    
    private func validate(password: String?) throws {
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        
        if !passwordCheck.evaluate(with: password) {
            throw RequiredFieldError(name: name)
        }
    }
}

