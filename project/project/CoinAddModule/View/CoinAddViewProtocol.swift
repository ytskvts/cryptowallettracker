//
//  CoinAddViewProtocol.swift
//  project
//
//  Created by Dzmitry on 26.02.22.
//

import Foundation


enum ErrorType: String {
    case fieldsIsNotFilled = "Fields is't filled."
    case outOfRange = "Value is out of range."
}

enum ErrorLabelCondition {
    case show
    case hide
}

protocol CoinAddViewProtocol: AnyObject {
    
    func configure(data: CoinTableViewCellViewModel)
    
    func setupFields(viewData: CoinTableViewCellViewModel)
    
    func didActionWithErrorLabel(errorLabelCondition: ErrorLabelCondition, typeOfError: ErrorType?)
    
    //func transitionToWalletScreen(model: FirebaseModel)
    
    func dismissController()
    
    //func getTextfieldsText() -> (price: String?, quantity: String?)
}
