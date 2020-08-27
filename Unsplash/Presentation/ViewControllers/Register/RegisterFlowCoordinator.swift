//
//  RegisterFlowCoordinator.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/19/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import Foundation

final class RegisterFlowCoordinator {
    
    private weak var view: RegisterViewControllerInput?
    var rootViewController: NavigationController
    var viewModel: RegisterViewModel?
    lazy var user: RegisterUser = .init()
    var errors: [RegistrationFieldType: String] = [:]
    private lazy var authService: AuthServiceProtocol = AuthService()
    
    init(rootViewController: NavigationController ) {
        self.rootViewController = rootViewController
    }
    
    func start(animated: Bool) {
        let viewModel = RegisterViewModel()
        let viewController = RegisterViewController(viewModel: viewModel)
        viewController.output = self
        view = viewController
        rootViewController.pushViewController(viewController, animated: animated)
    }
    
    func registerUser() {
        RegistrationFieldType.allCases.enumerated().forEach { (index, type) in
            do {
                try validateText(fieldType: type)
            } catch {
                if let error = error as? RequiredFieldError {
                    switch type {
                    case .firstName:
                        errors[type] = error.localizedDescription
                    case .lastName:
                        errors[type] = error.localizedDescription
                    case .userName:
                        errors[type] = error.localizedDescription
                    case .email:
                        errors[type] = error.emailDescription
                    case .password:
                        errors[type] = error.passwordDescription
                    }
                }
            }
        }
        guard errors.isEmpty else {
            view?.handleError(errors)
            return
        }
        authService.registerUser(user: user)
    }
    
    func validateText(fieldType: RegistrationFieldType) throws {
        switch fieldType {
        case .firstName:
            try RequiredTextFieldValidator(name: .firstName).validateText(text: user.firstName)
        case .lastName:
            try RequiredTextFieldValidator(name: .lastName).validate(text: user.lastName)
        case .userName:
            try RequiredTextFieldValidator(name: .userName).validate(text: user.username)
        case .email:
            try RequiredTextFieldValidator(name: .email).validate(text: user.email)
        case .password:
            try RequiredTextFieldValidator(name: .password).validate(text: user.password)
        }
    }
}

extension RegisterFlowCoordinator: RegisterViewControllerOutput {
    
    func viewDidLoad() {
        print("RegisterVC")
    }
    
    func viewDidChangeValue(_ index: Int, text: String?) {
        guard let type = RegistrationFieldType.allCases[safe: index] else {
            return
        }
        
        switch type {
        case .firstName:
            user.firstName = text
        case .lastName:
            user.lastName = text
        case .userName:
            user.username = text
        case .email:
            user.email = text
        case .password:
            user.password = text
        }
    }
    
    func registerButtonPressed() {
        errors = [:]
        registerUser()
    }
}


