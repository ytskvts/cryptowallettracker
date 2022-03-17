//
//  SettingsViewProtocol.swift
//  project
//
//  Created by Dmitry on 17.03.22.
//

import Foundation

protocol SettingsViewProtocol: AnyObject {
    
    func transitionToSignInScreen()
    
    func presentErrorAlert()
}
