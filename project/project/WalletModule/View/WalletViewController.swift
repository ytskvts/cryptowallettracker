//
//  WalletViewController.swift
//  project
//
//  Created by Dzmitry on 4.01.22.
//

import UIKit

class WalletViewController: UIViewController, WalletViewProtocol {
    
    var walletViewPresenter: WalletViewPresenterProtocol?
    
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        walletViewPresenter = WalletViewPresenter(view: self)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    private let bagLabel: UILabel = {
        let label = UILabel()
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30)
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "bag", withConfiguration: imageConfig)?.withTintColor(.white)
        imageAttachment.adjustsImageSizeForAccessibilityContentSizeCategory = true
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        label.attributedText = fullString
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let totalCostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let walletCoinsListTableView: UITableView = {
        let tableView = UITableView()
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.register(WalletTableViewCell.self, forCellReuseIdentifier: WalletTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        walletViewPresenter = WalletViewPresenter(view: self)
        
        title = "Wallet"
        view.backgroundColor = .systemBlue
        walletCoinsListTableView.dataSource = self
        walletCoinsListTableView.delegate = self
        view.addSubview(walletCoinsListTableView)
        view.addSubview(bagLabel)
        view.addSubview(totalCostLabel)
        view.addSubview(priceChangeLabel)
        
        createWalletCoinsListTableViewConstraint()
        createBagLabelConstraint()
        createTotalCostLabelConstraint()
        createPriceChangeLabelConstraint()
        walletViewPresenter?.getData()
        // Do any additional setup after loading the view.
    }

    
    func configureForTransition(model: FirebaseModel) {
        walletViewPresenter?.configureForTransition(model: model)
    }
    
    func configure(totalCost: String, priceChange: String) {
        totalCostLabel.text = totalCost + " $"
        priceChangeLabel.text = priceChange + " $"
        tableViewReloadData()
    }
    
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.walletCoinsListTableView.reloadData()
            //self.coinsListTableView.refreshControl?.endRefreshing()
        }
    }
    
    func createBagLabelConstraint() {
        NSLayoutConstraint.activate([
            bagLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            bagLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            bagLabel.widthAnchor.constraint(equalToConstant: 50),
            bagLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createTotalCostLabelConstraint() {
        NSLayoutConstraint.activate([
            totalCostLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            totalCostLabel.leftAnchor.constraint(equalTo: bagLabel.rightAnchor, constant: 20),
            totalCostLabel.widthAnchor.constraint(equalToConstant: 100),
            totalCostLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createPriceChangeLabelConstraint() {
        NSLayoutConstraint.activate([
            priceChangeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            priceChangeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 20),
            priceChangeLabel.widthAnchor.constraint(equalToConstant: 100),
            priceChangeLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createWalletCoinsListTableViewConstraint() {
        NSLayoutConstraint.activate([
            walletCoinsListTableView.topAnchor.constraint(equalTo: bagLabel.bottomAnchor, constant: 10),
            walletCoinsListTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            walletCoinsListTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            walletCoinsListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension WalletViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //coinsListViewPresenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //coinsListViewPresenter.willDisplay(forRowAt: indexPath)
    }
}

extension WalletViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let presenter = walletViewPresenter else {return 10}
        return presenter.viewCellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = walletCoinsListTableView.dequeueReusableCell(withIdentifier: WalletTableViewCell.identifier, for: indexPath) as? WalletTableViewCell,
              let presenter = walletViewPresenter else { fatalError() }
        cell.configure(with: presenter.viewCellData[indexPath.row])
        cell.selectionStyle = .none
        return cell
        
    }
}
