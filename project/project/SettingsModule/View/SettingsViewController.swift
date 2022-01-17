//
//  SettingsViewController.swift
//  project
//
//  Created by Dzmitry on 4.01.22.
//
import FirebaseAuth
import UIKit

class SettingsViewController: UIViewController {

    
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
        do {
            try Auth.auth().signOut()
            print("Sign Out")
            let vc = SignInViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } catch {
            print(error)
            
            let ac = UIAlertController(title: "Sign Out unavailable", message: "Something wrong. Check your connection and try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            
        }
        
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
