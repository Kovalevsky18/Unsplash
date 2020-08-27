//
//  LoginCoordinator.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/16/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

final class LoginFlowCoordinator {
    
    private weak var view: LoginViewControllerInput?
    var rootViewController: NavigationController
    var viewModel:LoginViewModel?
    let navigationController = NavigationController()
    var registerCoordinator: RegisterFlowCoordinator?
    
    init(rootViewController: NavigationController ) {
        self.rootViewController = rootViewController
    }
    
    func start(animated: Bool) {
        let viewModel = LoginViewModel()
        let viewController = LoginViewController(viewModel: viewModel)
        viewController.output = self
        view = viewController
        navigationController.setViewControllers([viewController], animated: animated)
        rootViewController.present(navigationController, animated: animated, completion: nil)
    }
}

extension LoginFlowCoordinator: LoginViewControllerOutput {
    
    func registerButtonDidSelect() {
        registerCoordinator = RegisterFlowCoordinator(rootViewController: navigationController)
        registerCoordinator?.start(animated: true)
    }
    
    func viewDidLoad() {
        print("LoginVC")
    }
}
