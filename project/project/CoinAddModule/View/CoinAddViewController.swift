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
        label.text = "Incorrect input."
        return label
    }()
    
    //Mark: Alert elements emplement end

    override func viewDidLoad() {
        super.viewDidLoad()
        coinAddViewPresenter = CoinAddViewPresenter(view: self)
        alertChosenPriceTextField.delegate = self
        alertChosenQuantityTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    func configure(data: CoinTableViewCellViewModel) {
        coinAddViewPresenter?.configure(with: data)
    }
    
    func setupFields(viewData: CoinTableViewCellViewModel) {
        //alertMaxPriceLabel.text = viewData.ath
        //alertMinimalPriceLabel.text = viewData.atl
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
