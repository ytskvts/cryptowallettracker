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
            self.coinsListTableView.refreshControl?.endRefreshing()
        }
    }
    
    func setTitleForTypeOfSortLabel(name: String) {
        typeOfSortLabel.text = name
    }
    
    var coinsListViewPresenter: CoinsListViewPresenterProtocol!
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearching: Bool = false

    private let describeTypeOfSortLabel: UILabel = {
        let label = UILabel()
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrow.up.arrow.down")?.withTintColor(.white)
        imageAttachment.adjustsImageSizeForAccessibilityContentSizeCategory = true
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        label.attributedText = fullString
        //label.layer.borderWidth = 1
        //label.layer.borderColor = UIColor.white.cgColor
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeOfSortLabel: UILabel = {
        let label = UILabel()
        //label.layer.borderWidth = 1
        //label.layer.borderColor = UIColor.white.cgColor
        label.textAlignment = .left
        label.numberOfLines = 1
        label.sizeToFit()
        label.adjustsFontSizeToFitWidth = true
        label.isUserInteractionEnabled = true
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
//    static let numberFormatter: NumberFormatter = {
//        let formatter = NumberFormatter()
//        formatter.locale = .current
//        formatter.allowsFloats = true
//        formatter.numberStyle = .currency
//        formatter.formatterBehavior = .default
//        return formatter
//    }()
    
    private var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        //rc.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        rc.attributedTitle = NSAttributedString(string: "Refresh table...", attributes: nil)
        return rc
    }()
    
    func setRefreshControl() {
        if #available(iOS 10.0, *) {
            coinsListTableView.refreshControl = refreshControl
        } else {
            coinsListTableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)
    }
    
    @objc func refreshControlAction() {
        coinsListViewPresenter.refreshData(searchingText: searchController.searchBar.text)
    }
    
    func configureTableHeaderViewAndSet() {
        headerView = UIView(frame: CGRect(x: .zero,
                                          y: .zero,
                                          width: coinsListTableView.frame.width,
                                          height: 30))
//        coinsListTableView.tableHeaderView = headerView
        setGestures(for: [describeTypeOfSortLabel, typeOfSortLabel])
        headerView.addSubview(typeOfSortLabel)
        headerView.addSubview(describeTypeOfSortLabel)
    }
    
    func setGestures(for elements: [UIView]) {
        elements.forEach { element in
            let gr = UITapGestureRecognizer(target: self, action: #selector(headerViewElementTapped))
            print(element)
            element.addGestureRecognizer(gr)
        }
    }
    
    @objc func headerViewElementTapped() {
        print("mm")
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: self.view.bounds.width - 10, height: self.view.bounds.width / 6)
        typeOfSortPicker.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width - 10, height: self.view.bounds.height / 6)
        vc.view.addSubview(typeOfSortPicker)
        typeOfSortPicker.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        typeOfSortPicker.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select type of sort", message: "", preferredStyle: .actionSheet)
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
        //coinsListTableView.prefetchDataSource = self
        typeOfSortPicker.delegate = self
        typeOfSortPicker.dataSource = self
        setRefreshControl()
        coinsListViewPresenter.setDefaults()
        configureTableHeaderViewAndSet()
        coinsListTableView.tableHeaderView = headerView
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = coinsListViewPresenter.getSearchBarPlaceholder()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        coinsListTableView.frame = view.bounds
        createDescribeTypeOfSortLabelConstraint()
        createTypeOfSortLabelConstraint()
    }
    
    func createDescribeTypeOfSortLabelConstraint() {
        NSLayoutConstraint.activate([
            describeTypeOfSortLabel.topAnchor.constraint(equalTo: coinsListTableView.topAnchor, constant: 5),
            describeTypeOfSortLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            describeTypeOfSortLabel.widthAnchor.constraint(equalToConstant: 25),
            describeTypeOfSortLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    func createTypeOfSortLabelConstraint() {
        NSLayoutConstraint.activate([
            typeOfSortLabel.topAnchor.constraint(equalTo: describeTypeOfSortLabel.topAnchor),
            typeOfSortLabel.leftAnchor.constraint(equalTo: describeTypeOfSortLabel.rightAnchor),
            typeOfSortLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -177),
            typeOfSortLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func showDetailVC(data: CoinTableViewCellViewModel) {
//        let panelTransition = PanelTransition()
//        let vc = DetailCoinViewController()
//        vc.modalPresentationStyle = .custom
//        vc.transitioningDelegate = panelTransition
//        vc.configure(with: data)
//        present(vc, animated: true, completion: nil)
        
        
        
//        FirebaseManager.shared.getPortfolio { portfolio in
//            guard let portfolio = portfolio else {return}
//            print(portfolio)
//            print(portfolio.coins[0].id)
//        }
        
        
        let vc = DetailCoinViewController()
        vc.configure(with: data)
        //navigationController?.pushViewController(vc, animated: true)
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    func setupActivityIndicator() {
            let spinner = UIActivityIndicatorView()
            spinner.style = .large
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: coinsListTableView.bounds.width, height: CGFloat(44))

            self.coinsListTableView.tableFooterView = spinner
            self.coinsListTableView.tableFooterView?.isHidden = false
    }
    
    func stopActivityIndicator() {
        self.coinsListTableView.tableFooterView?.isHidden = true
    }
}

extension CoinsListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coinsListViewPresenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        coinsListViewPresenter.willDisplay(forRowAt: indexPath)
    }
}

extension CoinsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinsListViewPresenter.viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = coinsListTableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath) as? CoinTableViewCell else {
            fatalError()
        }
        cell.configure(with: coinsListViewPresenter.viewData[indexPath.row])
        cell.selectionStyle = .none
        return cell
        
    }
}

//extension CoinsListViewController: UITableViewDataSourcePrefetching {
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        coinsListViewPresenter.prefetchRows(at: indexPaths)
//    }
//}

extension CoinsListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        coinsListViewPresenter.searchBarButtonClicked(.search(searchBar.text))
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        coinsListViewPresenter.searchBarButtonClicked(.cancel)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        coinsListViewPresenter.searchBarShouldBeginEditing()
    }
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
        coinsListViewPresenter.didSelectRowInPickerView(component: component, row: row, searchingText: self.searchController.searchBar.text)
        
    }
}
