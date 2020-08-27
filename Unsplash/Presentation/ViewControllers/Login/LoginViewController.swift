//
//  LoginViewController.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/16/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

protocol LoginViewControllerOutput: class {
    func viewDidLoad()
    func registerButtonDidSelect()
}

protocol LoginViewControllerInput: class {
    func update(viewModel: LoginViewModel, animated: Bool)
}

final class LoginViewController: UIViewController {
    
    private enum Constants {
        static let insets: UIEdgeInsets = .init(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private var viewModel: LoginViewModel
    weak var output: LoginViewControllerOutput?
    var registerVM = RegisterViewModel()
    
    lazy var loginTextField: TextField = {
        var logintTextField = TextField()
        logintTextField.set(titleLabelText: "Email")
        logintTextField.set(errorLabelText: "invalid login")
        logintTextField.set(placeholder: "Ivanov@mail.ru")
        logintTextField.set(clearMode: .whileEditing)
        logintTextField.set(contentType: .emailAddress)
        logintTextField.set(keyboardType: .emailAddress)
        return logintTextField
    }()
    
    lazy var passwordTextField: TextField = {
        let passwordTextField = TextField()
        passwordTextField.set(titleLabelText: "Password")
        passwordTextField.set(errorLabelText: "invalid Password")
        passwordTextField.set(clearMode: .whileEditing)
        passwordTextField.set(contentType: .password)
        passwordTextField.set(keyboardType: .default)
        return passwordTextField
    }()
    
    
    private(set) lazy var loginLabel: UILabel = {
        var loginLabel = UILabel()
        loginLabel.textColor = .white
        loginLabel.textAlignment = .center
        loginLabel.text = "Login"
        loginLabel.font = UIFont(name: AppConfiguration.font, size: 25)
        return loginLabel
    }()
    
    private(set) lazy var registerButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .black
        let titleValue = "Don't have an account? Join"
        let font = UIFont(name: AppConfiguration.font, size: 20)!
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        button.addTarget(self,
                         action: #selector(registerButtonAction),
                         for: .touchUpInside)
        let title = NSAttributedString(string: titleValue,
                                       attributes: attributes)
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private lazy var loginView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var passwordView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var mailView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        let titleValue = "Login"
        let font = UIFont(name: AppConfiguration.font, size: 20)!
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black
        ]
        let title = NSAttributedString(string: titleValue,
                                       attributes: attributes)
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private lazy var spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self,
                         action: #selector(cancelButtonAction),
                         for: .touchUpInside)
        let titleValue = "Cancel"
        let font = UIFont(name: AppConfiguration.font, size: 18)!
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white
        ]
        let title = NSAttributedString(string: titleValue,
                                       attributes: attributes)
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.backgroundColor = .clear
        mailView.addSubview(loginTextField)
        passwordView.addSubview(passwordTextField)
        loginView.addSubview(closeButton)
        loginView.addSubview(loginLabel)
        loginView.addSubview(mailView)
        loginView.addSubview(passwordView)
        loginView.addSubview(registerButton)
        loginView.addSubview(loginButton)
        loginView.addSubview(spaceView)
        loginView.nx_state = 0
        view.addSubview(loginView)
    }
        
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        loginView.configureFrame(state: 0) { (maker) in
            maker.center()
            maker.width(to: view.nui_width, multiplier: 0.9)
            maker.height(to: view.nui_height, multiplier: 0.6)
            maker.cornerRadius(20)
        }
        loginView.configureFrame(state: 1) { (maker) in
            maker.top(inset: 10)
            maker.width(to: self.view.nui_width, multiplier: 0.9)
        }
        spaceView.configureFrame { (maker) in
            maker.top(to: loginLabel.nui_bottom,inset: 5)
            maker.left()
            maker.right()
            maker.height(1)
        }
        closeButton.configureFrame { (maker) in
            maker.left(inset: 10)
            maker.top(inset: 0)
            maker.height(45)
            maker.width(60)
            maker.sizeToFit()
        }
        loginLabel.configureFrame { (maker) in
            maker.top(inset: 10)
            maker.left(to: closeButton.nui_left)
            maker.right()
            maker.sizeToFit()
            maker.height(60)
        }
        mailView.configureFrame { (maker) in
            maker.top(to: loginLabel.nui_bottom,inset: 15)
            maker.left()
            maker.right()
            maker.height(80)
        }
        passwordView.configureFrame { (maker) in
            maker.top(to: mailView.nui_bottom)
            maker.left()
            maker.right()
            maker.height(80)
        }
        loginTextField.configureFrame { (maker) in
            maker.top(to: mailView.nui_top)
            maker.left()
            maker.right()
            maker.bottom(to: mailView.nui_bottom)
        }
        passwordTextField.configureFrame { (maker) in
            maker.top(to: passwordView.nui_top)
            maker.left()
            maker.right()
            maker.bottom(to: passwordView.nui_bottom)
        }
        loginButton.configureFrame { (maker) in
            maker.top(to: passwordView.nui_bottom, inset: 35)
            maker.height(45)
            maker.left(inset: Constants.insets.left)
            maker.right(inset: Constants.insets.right)
            maker.cornerRadius(5)
        }
        registerButton.configureFrame { (maker) in
            maker.top(to: loginButton.nui_bottom, inset: 10)
            maker.left(inset: Constants.insets.left)
            maker.right(inset: Constants.insets.right)
            maker.height(35)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
    }
    
    @objc private func registerButtonAction() {
        output?.registerButtonDidSelect()
    }
    
    @objc func cancelButtonAction() {
        self.dismiss(animated: true, completion: nil) //через coordinator navigatio controller.self
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        view.setNeedsLayout()
        self.loginView.nx_state = 1
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        view.setNeedsLayout()
        self.loginView.nx_state = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension LoginViewController: LoginViewControllerInput {
    
    func update(viewModel: LoginViewModel, animated: Bool) {
    }
}
