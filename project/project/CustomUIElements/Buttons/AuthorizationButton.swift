//
//  AuthorizationButton.swift
//  project
//
//  Created by Dzmitry on 29.12.21.
//

import UIKit

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
    
    func disableButton() {
        self.isUserInteractionEnabled = false
        self.alpha = 0.5

    }
    
    func enableButton() {
        self.isUserInteractionEnabled = true
        self.alpha = 1
    }
}
