//
//  ViewController.swift
//  project
//
//  Created by Dzmitry on 17.11.21.
//

import LocalAuthentication
import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    var signInPresenter: SignInPresenterProtocol!
    
    
    
    // MARK: Bad setup, in future do stackview
    private let emailTextField: UITextField = {
        let textField = AuthorizationTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = UIReturnKeyType.next
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = PasswordTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.returnKeyType = UIReturnKeyType.go
        return textField
    }()
    
    private let errorLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.isHidden = true
        label.textColor = .red
        return label
    }()
    
    private let logInButton : AuthorizationButton = {
        let button = AuthorizationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log In", for: .normal)
        button.addTarget(self, action: #selector(didTaplogInButton), for: .touchUpInside)
        button.disableButton()
        return button
    }()
    
    private let transitionToSignUpScreenButton : AuthorizationButton = {
        let button = AuthorizationButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(didTapTransitionToSignUpScreenButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(errorLabel)
        view.addSubview(logInButton)
        view.addSubview(transitionToSignUpScreenButton)
        
        configureTapGesture()
        
    
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: nil) { nc in
            self.checkForEnableLogInButton()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        createEmailTextFieldConstraint()
        createPasswordTextFieldConstraint()
        createErrorLabelConstraint()
        createLogInButtonConstraint()
        createTransitionToSignUpScreenButtonConstraint()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        biometric()
    }
    
    func createEmailTextFieldConstraint() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func createPasswordTextFieldConstraint() {
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.topAnchor, constant: 40),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func createErrorLabelConstraint() {
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 40),
            errorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            errorLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            errorLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createLogInButtonConstraint() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: errorLabel.topAnchor, constant: 30),
            logInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            logInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            logInButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func createTransitionToSignUpScreenButtonConstraint() {
        NSLayoutConstraint.activate([
            transitionToSignUpScreenButton.topAnchor.constraint(equalTo: logInButton.topAnchor, constant: 40),
            transitionToSignUpScreenButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            transitionToSignUpScreenButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            transitionToSignUpScreenButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func didTaplogInButton() {
        
        print("logbtn")
        errorLabel.text = ""
        errorLabel.isHidden = true
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {return}
        
        let isValid = Validation(email: email, password: password, confirmPassword: nil)

        if isValid.isValidMail() {
            FirebaseAuth.Auth.auth().signIn(withEmail: isValid.email, password: isValid.password, completion: { [weak self] result, error in
                guard let strongSelf = self else {
                    return
                }
                guard error == nil else {
                    strongSelf.showAlert()
                    return
                }
                print("You have signed in")
                //MARK: rewrite this as man
                strongSelf.saveDataToKeychain(email: email, password: password)
                strongSelf.navigateToMainScreen()
            })
        } else {
            errorLabel.text = "Incorrect email."
            errorLabel.isHidden = false
            emailTextField.text =  ""
            passwordTextField.text = ""
            checkForEnableLogInButton()
            emailTextField.becomeFirstResponder()
        }
    }
    
    @objc private func didTapTransitionToSignUpScreenButton() {
        
        print("didTapTransitionToSignUpScreenButton")
        cleanInputSignInFields()
        checkForEnableLogInButton()
        view.endEditing(true)
        present(SignUpViewController(), animated: true, completion: nil)
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    func cleanInputSignInFields() {
        emailTextField.text =  ""
        passwordTextField.text = ""
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
    
    func checkForEnableLogInButton() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {return}
        if  !email.isEmpty && !password.isEmpty {
            logInButton.enableButton()
        } else {
            logInButton.disableButton()
        }
    }
    
    func setDataFromKeychain() {
        emailTextField.text = KeychainWrapper.standard.string(forKey: "email") ?? ""
        passwordTextField.text = KeychainWrapper.standard.string(forKey: "password") ?? ""
    }
    
    func saveDataToKeychain(email: String, password: String) {
        KeychainWrapper.standard.set(emailTextField.text ?? "", forKey: "email")
        KeychainWrapper.standard.set(passwordTextField.text ?? "", forKey: "password")
    }
    
    func biometric() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        if Auth.auth().currentUser != nil {
                            print("User is signed in.")
                            guard let self = self else {return}
                            self.navigateToMainScreen()
                        }
                        else {
                            self?.setDataFromKeychain()
                            self?.checkForEnableLogInButton()
                        }
                        
                    }
//                    else {
//                        // error
//                        let ac = UIAlertController(title: "Authentication failed", message: "You couldn't be verified. Please try again.", preferredStyle: .alert)
//                        ac.addAction(UIAlertAction(title: "OK", style: .default))
//                        self?.present(ac, animated: true)
//                    }
                }
            }
        } else {
            // no biometry
            let ac = UIAlertController(title: "Biometry unavailable", message: "Your device isn't configured for biometric authentication.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
}

extension SignInViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            if logInButton.isUserInteractionEnabled == true {
                didTaplogInButton()
            }
        default:
            print("some problems in UITextFieldDelegate method(SignInViewController)")
        }
        return true
    }
}

extension SignInViewController: SignInViewProtocol {
    
    func navigateToMainScreen() {
        let vc = TabBarController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: "Unable to login", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.cleanInputSignInFields()
            self.emailTextField.becomeFirstResponder()
        } ))
        self.present(alert, animated: true)
    }
    
    
}
