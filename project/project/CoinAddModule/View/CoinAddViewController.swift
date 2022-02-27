//
//  CoinAddViewController.swift
//  project
//
//  Created by Dzmitry on 26.02.22.
//

import UIKit

class CoinAddViewController: UIViewController, CoinAddViewProtocol {
    
    
    var coinAddViewPresenter: CoinAddViewPresenterProtocol?
    
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
        textField.keyboardType = .decimalPad
        textField.returnKeyType = UIReturnKeyType.next
        return textField
    }()
    
    private let alertChosenQuantityTextField: UITextField = {
        let textField = CoinAddModuleTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    //Mark: Alert elements emplement end

    override func viewDidLoad() {
        super.viewDidLoad()
        coinAddViewPresenter = CoinAddViewPresenter(view: self)
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
        createAlertDescribePriceLabelConstraint()
        createAlertMaxPriceLabelConstraint()
        createAlertChosenPriceTextFieldConstraint()
        createAlertMinimalPriceLabelConstraint()
        createAlertDescribeQuantityLabelConstraint()
        createAlertMaxQuantityLabelConstraint()
        createAlertChosenQuantityTextFieldConstraint()
        createAlertMinimalQuantityLabelConstraint()
        createAlertErrorLabelConstraint()
    }
    
    func configure(data: CoinTableViewCellViewModel) {
        coinAddViewPresenter?.configure(with: data)
    }
    
    func setupFields(viewData: CoinTableViewCellViewModel) {
        alertMaxPriceLabel.text = "\(viewData.ath)"
        alertMinimalPriceLabel.text = "\(viewData.atl)"
    }
    
    func alertAction() {
        coinAddViewPresenter?.alertAction(price: alertChosenPriceTextField.text, quantity: alertChosenQuantityTextField.text)
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
            alertDescribePriceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            alertDescribePriceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            alertDescribePriceLabel.widthAnchor.constraint(equalToConstant: 70),
            alertDescribePriceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertMaxPriceLabelConstraint() {
        NSLayoutConstraint.activate([
            alertMaxPriceLabel.topAnchor.constraint(equalTo: alertDescribePriceLabel.bottomAnchor, constant: 10),
            alertMaxPriceLabel.leftAnchor.constraint(equalTo: alertDescribePriceLabel.leftAnchor),
            alertMaxPriceLabel.widthAnchor.constraint(equalToConstant: 70),
            alertMaxPriceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertChosenPriceTextFieldConstraint() {
        NSLayoutConstraint.activate([
            alertChosenPriceTextField.topAnchor.constraint(equalTo: alertMaxPriceLabel.bottomAnchor, constant: 10),
            alertChosenPriceTextField.leftAnchor.constraint(equalTo: alertMaxPriceLabel.leftAnchor),
            alertChosenPriceTextField.widthAnchor.constraint(equalToConstant: 70),
            alertChosenPriceTextField.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertMinimalPriceLabelConstraint() {
        NSLayoutConstraint.activate([
            alertMinimalPriceLabel.topAnchor.constraint(equalTo: alertChosenPriceTextField.bottomAnchor, constant: 10),
            alertMinimalPriceLabel.leftAnchor.constraint(equalTo: alertChosenPriceTextField.leftAnchor),
            alertMinimalPriceLabel.widthAnchor.constraint(equalToConstant: 70),
            alertMinimalPriceLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertDescribeQuantityLabelConstraint() {
        NSLayoutConstraint.activate([
            alertDescribeQuantityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            alertDescribeQuantityLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            alertDescribeQuantityLabel.widthAnchor.constraint(equalToConstant: 70),
            alertDescribeQuantityLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertMaxQuantityLabelConstraint() {
        NSLayoutConstraint.activate([
            alertMaxQuantityLabel.topAnchor.constraint(equalTo: alertDescribeQuantityLabel.bottomAnchor, constant: 10),
            alertMaxQuantityLabel.rightAnchor.constraint(equalTo: alertDescribeQuantityLabel.rightAnchor),
            alertMaxQuantityLabel.widthAnchor.constraint(equalToConstant: 70),
            alertMaxQuantityLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertChosenQuantityTextFieldConstraint() {
        NSLayoutConstraint.activate([
            alertChosenQuantityTextField.topAnchor.constraint(equalTo: alertMaxQuantityLabel.bottomAnchor, constant: 10),
            alertChosenQuantityTextField.rightAnchor.constraint(equalTo: alertMaxQuantityLabel.rightAnchor),
            alertChosenQuantityTextField.widthAnchor.constraint(equalToConstant: 70),
            alertChosenQuantityTextField.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertMinimalQuantityLabelConstraint() {
        NSLayoutConstraint.activate([
            alertMinimalQuantityLabel.topAnchor.constraint(equalTo: alertChosenQuantityTextField.bottomAnchor, constant: 10),
            alertMinimalQuantityLabel.rightAnchor.constraint(equalTo: alertChosenQuantityTextField.rightAnchor),
            alertMinimalQuantityLabel.widthAnchor.constraint(equalToConstant: 70),
            alertMinimalQuantityLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createAlertErrorLabelConstraint() {
        NSLayoutConstraint.activate([
            alertErrorLabel.topAnchor.constraint(equalTo: alertMinimalPriceLabel.bottomAnchor, constant: 10),
            alertErrorLabel.rightAnchor.constraint(equalTo: alertMinimalQuantityLabel.rightAnchor),
            alertErrorLabel.leftAnchor.constraint(equalTo: alertMinimalPriceLabel.leftAnchor),
            alertErrorLabel.heightAnchor.constraint(equalToConstant: 20),
            alertErrorLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
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
