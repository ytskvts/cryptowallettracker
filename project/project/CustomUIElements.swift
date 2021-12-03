//
//  CustomTextField.swift
//  project
//
//  Created by Dzmitry on 3.12.21.
//

import UIKit

class CustomTextField: UITextField {
    var textPadding = UIEdgeInsets(
            top: 5,
            left: 10,
            bottom: 5,
            right: 10
    )
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super .init(coder: coder)
        setupStyle()
    }
    
    
    func setupStyle() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        self.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        self.layer.cornerRadius = 3
    }
    
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - 35, y: 0, width: 30 , height: bounds.height)
    }
    
    
}

class PasswordTextField: CustomTextField {
    
    override var isSecureTextEntry: Bool {
            didSet {
                if isFirstResponder {
                    _ = becomeFirstResponder()
                }
            }
        }

    override func becomeFirstResponder() -> Bool {

        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        return success
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.isSecureTextEntry = true
        
        //show/hide button
        let button = UIButton(frame: CGRect(x: self.frame.size.width - 25, y: 5, width: 30, height: 30))
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.imageView?.tintColor = #colorLiteral(red: 0.3204267323, green: 0.3202443123, blue: 0.3293273449, alpha: 1)
        rightView = button
        rightViewMode = .always
        
        
        button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
    }
    
    @objc private func showHidePassword(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.isSecureTextEntry = !sender.isSelected
    }
    
}

class AuthorizationButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    func setup() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0.5942070484, blue: 0.9925900102, alpha: 1)
        self.layer.cornerRadius = 3
    }
}
