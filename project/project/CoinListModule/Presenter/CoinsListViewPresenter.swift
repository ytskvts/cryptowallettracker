//
//  CoinListViewPresenter.swift
//  project
//
//  Created by Dzmitry on 12.02.22.
//

import Foundation

class CoinsListViewPresenter: CoinsListViewPresenterProtocol {
    
    weak var view: CoinsListViewProtocol?
    
    var chosenTypeOfSort: TypeOfSort = .marketCap {
        didSet {
            //обновить название лейбла сортирoвки
            view?.setTitleForTypeOfSortLabel(name: chosenTypeOfSort.name)
            #warning("возможно понадобится сделать во вьюхе метод, который будет чекать измениться ли значение лэйбла сортировки, но это если при выборе в пикере той сортировки, которая уже стоит всё равно срабатывает дидсет и тогда не нужно обнулять numberOfPage")
            numbetOfPage = 1
            
            
        }
    }
    
    var numbetOfPage: Int = 1
    
    var viewData: [CoinTableViewCellViewModel] = [] {
        didSet { view?.tableViewReloadData() }
    }
    
//    let sortingNames: [String]
//    init(sortingNames: [String] = AppConstants
//            .CoinListScreenConstants
//            .sortingNames) {
//
//        self.sortingNames = sortingNames
//    }
    
    let sortingNames: [String] = AppConstants.CoinListScreenConstants.sortingNames
    
    
    func getPickerViewTitle(for row: Int) -> String {
        sortingNames[row]
    }
    
    func didSelectRowInPickerView(component: Int, row: Int) {
        chosenTypeOfSort = TypeOfSort(rawValue: sortingNames[row]) ?? .marketCap
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
            viewData = []
            getViewModels(typeOfRequest: .searchingRequest(searchingText: text, sortBy: chosenTypeOfSort), callback: <#T##(([CoinTableViewCellViewModel]) -> Void)##(([CoinTableViewCellViewModel]) -> Void)##([CoinTableViewCellViewModel]) -> Void#>)

        case .cancel:
            
        }
    }
    
    func prefetchRows(at indexPaths: [IndexPath]) {
        
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        //view?.showDetailVC(indexPath: indexPath)
        //переделать
    }
    
    func getNavigationTitle() -> String {
        return "Coins"
    }
    
    func getSearchBarPlaceholder() -> String {
        return "Search"
    }
    
//    func updateViewData(with data: [CoinTableViewCellViewModel]) {
//        viewData = data
//        view?.tableViewReloadData()
//    }
//
    func getViewModels(typeOfRequest: TypeOfRequest,
                       callback: @escaping (([CoinTableViewCellViewModel]) -> Void)){
        APICaller.shared.doRequest(requestType: typeOfRequest) { result in
            var newModels = [CoinTableViewCellViewModel]()
            switch result {
            case .success(let models):
//                var newModels = [CoinTableViewCellViewModel]()
                newModels = CoinModelParser(models: models).parseToViewModels()
                self.viewData.append(contentsOf: newModels)
            case .failure(let error):
                print(error)
            }
        }
    }
}


