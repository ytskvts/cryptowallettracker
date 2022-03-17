//
//  SettingsViewPresenter.swift
//  project
//
//  Created by Dmitry on 17.03.22.
//

import Foundation
import FirebaseAuth

class SettingsViewPresenter: SettingsViewPresenterProtocol {
    
    weak var view: SettingsViewProtocol?
    
    init(view: SettingsViewProtocol) {
        self.view = view
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("Sign Out")
            view?.transitionToSignInScreen()
        } catch {
            print(error)
            view?.presentErrorAlert()
        }
    }
}
