//
//  SettingsViewController.swift
//  project
//
//  Created by Dzmitry on 4.01.22.
//

import UIKit

class SettingsViewController: UIViewController, SettingsViewProtocol {

    var settingsViewPresenter: SettingsViewPresenterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        settingsViewPresenter = SettingsViewPresenter(view: self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let SignOutButton : AuthorizationButton = {
        let button = AuthorizationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Out", for: .normal)
        button.addTarget(self, action: #selector(didTapSignOutButton), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .black
        view.addSubview(SignOutButton)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createSignOutButtonConstraint()
    }

    
    @objc private func didTapSignOutButton() {
        settingsViewPresenter?.signOut()
    }
    
    func transitionToSignInScreen() {
        let vc = SignInViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func presentErrorAlert() {
        let ac = UIAlertController(title: "Sign Out unavailable", message: "Something wrong. Check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func createSignOutButtonConstraint() {
        NSLayoutConstraint.activate([
            SignOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120),
            SignOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            SignOutButton.widthAnchor.constraint(equalToConstant: 100),
            SignOutButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
