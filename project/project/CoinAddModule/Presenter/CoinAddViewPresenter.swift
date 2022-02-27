//
//  CoinAddViewPresenter.swift
//  project
//
//  Created by Dzmitry on 26.02.22.
//

import Foundation

class CoinAddViewPresenter: CoinAddViewPresenterProtocol {
    
    weak var view: CoinAddViewProtocol?
    
    var viewData: CoinTableViewCellViewModel?
    
    
    init(view: CoinAddViewProtocol) {
        self.view = view
    }
    
    func checkForFilledFills(priceText: String?, quantityText: String?) -> Bool {
         !(priceText ?? "").isEmpty && !(quantityText ?? "").isEmpty
    }
    
    func checkIsInRange(number: String?, range: ClosedRange<Double>) -> Bool {
        guard let number = number,
                  let convertNum = Double(number) else {return false}
        return range.contains(convertNum)
    }
    
    func alertAction(price: String?, quantity: String?) {
        print("nice man, go home")
        guard let viewData = viewData else {return}
        view?.didActionWithErrorLabel(errorLabelCondition: .hide, typeOfError: nil)
        if checkForFilledFills(priceText: price, quantityText: quantity) {
            if checkIsInRange(number: price, range: viewData.atl...viewData.ath) && checkIsInRange(number: quantity, range: 0.0...Double.infinity) {
                print("send data")
                //sendData to firebase
                //if good then view.dismiss
                //else view.showErrorAlert
            } else {
                view?.didActionWithErrorLabel(errorLabelCondition: .show, typeOfError: .outOfRange)
            }
        } else {
            view?.didActionWithErrorLabel(errorLabelCondition: .show, typeOfError: .fieldsIsNotFilled)
        }
        
    }
    
    func configure(with data: CoinTableViewCellViewModel) {
        viewData = data
        guard let viewData = viewData else {return}
        view?.setupFields(viewData: viewData)
    }
    
    
}
