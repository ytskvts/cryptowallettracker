//
//  AuthorizationTextField.swift
//  project
//
//  Created by Dzmitry on 29.12.21.
//

import UIKit

class AuthorizationTextField: UITextField {
    
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
//        self.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0, green: 0.5942070484, blue: 0.9925900102, alpha: 1)
        //self.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        self.backgroundColor = .secondarySystemBackground
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
