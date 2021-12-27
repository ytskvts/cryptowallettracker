//
//  ValidationProviderProtocol.swift
//  project
//
//  Created by Dzmitry on 27.12.21.
//

import Foundation

protocol ValidationProtocol {
    var email: String {get set}
    var password: String {get set}
    var confirmPassword: String? {get set}
   
    
    init(email: String, password: String, confirmPassword: String?)
    
    func isValidMail() -> Bool
    func isValidPassword() -> Bool
}
