//
//  WalletViewPresenter.swift
//  project
//
//  Created by Dzmitry on 1.03.22.
//

import Foundation

struct FirebaseModel {
    let id: String
    let quantity: Double
    let priceOfBuying: Double
}




class WalletViewPresenter: WalletViewPresenterProtocol {
    
    weak var view: WalletViewProtocol?
     
    let coinModelParser = CoinModelParser()
    
    var viewCellData: [WalletTableViewCellModel] = [] {
        didSet {
            var totalCostCurrent: Double = 0.0
            var totalCostOfBuying: Double = 0.0
            for data in viewCellData {
                totalCostCurrent += data.totalCoinPrice
            }
            for el in data {
                totalCostOfBuying += el.quantity * el.priceOfBuying
            }
            let color: ColorOfLabel
            color = totalCostCurrent > totalCostOfBuying ? .green : .red
            let priceChange = abs(totalCostCurrent - totalCostOfBuying)
            print(priceChange)
            view?.configure(totalCost: "\(totalCostCurrent)", priceChange: "\(priceChange)", labelColor: color)
            //view?.tableViewReloadData()
        }
    }
    
    var viewData: [CoinTableViewCellViewModel] = [] {
        didSet {
            print("WalletViewPresenter viewData didset")
            var newViewCellData: [WalletTableViewCellModel] = []
            viewData.forEach { model in
                for firebaseModel in data {
                    if firebaseModel.id == model.id {
                        let quantityOfCoin = Double(firebaseModel.quantity)
                        let totalPriceOfCoin = quantityOfCoin * (Double(model.currentPrice) ?? 0)
                        let cellData = WalletTableViewCellModel(image: model.image, symbol: model.symbol, quantity: quantityOfCoin, totalCoinPrice: totalPriceOfCoin)
                        newViewCellData.append(cellData)
                        break
                    }
                    
                }
                
            }
            viewCellData = newViewCellData
        }
    }
    
    var data: [FirebaseModel] = [] {
        didSet {
            //загрузить на firebase
            var idsArray: [String] = []
            data.forEach { coin in
                idsArray.append(coin.id)
            }
            getViewModels(typeOfRequest: .favouriteCoins(IDs: idsArray)) { models in
                self.viewData = models
            }
        }
    }
    
    init(view: WalletViewProtocol) {
        self.view = view
    }
    
    func getData() {
        FirebaseManager.shared.getPortfolio { portfolio in
            var convertData = [FirebaseModel]()
            guard let portfolio = portfolio else {return}
            for coin in portfolio.coins {
                convertData.append(FirebaseModel(id: coin.id, quantity: Double(coin.quantity) ?? 1.0, priceOfBuying: Double(coin.price) ?? 1.0))
            }
            self.data = convertData
        }
    }
    
//    func configureForTransition(model: FirebaseModel) {
//        data.append(model)
//    }
    
    
    
    func deleteCoinFromPortfolio(index: IndexPath) {
        let id = data[index.row].id
        data.remove(at: index.row)
        FirebaseManager.shared.delete(id: id)
    }
    
    
    func getViewModels(typeOfRequest: TypeOfRequest,
                            callback: @escaping (([CoinTableViewCellViewModel]) -> Void)){
        APICaller.shared.doRequest(requestType: typeOfRequest) { result in
            switch result {
            case .success(let models):
                callback(self.coinModelParser.parseToViewModels(models: models))
            case .failure(let error):
                print(error)
            }
        }
    }
}
