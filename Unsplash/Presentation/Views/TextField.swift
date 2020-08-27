//
//  LoginTextFields.swift
//  Unsplash
//
//  Created by Родион Ковалевский on 7/16/20.
//  Copyright © 2020 Родион Ковалевский. All rights reserved.
//

import UIKit

class TextField: UIView {
    
    private enum Constants {
        static let insets: UIEdgeInsets = .init(top: 15, left: 10, bottom: 15, right: 10)
        static let height: CGFloat = 30
        static let verticalSpace: CGFloat = 5
    }
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: AppConfiguration.font, size: 15)
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField =  UITextField()
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.clearButtonMode = .whileEditing
        textField.font = UIFont(name: AppConfiguration.font, size: 15)
        return textField
    }()
    
    private  var errorLabel: UILabel = {
        var errorLabel = UILabel()
        errorLabel.textColor = .red
        errorLabel.font = UIFont(name: AppConfiguration.font, size: 13)
        return errorLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(errorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.configureFrame { (maker) in
            maker.top(inset: 5)
            maker.left(inset: Constants.insets.left)
            maker.sizeToFit()
        }
        textField.configureFrame { (maker) in
            maker.top(to: titleLabel.nui_bottom, inset: Constants.verticalSpace)
            maker.left(inset: Constants.insets.left)
            maker.right(inset: Constants.insets.right)
            maker.height(Constants.height)
        }
        errorLabel.configureFrame { (maker) in
            maker.top(to: textField.nui_bottom, inset: Constants.verticalSpace)
            maker.left(inset: Constants.insets.left)
            maker.width(120)
            maker.sizeToFit()
        }
    }
    
    func set(placeholder: String?) {
        textField.placeholder = placeholder
    }
    
    func set(clearMode: UITextField.ViewMode) {
        textField.clearButtonMode = clearMode
    }
    
    func set(contentType: UITextContentType) {
        textField.textContentType = contentType
    }
    
    func set(keyboardType: UIKeyboardType) {
        textField.keyboardType = keyboardType
    }
    
    func set(titleLabelText: String?) {
        titleLabel.text = titleLabelText
    }
    
    func set(errorLabelText: String?) {
        errorLabel.text = errorLabelText
    }
    
    func set(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        textField.addTarget(target, action: action, for: controlEvents)
    }
    
    func set(tag: Int) {
        textField.tag = tag
    }
    
    func set(errorLabelisHidden: Bool) {
        errorLabel.isHidden = errorLabelisHidden
    }
    
    func set(isSecureTextEntry: Bool) {
        textField.isSecureTextEntry = isSecureTextEntry
    }
    
    func set(borderColor: CGColor) {
        textField.layer.borderColor = borderColor
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var fittingSize: CGSize = .init()
        fittingSize.height += titleLabel.sizeThatFits(size).height
        fittingSize.height += errorLabel.sizeThatFits(size).height
        fittingSize.height += Constants.height
        fittingSize.height += Constants.verticalSpace * 2
        return fittingSize
    }
}
