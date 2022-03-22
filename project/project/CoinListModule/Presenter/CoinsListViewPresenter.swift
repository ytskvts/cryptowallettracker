//
//  CoinListViewPresenter.swift
//  project
//
//  Created by Dzmitry on 12.02.22.
//

import Foundation
import UIKit

class CoinsListViewPresenter: CoinsListViewPresenterProtocol {
    
    
    
    weak var view: CoinsListViewProtocol?
    
    var isSearching: Bool = false
    var numberOfPage: Int = 1 {
        didSet {
            if numberOfPage == 1 {
                viewData = []
            }
            getViewModels(typeOfRequest: .allCurrencies(sortBy: chosenTypeOfSort, numberOfPage: numberOfPage), callback: updateViewData)
        }
    }
    var viewData: [CoinTableViewCellViewModel] = [] {
        didSet {
            view?.tableViewReloadData()
            if !isSearching {
                tempViewData = oldValue
            }
        }
    }
    var tempViewData: [CoinTableViewCellViewModel] = []
    var chosenTypeOfSort: TypeOfSort = .marketCap {
        didSet {
            //обновить название лейбла сортирoвки
            view?.setTitleForTypeOfSortLabel(name: chosenTypeOfSort.name)
            #warning("возможно понадобится сделать во вьюхе метод, который будет чекать изменится ли значение лэйбла сортировки, но это если при выборе в пикере той сортировки, которая уже стоит всё равно срабатывает дидсет и тогда не нужно обнулять numberOfPage")
            if !isSearching {
                resetPageNumber(oldChosenTypeOfSort: oldValue)
            }
        }
    }
    
    
    func didSelectRow(at indexPath: IndexPath) {
        view?.showDetailVC(data: viewData[indexPath.row])
    }
    
    
    
    private func updateSearchDataforCurrentSort(text: String?) {
        guard let text = text else {
            return
        }
        if isSearching {
            viewData = [] 
            isSearching = true
            getViewModels(typeOfRequest: .searchingRequest(searchingText: text, sortBy: chosenTypeOfSort)) { models in
                self.viewData = models
            }
        }
    }
    
    func refreshData(searchingText: String?) {
        if isSearching {
            updateSearchDataforCurrentSort(text: searchingText)
        } else {
            numberOfPage = 1
        }
    }
    var tempChosenTypeOfSort: TypeOfSort?
    let coinModelParser = CoinModelParser()
    let sortingNames: [String] = AppConstants.CoinListScreenConstants.sortingNames
    
    init(view: CoinsListViewProtocol) {
        self.view = view
    }
    
    func resetPageNumber(oldChosenTypeOfSort: TypeOfSort) {
        if chosenTypeOfSort != oldChosenTypeOfSort {
            numberOfPage = 1
        }
    }
    
    #warning("вызвать в вьюдидлоад")
    func setDefaults() {
        chosenTypeOfSort = .marketCap
        numberOfPage = 1
    }
    
    func getPickerViewTitle(for row: Int) -> String {
        sortingNames[row]
    }
    
    func didSelectRowInPickerView(component: Int, row: Int, searchingText: String?) {
        chosenTypeOfSort = TypeOfSort(rawValue: sortingNames[row]) ?? .marketCap
        updateSearchDataforCurrentSort(text: searchingText)
    }
    
    func getAmountOfPickerViewComponents() -> Int {
        return 1
    }
    
    func getAmountOfPickerViewRows(in component: Int) -> Int {
        sortingNames.count
    }
    
    func searchBarButtonClicked(_ type: SearchBarButtonTapType) {
        switch type {
        case .search(let text):
            guard let text = text else { return }
            
            viewData = [] // срабатывает дидсет у вьюдата и в темпвьюдата загружается старое значение вьюдаты
            isSearching = true
            getViewModels(typeOfRequest: .searchingRequest(searchingText: text, sortBy: chosenTypeOfSort)) { models in
                self.viewData = models
            }
        case .cancel:
            if !tempViewData.isEmpty {
                viewData = tempViewData
            }
            
            guard let tempChosenTypeOfSort = tempChosenTypeOfSort else {
                return
            }
            chosenTypeOfSort = tempChosenTypeOfSort
            isSearching = false
        }
    }
    
    func searchBarShouldBeginEditing() -> Bool {
        tempChosenTypeOfSort = chosenTypeOfSort
        return true
    }
    
    
    func updateViewData(with data: [CoinTableViewCellViewModel]) {
        viewData.append(contentsOf: data)
    }
    
    
    func willDisplay(forRowAt indexPath: IndexPath) {
        if !isSearching && numberOfPage < 58 {
            if indexPath.row == viewData.count - 1 {
                view?.setupActivityIndicator()
                numberOfPage += 1
            }
        } else {
            view?.stopActivityIndicator()
        }
    }
    
    func getNavigationTitle() -> String {
        return "Coins"
    }
    
    func getSearchBarPlaceholder() -> String {
        return "Search"
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


