//
//  CoinAddViewController.swift
//  project
//
//  Created by Dzmitry on 26.02.22.
//

import UIKit

class CoinAddViewController: UIViewController, CoinAddViewProtocol {
    
    
    var coinAddViewPresenter: CoinAddViewPresenterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        coinAddViewPresenter = CoinAddViewPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Alert elements emplement start
    
    private let alertDescribePriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.text = "Price:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alertMaxPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alertMinimalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alertDescribeQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.text = "Quantity:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alertMaxQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "infinity")?.withTintColor(.white)
        imageAttachment.adjustsImageSizeForAccessibilityContentSizeCategory = true
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        label.attributedText = fullString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alertMinimalQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let alertChosenPriceTextField: UITextField = {
        let textField = CoinAddModuleTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "$"
        textField.textAlignment = .center
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
//        textField.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
//        textField.layer.cornerRadius = 3
        
        textField.keyboardType = .decimalPad
        textField.returnKeyType = UIReturnKeyType.next
        return textField
    }()
    
    private let alertChosenQuantityTextField: UITextField = {
        let textField = CoinAddModuleTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
//        textField.layer.borderWidth = 1
//        textField.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
//        textField.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
//        textField.layer.cornerRadius = 3
        
        textField.keyboardType = .decimalPad
        textField.returnKeyType = UIReturnKeyType.done
        return textField
    }()
    
    private let alertErrorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        //label.text = "Incorrect input."
        return label
    }()
    
    private let addCoinToPortfolioButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5942070484, blue: 0.9925900102, alpha: 1)
        button.layer.cornerRadius = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.addTarget(self, action: #selector(didTapAddCoinToPortfolioButton), for: .touchUpInside)
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0, green: 0.5942070484, blue: 0.9925900102, alpha: 1)
        button.layer.cornerRadius = 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapCancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //Mark: Alert elements emplement end

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        //coinAddViewPresenter = CoinAddViewPresenter(view: self)
        alertChosenPriceTextField.delegate = self
        alertChosenQuantityTextField.delegate = self
        // Do any additional setup after loading the view.
        view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.addSubview(alertDescribePriceLabel)
        view.addSubview(alertMaxPriceLabel)
        view.addSubview(alertChosenPriceTextField)
        view.addSubview(alertMinimalPriceLabel)
        view.addSubview(alertDescribeQuantityLabel)
        view.addSubview(alertMaxQuantityLabel)
        view.addSubview(alertChosenQuantityTextField)
        view.addSubview(alertMinimalQuantityLabel)
        view.addSubview(alertErrorLabel)
        view.addSubview(addCoinToPortfolioButton)
        view.addSubview(cancelButton)
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = 200
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { nc in
            self.view.frame.origin.y = 0
        }
        createAlertDescribePriceLabelConstraint()
        createAlertMaxPriceLabelConstraint()
        createAlertChosenPriceTextFieldConstraint()
        createAlertMinimalPriceLabelConstraint()
        createAlertDescribeQuantityLabelConstraint()
        createAlertMaxQuantityLabelConstraint()
        createAlertChosenQuantityTextFieldConstraint()
        createAlertMinimalQuantityLabelConstraint()
        createAlertErrorLabelConstraint()
        createAddCoinToPortfolioButtonConstraint()
        createCancelButtonConstraint()
    }
    
    @objc func didTapAddCoinToPortfolioButton() {
        alertAction()
    }
    
    func alertAction() {
        coinAddViewPresenter?.alertAction(price: alertChosenPriceTextField.text, quantity: alertChosenQuantityTextField.text)
    }
    
    func configure(data: CoinTableViewCellViewModel) {
        print("1")
        coinAddViewPresenter?.configure(with: data)
        print("2")
    }
    
    func dismissController() {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func transitionToWalletScreen(model: FirebaseModel) {
//        let vc = WalletViewController()
//        
//        //vc.modalPresentationStyle = .fullScreen
//        vc.configureForTransition(model: model)
//        
//        //dismissController()
//        present(vc, animated: true, completion: nil)
//    }
    
    func setupFields(viewData: CoinTableViewCellViewModel) {
        alertMaxPriceLabel.text = "\(viewData.ath)"
        alertMinimalPriceLabel.text = "\(viewData.atl)"
        print(viewData.ath)
        print("asfg")
    }
    
    
    
    
    
    func didActionWithErrorLabel(errorLabelCondition: ErrorLabelCondition, typeOfError: ErrorType?) {
        switch errorLabelCondition {
        case .show:
            guard let typeOfError = typeOfError else {return}
            alertErrorLabel.text = typeOfError.rawValue
            alertErrorLabel.isHidden = false
        case .hide:
            alertErrorLabel.isHidden = true
        }
        
    }

//    func getTextfieldsText() -> (price: String?, quantity: String?) {
//        return (alertChosenPriceTextField.text, alertChosenQuantityTextField.text)
//    }
    
    func createAlertDescribePriceLabelConstraint() {
        NSLayoutConstraint.activate([
            alertDescribePriceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            alertDescribePriceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            alertDescribePriceLabel.widthAnchor.constraint(equalToConstant: 140),
            alertDescribePriceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertMaxPriceLabelConstraint() {
        NSLayoutConstraint.activate([
            alertMaxPriceLabel.topAnchor.constraint(equalTo: alertDescribePriceLabel.bottomAnchor, constant: 10),
            alertMaxPriceLabel.leftAnchor.constraint(equalTo: alertDescribePriceLabel.leftAnchor),
            alertMaxPriceLabel.widthAnchor.constraint(equalToConstant: 140),
            alertMaxPriceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertChosenPriceTextFieldConstraint() {
        NSLayoutConstraint.activate([
            alertChosenPriceTextField.topAnchor.constraint(equalTo: alertMaxPriceLabel.bottomAnchor, constant: 10),
            alertChosenPriceTextField.leftAnchor.constraint(equalTo: alertMaxPriceLabel.leftAnchor),
            alertChosenPriceTextField.widthAnchor.constraint(equalToConstant: 140),
            alertChosenPriceTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func createAlertMinimalPriceLabelConstraint() {
        NSLayoutConstraint.activate([
            alertMinimalPriceLabel.topAnchor.constraint(equalTo: alertChosenPriceTextField.bottomAnchor, constant: 10),
            alertMinimalPriceLabel.leftAnchor.constraint(equalTo: alertChosenPriceTextField.leftAnchor),
            alertMinimalPriceLabel.widthAnchor.constraint(equalToConstant: 140),
            alertMinimalPriceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertDescribeQuantityLabelConstraint() {
        NSLayoutConstraint.activate([
            alertDescribeQuantityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            alertDescribeQuantityLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            alertDescribeQuantityLabel.widthAnchor.constraint(equalToConstant: 140),
            alertDescribeQuantityLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertMaxQuantityLabelConstraint() {
        NSLayoutConstraint.activate([
            alertMaxQuantityLabel.topAnchor.constraint(equalTo: alertDescribeQuantityLabel.bottomAnchor, constant: 10),
            alertMaxQuantityLabel.rightAnchor.constraint(equalTo: alertDescribeQuantityLabel.rightAnchor),
            alertMaxQuantityLabel.widthAnchor.constraint(equalToConstant: 140),
            alertMaxQuantityLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertChosenQuantityTextFieldConstraint() {
        NSLayoutConstraint.activate([
            alertChosenQuantityTextField.topAnchor.constraint(equalTo: alertMaxQuantityLabel.bottomAnchor, constant: 10),
            alertChosenQuantityTextField.rightAnchor.constraint(equalTo: alertMaxQuantityLabel.rightAnchor),
            alertChosenQuantityTextField.widthAnchor.constraint(equalToConstant: 140),
            alertChosenQuantityTextField.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func createAlertMinimalQuantityLabelConstraint() {
        NSLayoutConstraint.activate([
            alertMinimalQuantityLabel.topAnchor.constraint(equalTo: alertChosenQuantityTextField.bottomAnchor, constant: 10),
            alertMinimalQuantityLabel.rightAnchor.constraint(equalTo: alertChosenQuantityTextField.rightAnchor),
            alertMinimalQuantityLabel.widthAnchor.constraint(equalToConstant: 140),
            alertMinimalQuantityLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertErrorLabelConstraint() {
        NSLayoutConstraint.activate([
            alertErrorLabel.topAnchor.constraint(equalTo: alertMinimalPriceLabel.bottomAnchor, constant: 10),
            alertErrorLabel.rightAnchor.constraint(equalTo: alertMinimalQuantityLabel.rightAnchor),
            alertErrorLabel.leftAnchor.constraint(equalTo: alertMinimalPriceLabel.leftAnchor),
            alertErrorLabel.heightAnchor.constraint(equalToConstant: 20),
            //alertErrorLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    func createAddCoinToPortfolioButtonConstraint() {
        NSLayoutConstraint.activate([
            addCoinToPortfolioButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            addCoinToPortfolioButton.widthAnchor.constraint(equalToConstant: 80),
            addCoinToPortfolioButton.heightAnchor.constraint(equalToConstant: 30),
            addCoinToPortfolioButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
    
    func createCancelButtonConstraint() {
        NSLayoutConstraint.activate([
            cancelButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            cancelButton.widthAnchor.constraint(equalToConstant: 80),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }

}


extension CoinAddViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case alertChosenPriceTextField:
            alertChosenQuantityTextField.becomeFirstResponder()
        case alertChosenQuantityTextField:
            alertChosenQuantityTextField.resignFirstResponder()
        default:
            print("some problems in UITextFieldDelegate method(SignInViewController)")
        }
        return true
    }
}
