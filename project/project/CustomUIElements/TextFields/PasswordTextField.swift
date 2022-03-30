//
//  PasswordTextField.swift
//  project
//
//  Created by Dzmitry on 29.12.21.
//

import UIKit

class PasswordTextField: AuthorizationTextField {
    
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
        self.backgroundColor = .secondarySystemBackground
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
