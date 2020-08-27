//
//  RegisterViewController.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/19/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

protocol RegisterViewControllerOutput: class {
    func viewDidLoad()
    func viewDidChangeValue(_ index: Int, text: String?)
    func registerButtonPressed()
}

protocol RegisterViewControllerInput: class {
    func handleError(_ errors: [RegistrationFieldType: String])
}

final class RegisterViewController: UIViewController {
    
    private var viewModel: RegisterViewModel
    weak var output: RegisterViewControllerOutput?
    
    private lazy var registerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        var registerLabel = UILabel()
        registerLabel.textColor = .white
        registerLabel.textAlignment = .center
        registerLabel.text = "Join Unsplash"
        registerLabel.font = UIFont(name: AppConfiguration.font, size: 25)
        return registerLabel
    }()
    
    private(set) lazy var spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(backButtonPressed),
                         for: .touchUpInside)
        let titleValue = "Login"
        let font = UIFont(name: AppConfiguration.font, size: 18)!
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white ]
        let title = NSAttributedString(string: titleValue, attributes: attributes)
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private(set) lazy var firstNameView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private(set) lazy var lastNameView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private(set) lazy var usernameView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private(set) lazy var emailView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private(set) lazy var passwordView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private(set) lazy var registerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(registerButtonPressed),
                         for: .touchUpInside)
        let titleValue = "Sign UP"
        let font = UIFont(name: AppConfiguration.font, size: 18)!
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.white ]
        let title = NSAttributedString(string: titleValue, attributes: attributes)
        button.setAttributedTitle(title, for: .normal)
        return button
    }()
    
    private(set) lazy var firstNameTextField: TextField = {
        let textfield = TextField()
        textfield.set(errorLabelisHidden: true)
        textfield.set(titleLabelText: "FirstName")
        textfield.set(errorLabelText: " mnn")
        textfield.set(placeholder: "firstName")
        textfield.set(contentType: .name)
        textfield.set(tag: 0)
        textfield.set(self,
                      action: #selector(textFieldDidChanged(_:)),
                      for: .allEditingEvents)
        return textfield
    }()
    
    private var lastNameTextField: TextField = {
        let textfield = TextField()
        textfield.set(titleLabelText: "Last Name")
        textfield.set(errorLabelText: " ")
        textfield.set(placeholder: "lastName")
        textfield.set(contentType: .name)
        textfield.set(tag: 1)
        textfield.set(self,
                      action: #selector(textFieldDidChanged(_:)),
                      for: .allEditingEvents)
        return textfield
    }()
    
    private var usernameTextField: TextField = {
        let textfield = TextField()
        textfield.set(errorLabelText: " ")
        textfield.set(titleLabelText: "Username")
        textfield.set(placeholder: "username")
        textfield.set(contentType: .name)
        textfield.set(tag: 2)
        textfield.set(self,
                      action: #selector(textFieldDidChanged(_:)),
                      for: .allEditingEvents)
        return textfield
    }()
    
    private var emailTextField: TextField = {
        let textfield = TextField()
        textfield.set(errorLabelText: " ")
        textfield.set(titleLabelText: "Email")
        textfield.set(placeholder: "email")
        textfield.set(contentType: .emailAddress)
        textfield.set(tag: 3)
        textfield.set(self,
                      action: #selector(textFieldDidChanged(_:)),
                      for: .allEditingEvents)
        return textfield
    }()
    
    private var passwordTextField: TextField = {
        let textfield = TextField()
        textfield.set(errorLabelText: " ")
        textfield.set(titleLabelText: "Password")
        textfield.set(placeholder: "password")
        textfield.set(tag: 4)
        textfield.set(isSecureTextEntry: true)
        textfield.set(self,
                      action: #selector(textFieldDidChanged(_:)),
                      for: .allEditingEvents)
        return textfield
    }()
    
    init(viewModel: RegisterViewModel) {
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
                                               object: nil) // did appear
        
        view.backgroundColor = .clear
        registerView.addSubview(backButton)
        registerView.addSubview(titleLabel)
        registerView.addSubview(spaceView)
        registerView.addSubview(lastNameView)
        registerView.addSubview(firstNameView)
        registerView.addSubview(usernameView)
        registerView.addSubview(emailView)
        registerView.addSubview(passwordView)
        registerView.addSubview(registerButton)
        firstNameView.addSubview(firstNameTextField)
        lastNameView.addSubview(lastNameTextField)
        usernameView.addSubview(usernameTextField)
        emailView.addSubview(emailTextField)
        passwordView.addSubview(passwordTextField)
        registerView.nx_state = 0
        view.addSubview(registerView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        registerView.configureFrame(state: 0) { (maker) in
            maker.center()
            maker.width(to: view.nui_width, multiplier: 0.9)
            maker.height(to: view.nui_height, multiplier: 0.8)
            maker.cornerRadius(20)
        }
        registerView.configureFrame(state: 1) { (maker) in
            maker.top(to: view.nui_top)
        }
        backButton.configureFrame { (maker) in
            maker.left(inset: 10)
            maker.top()
            maker.height(45)
            maker.width(60)
            maker.sizeToFit()
        }
        titleLabel.configureFrame { (maker) in
            maker.top(inset: 10)
            maker.left(to: backButton.nui_left)
            maker.right()
            maker.sizeToFit()
            maker.height(60)
        }
        spaceView.configureFrame { (maker) in
            maker.top(to: titleLabel.nui_bottom, inset: 3)
            maker.left()
            maker.right()
            maker.height(1)
        }
        firstNameView.configureFrame { (maker) in
            maker.top(to: titleLabel.nui_bottom, inset: 5)
            maker.left()
            maker.right()
            maker.height(registerView.bounds.height/8)
        }
        firstNameTextField.configureFrame { (maker) in
            maker.top(to: firstNameView.nui_top)
            maker.left()
            maker.right()
            maker.bottom(to: firstNameView.nui_bottom)
        }
        lastNameView.configureFrame { (maker) in
            maker.top(to: firstNameView.nui_bottom, inset: 10)
            maker.left()
            maker.right()
            maker.height(registerView.bounds.height/8)
        }
        lastNameTextField.configureFrame { (maker) in
            maker.top(to: lastNameView.nui_top)
            maker.left()
            maker.right()
            maker.bottom(to: lastNameView.nui_bottom)
        }
        usernameView.configureFrame { (maker) in
            maker.top(to: lastNameView.nui_bottom, inset: 13)
            maker.left()
            maker.right()
            maker.height(registerView.bounds.height/8)
        }
        usernameTextField.configureFrame { (maker) in
            maker.top(to: usernameView.nui_top)
            maker.left()
            maker.right()
            maker.bottom(to: usernameView.nui_bottom)
        }
        emailView.configureFrame { (maker) in
            maker.top(to:usernameView.nui_bottom, inset: 13)
            maker.left()
            maker.right()
            maker.height(registerView.bounds.height/8)
        }
        emailTextField.configureFrame { (maker) in
            maker.top(to: emailView.nui_top)
            maker.left()
            maker.right()
            maker.bottom(to: emailView.nui_bottom)
        }
        passwordView.configureFrame { (maker) in
            maker.top(to:emailView.nui_bottom, inset: 13)
            maker.left()
            maker.right()
            maker.height(registerView.bounds.height/8)
        }
        passwordTextField.configureFrame { (maker) in
            maker.top(to: passwordView.nui_top)
            maker.left()
            maker.right()
            maker.bottom(to: passwordView.nui_bottom)
        }
        registerButton.configureFrame { (maker) in
            maker.top(to: passwordView.nui_bottom, inset: 10)
            maker.right(inset: 40)
            maker.left(inset: 40)
            maker.height(35)
            maker.cornerRadius(10)
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
    
    func resetFieldsErrors() {
        firstNameTextField.set(errorLabelisHidden: true)
        firstNameTextField.set(borderColor: UIColor.black.cgColor)
        lastNameTextField.set(errorLabelisHidden: true)
        lastNameTextField.set(borderColor: UIColor.black.cgColor)
        usernameTextField.set(errorLabelisHidden: true)
        usernameTextField.set(borderColor: UIColor.black.cgColor)
        emailTextField.set(errorLabelisHidden: true)
        emailTextField.set(borderColor: UIColor.black.cgColor)
        passwordTextField.set(errorLabelisHidden: true)
        passwordTextField.set(borderColor: UIColor.red.cgColor)
    }
    
    @objc func registerButtonPressed(textField:TextField) {
        resetFieldsErrors()
        output?.registerButtonPressed()
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func textFieldDidChanged(_ textField: UITextField ) {
        output?.viewDidChangeValue(textField.tag, text: textField.text)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification){
        view.setNeedsLayout()
        self.registerView.nx_state = 1
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        view.setNeedsLayout()
        self.registerView.nx_state = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension RegisterViewController: RegisterViewControllerInput {
    
    func handleError(_ errors: [RegistrationFieldType : String]) {
        errors.forEach { (key, value) in
            switch key {
            case .firstName:
                firstNameTextField.set(errorLabelText: value)
                firstNameTextField.set(errorLabelisHidden: false)
            case .lastName:
                lastNameTextField.set(errorLabelText: value)
                lastNameTextField.set(errorLabelisHidden: false)
            case .userName:
                usernameTextField.set(errorLabelText: value)
                usernameTextField.set(errorLabelisHidden: false)
            case .email:
                emailTextField.set(errorLabelText: value)
                emailTextField.set(errorLabelisHidden: false)
            case .password:
                passwordTextField.set(errorLabelText: value)
                passwordTextField.set(errorLabelisHidden: false)
            }
        }
    }
}

