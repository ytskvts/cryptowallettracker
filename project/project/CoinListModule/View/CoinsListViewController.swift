//
//  CoinsListViewController.swift
//  project
//
//  Created by Dzmitry on 6.12.21.
//

import UIKit

class CoinsListViewController: UIViewController, CoinsListViewProtocol {
    
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.coinsListTableView.reloadData()
        }
    }
    
    func setTitleForTypeOfSortLabel(name: String) {
        typeOfSortLabel.text = name
    }
    
    
    var coinsListViewPresenter: CoinsListViewPresenterProtocol!
 
    //MARK: just for minimum viable product
    private var usualViewModels = [CoinTableViewCellViewModel]()
    private var searchingModeViewModels = [CoinTableViewCellViewModel]()
    private var numberOfPage: Int = 1
    private var chosenTypeOfSort = TypeOfSort.marketCap
    
//    let namesOfSort = ["Market capitalization", "Volume", "Popular"]

    
    private let searchController = UISearchController(searchResultsController: nil)
    
    
    
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else {return false}
//        return text.isEmpty
//    }
    
//    private var isSearching : Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
    
    private var isSearching: Bool = false
    
    private let describeTypeOfSortLabel: UILabel = {
        let label = UILabel()
        //label.text = "Sort by:"
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrow.up.arrow.down.square")?.withTintColor(.gray)
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        label.attributedText = fullString
        label.font = label.font.withSize(20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeOfSortLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private let typeOfSortTextField: UITextField = {
//        let textField = TypeOfSortTextField()
//        textField.text = "Market capitalization"
////        textField.addTarget(self, action: #selector(CoinsListViewController.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        let image = UIImageView(image: UIImage(systemName: "chevron.down"))
////        let rightView = UIView()
////        rightView.addSubview(image!)
//        textField.rightView = image
//        textField.rightViewMode = .always
//        return textField
//    }()
    
    var typeOfSortPicker: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private let coinsListTableView: UITableView = {
        let tableView = UITableView()
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: do it later
    static let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = .current
        formatter.allowsFloats = true
        formatter.numberStyle = .currency
        formatter.formatterBehavior = .default
        return formatter
    }()
    
//    private lazy var headerView: UIView = {
//        let view = UIView(frame: CGRect(x: .zero,
//                                        y: .zero,
//                                        width: coinsListTableView.frame.width,
//                                        height: 25))
//        return view
//    }()
    
    private var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @objc func headerViewTapped() {
        print("mm")
    }
    
    func configureTableHeaderViewAndSet() {
        headerView = UIView(frame: CGRect(x: .zero,
                                          y: .zero,
                                          width: coinsListTableView.frame.width,
                                          height: 25))
        let gr = UITapGestureRecognizer(target: self, action: #selector(headerViewTapped))
        
//        coinsListTableView.tableHeaderView = headerView
        typeOfSortLabel.addGestureRecognizer(gr)
        describeTypeOfSortLabel.addGestureRecognizer(gr)
        headerView.addSubview(typeOfSortLabel)
        headerView.addSubview(describeTypeOfSortLabel)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        coinsListViewPresenter = CoinsListViewPresenter(view: self)
        title = coinsListViewPresenter.getNavigationTitle()
        view.addSubview(coinsListTableView)
//        view.addSubview(describeTypeOfSortLabel)
//        view.addSubview(typeOfSortTextField)
        coinsListTableView.dataSource = self
        coinsListTableView.delegate = self
        coinsListTableView.prefetchDataSource = self
        typeOfSortPicker.delegate = self
        typeOfSortPicker.dataSource = self
        coinsListViewPresenter.setDefaults()
        //typeOfSortTextField.inputView = typeOfSortPicker
//        let headerView = UIView(frame: CGRect(x: .zero,
//                                              y: .zero,
//                                              width: coinsListTableView.frame.width,
//                                              height: 25))
//       // coinsListTableView.tableHeaderView = headerView
//        headerView.addSubview(describeTypeOfSortLabel)
//        headerView.addSubview(typeOfSortLabel)
        configureTableHeaderViewAndSet()
        coinsListTableView.tableHeaderView = headerView
        //coinsListTableView.tableHeaderView = headerView
        //searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = coinsListViewPresenter.getSearchBarPlaceholder()
        navigationItem.searchController = searchController
        definesPresentationContext = true
       
        //getCurrencies()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        coinsListTableView.frame = view.bounds
        
        createDescribeTypeOfSortLabelConstraint()
        createTypeOfSortLabelConstraint()
        //configureTableHeaderView()
        //createDescribeTypeOfSortLabelConstraint()
        //createTypeOfSortTextFieldConstraint()
        //createCoinsListTableViewConstraint()
    }
    

    
    func createDescribeTypeOfSortLabelConstraint() {
        NSLayoutConstraint.activate([
            describeTypeOfSortLabel.topAnchor.constraint(equalTo: coinsListTableView.topAnchor, constant: 5),
            describeTypeOfSortLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            describeTypeOfSortLabel.widthAnchor.constraint(equalToConstant: 30),
            describeTypeOfSortLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    func createTypeOfSortLabelConstraint() {
        NSLayoutConstraint.activate([
            typeOfSortLabel.topAnchor.constraint(equalTo: describeTypeOfSortLabel.topAnchor),
            typeOfSortLabel.leftAnchor.constraint(equalTo: describeTypeOfSortLabel.rightAnchor, constant: 5),
            typeOfSortLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            typeOfSortLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
//    func createCoinsListTableViewConstraint() {
//        NSLayoutConstraint.activate([
//            coinsListTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//            coinsListTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            coinsListTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            coinsListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
    
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        print("fuck")
//        //let label = UILabel()
//        //let gr = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
//        //label.addGestureRecognizer(gr)
//
//        guard let text = textField.text,
//              let sortingType = TypeOfSort(rawValue: text) else {
//                  return }
//        chosenTypeOfSort = sortingType
//        if isSearching {
//
//        } else {
//            numberOfPage = 1
//            self.usualViewModels = []
//            getCurrencies()
//        }
//        print("fwefgwe")
//    }
    
//    @objc func labelTapped() {
//
//    }
 
//    func setSortLabelText(name: String) {
//
//    }
    
//    @objc func getCurrencies() {
//        let requestType = TypeOfRequest.allCurrencies(sortBy: chosenTypeOfSort, numberOfPage: numberOfPage)
//        APICaller.shared.doRequest(requestType: requestType) { [weak self] result in
//            switch result {
//            case .success(let models):
//                var newModels = [CoinTableViewCellViewModel]()
//                newModels = models.compactMap({
//                    // use Numberformatter instead of this
//                    var currentPrice = $0.current_price
//                    var convertPrice: String
//                    if currentPrice.truncatingRemainder(dividingBy: 1) != 0 {
//                        currentPrice = Double(round(currentPrice * 1000) / 1000)
//                        convertPrice = String(format: "%.2f", currentPrice)
//                    } else {
//                        convertPrice = "\(Int(currentPrice))"
//                    }
//                    do {
//                        let imageData = try Data(contentsOf: URL(string: $0.image)!)
//                        let image = UIImage(data: imageData)
//                        return CoinTableViewCellViewModel(name: $0.name,
//                                                          symbol: $0.symbol,
//                                                          currentPrice: convertPrice + " $",
//                                                          image: image ?? UIImage(systemName: "eye")!,
//                                                          highDayPrice: $0.high_24h ?? 0,
//                                                          lowDayPrice: $0.low_24h ?? 0,
//                                                          priceChangeDay: $0.price_change_24h ?? 0,
//                                                          priceChangePercentageDay: $0.price_change_percentage_24h ?? 0)
//                    } catch {
//                        print(error)
//                        return nil
//                    }
//                })
//                self?.usualViewModels.append(contentsOf: newModels)
//                DispatchQueue.main.async {
//                    self?.coinsListTableView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
////        APICaller.shared.getAllCryptoData(numberOfPage: numberOfPage) { [weak self] result in
////            switch result {
////            case .success(let models):
////                var newModels = [CoinTableViewCellViewModel]()
////                newModels = models.compactMap({
////                    // use Numberformatter instead of this
////                    var currentPrice = $0.current_price
////                    var convertPrice: String
////                    if currentPrice.truncatingRemainder(dividingBy: 1) != 0 {
////                        currentPrice = Double(round(currentPrice * 1000) / 1000)
////                        convertPrice = String(format: "%.2f", currentPrice)
////                    } else {
////                        convertPrice = "\(Int(currentPrice))"
////                    }
////                    do {
////                        let imageData = try Data(contentsOf: URL(string: $0.image)!)
////                        let image = UIImage(data: imageData)
////                        return CoinTableViewCellViewModel(name: $0.name,
////                                                          symbol: $0.symbol,
////                                                          currentPrice: convertPrice + " $",
////                                                          image: image ?? UIImage(systemName: "eye")!,
////                                                          highDayPrice: $0.high_24h,
////                                                          lowDayPrice: $0.low_24h,
////                                                          priceChangeDay: $0.price_change_24h,
////                                                          priceChangePercentageDay: $0.price_change_percentage_24h)
////                    } catch {
////                        print(error)
////                        return nil
////                    }
////                })
////                self?.viewModels.append(contentsOf: newModels)
////                DispatchQueue.main.async {
////                    self?.coinsListTableView.reloadData()
////                }
////            case .failure(let error):
////                print(error)
////            }
////        }
//    }
    
    func showDetailVC(indexPath: IndexPath) {
        //typeOfSortTextField.resignFirstResponder()
        let detailVC = DetailCoinViewController()
        print("showDetailVC")
//        if isSearching {
//            detailVC.configure(with: searchingModeViewModels[indexPath.row])
//        } else {
//            detailVC.configure(with: usualViewModels[indexPath.row])
//        }
        detailVC.configure(with: coinsListViewPresenter.viewData[indexPath.row])
        present(detailVC, animated: true, completion: nil)
    }
}












extension CoinsListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailVC(indexPath: indexPath)
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 25
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView(frame: CGRect(x: 0,
//                                                  y: 0,
//                                                  width: tableView.frame.width,
//                                                  height: 25))
//        headerView.addSubview(describeTypeOfSortLabel)
//        NSLayoutConstraint.activate([
//            describeTypeOfSortLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 5),
//            describeTypeOfSortLabel.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 10),
//            describeTypeOfSortLabel.widthAnchor.constraint(equalToConstant: 70),
//            describeTypeOfSortLabel.heightAnchor.constraint(equalToConstant: 20)
//        ])
//        headerView.addSubview(typeOfSortTextField)
//        NSLayoutConstraint.activate([
//            typeOfSortTextField.topAnchor.constraint(equalTo: describeTypeOfSortLabel.topAnchor),
//            typeOfSortTextField.leftAnchor.constraint(equalTo: describeTypeOfSortLabel.rightAnchor, constant: 5),
//            typeOfSortTextField.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: -10),
//            typeOfSortTextField.heightAnchor.constraint(equalToConstant: 20)
//        ])
//        return headerView
//    }
}

extension CoinsListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isSearching {
//            return searchingModeViewModels.count
//        }
//        return usualViewModels.count
        return coinsListViewPresenter.viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = coinsListTableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath) as? CoinTableViewCell else {
            fatalError()
        }
//        if isSearching {
//            cell.configure(with: searchingModeViewModels[indexPath.row])
//        } else {
//            cell.configure(with: usualViewModels[indexPath.row])
//        }
        cell.configure(with: coinsListViewPresenter.viewData[indexPath.row])
        cell.selectionStyle = .none
        return cell
        
    }
}

extension CoinsListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        guard let lastIndexPath = indexPaths.last,
//              usualViewModels.count - 1 > lastIndexPath.row else { return }
//
//        if !isSearching {
//            if numberOfPage < 58 {
//                numberOfPage += 1
//                getCurrencies()
//            }
//        }
        coinsListViewPresenter.prefetchRows(at: indexPaths)

    }


}

//extension CoinsListViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        print("t")
//    }
//
//
//}

extension CoinsListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        isSearching = true
//        self.searchingModeViewModels = []
//        guard let searchText = searchBar.text else {return}
//        let requestType = TypeOfRequest.searchingRequest(searchingText: searchText, sortBy: chosenTypeOfSort)
//        APICaller.shared.doRequest(requestType: requestType) { [weak self] result in
//            switch result {
//            case .success(let models):
//                var newModels = [CoinTableViewCellViewModel]()
//                newModels = models.compactMap({
//                    // use Numberformatter instead of this
//                    var currentPrice = $0.current_price
//                    var convertPrice: String
//                    if currentPrice.truncatingRemainder(dividingBy: 1) != 0 {
//                        currentPrice = Double(round(currentPrice * 1000) / 1000)
//                        convertPrice = String(format: "%.2f", currentPrice)
//                    } else {
//                        convertPrice = "\(Int(currentPrice))"
//                    }
//                    do {
//                        let imageData = try Data(contentsOf: URL(string: $0.image)!)
//                        let image = UIImage(data: imageData)
//                        print("vkusnp")
//                        return CoinTableViewCellViewModel(name: $0.name,
//                                                          symbol: $0.symbol,
//                                                          currentPrice: convertPrice + " $",
//                                                          image: image ?? UIImage(systemName: "eye")!,
//                                                          highDayPrice: $0.high_24h ?? 0,
//                                                          lowDayPrice: $0.low_24h ?? 0,
//                                                          priceChangeDay: $0.price_change_24h ?? 0,
//                                                          priceChangePercentageDay: $0.price_change_percentage_24h ?? 0)
//                    } catch {
//                        print(error)
//                        print("eh")
//                        return nil
//                    }
//                })
//                self?.searchingModeViewModels.append(contentsOf: newModels)
//                //print(self?.searchingModeViewModels)
//                DispatchQueue.main.async {
//                    self?.coinsListTableView.reloadData()
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
        //guard let searchText = searchBar.text else {return}
        coinsListViewPresenter.searchBarButtonClicked(.search(searchBar.text))
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        coinsListViewPresenter.searchBarButtonClicked(.cancel)
//        isSearching = false
//        searchingModeViewModels = []
//        coinsListTableView.reloadData()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        coinsListViewPresenter.searchBarShouldBeginEditing()
    }
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        //isSearching = true
//
//    }
}

extension CoinsListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return coinsListViewPresenter.getAmountOfPickerViewComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinsListViewPresenter.getAmountOfPickerViewRows(in: component)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinsListViewPresenter.getPickerViewTitle(for: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //typeOfSortTextField.text = namesOfSort[row]
//        typeOfSortLabel.text =
//        typeOfSortTextField.text = ""
//        typeOfSortTextField.insertText(namesOfSort[row])
        coinsListViewPresenter.didSelectRowInPickerView(component: component, row: row)
        //typeOfSortTextField.resignFirstResponder()
        
    }
    
}
