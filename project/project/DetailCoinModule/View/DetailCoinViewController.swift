//
//  DetailCoinViewController.swift
//  project
//
//  Created by Dzmitry on 7.12.21.
//

import UIKit
import SwiftUI

class DetailCoinViewController: UIViewController, DetailCoinViewProtocol {
    
    var detailCoinViewPresenter: DetailCoinViewPresenterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        detailCoinViewPresenter = DetailCoinViewPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var chartViewController: UIHostingController<ChartView>?
    
    func setupChartViewController() {
        guard let chartViewController = chartViewController else {return}
        addChild(chartViewController)
        view.addSubview(chartViewController.view)
        chartViewController.didMove(toParent: self)
        chartViewController.view.translatesAutoresizingMaskIntoConstraints = false
        chartViewController.view.backgroundColor = .systemBackground
    }
    
    private let addToPortfolioButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 30)
        button.setImage(UIImage(systemName: "bag.badge.plus", withConfiguration: imageConfig), for: .normal)
        button.addTarget(self, action: #selector(addToPortfolioButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func addToPortfolioButtonTapped() {
        detailCoinViewPresenter?.addToPortfolioButtonAction()
    }
    
    func showVC(data: CoinTableViewCellViewModel) {
        let panelTransition = PanelTransition()
        let vc = CoinAddViewController()
        vc.modalPresentationStyle = .custom
        vc.transitioningDelegate = panelTransition
        vc.configure(data: data)
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .center
//        label.layer.borderWidth = 1
//        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
//        //label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
//        label.layer.cornerRadius = 3
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let coinImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let priceChangeDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
//        label.layer.borderWidth = 1
//        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
//        //label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
//        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeDayPercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
//        label.layer.borderWidth = 1
//        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
//        //label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
//        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lowPriceDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.textColor = .systemRed
//        label.layer.borderWidth = 1
//        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
//        //label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
//        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highPriceDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.textColor = .systemGreen
//        label.layer.borderWidth = 1
//        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
//        //label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
//        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentPriceDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Price:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeDayDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Price change 24h:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeDayPercentDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Price change 24h:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lowPriceDayDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Lowest price 24h:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highPriceDayDecribeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .left
        label.text = "Highest price 24h:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelsColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let valuesColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    func configureStackViews() {
        labelsColumnStackView.addArrangedSubview(currentPriceDecribeLabel)
        labelsColumnStackView.addArrangedSubview(priceChangeDayDecribeLabel)
        labelsColumnStackView.addArrangedSubview(priceChangeDayPercentDecribeLabel)
        labelsColumnStackView.addArrangedSubview(highPriceDayDecribeLabel)
        labelsColumnStackView.addArrangedSubview(lowPriceDayDecribeLabel)
        valuesColumnStackView.addArrangedSubview(currentPriceLabel)
        valuesColumnStackView.addArrangedSubview(priceChangeDayLabel)
        valuesColumnStackView.addArrangedSubview(priceChangeDayPercentLabel)
        valuesColumnStackView.addArrangedSubview(highPriceDayLabel)
        valuesColumnStackView.addArrangedSubview(lowPriceDayLabel)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupChartViewController()
        configureStackViews()
        view.addSubview(coinImageView)
        view.addSubview(addToPortfolioButton)
        view.addSubview(nameLabel)
        view.addSubview(symbolLabel)
        view.addSubview(labelsColumnStackView)
        view.addSubview(valuesColumnStackView)
        createCoinImageViewConstraint()
        createAddToPortfolioButtonConstraint()
        createNameLabelConstraint()
        createSymbolLabelConstraint()
        createChartViewConstraint()
        createLabelsColumnStackViewConstraint()
        createLabelsValuesColumnStackViewConstraint()
        
    }
    
    func createAddToPortfolioButtonConstraint() {
        NSLayoutConstraint.activate([
            addToPortfolioButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            addToPortfolioButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            addToPortfolioButton.widthAnchor.constraint(equalToConstant: 50),
            addToPortfolioButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createChartViewConstraint() {
        guard let chartView = chartViewController?.view else {return}
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: 10),
            chartView.widthAnchor.constraint(equalTo: view.widthAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    
    func createLabelsColumnStackViewConstraint() {
        guard let chartView = chartViewController?.view else {return}
        NSLayoutConstraint.activate([
            labelsColumnStackView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 10),
            labelsColumnStackView.widthAnchor.constraint(equalToConstant: 200),
            labelsColumnStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            labelsColumnStackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func createLabelsValuesColumnStackViewConstraint() {
        
        NSLayoutConstraint.activate([
            valuesColumnStackView.topAnchor.constraint(equalTo: labelsColumnStackView.topAnchor),
            valuesColumnStackView.widthAnchor.constraint(equalToConstant: 150),
            valuesColumnStackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            valuesColumnStackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func createCoinImageViewConstraint() {
        
        NSLayoutConstraint.activate([
            coinImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            coinImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            coinImageView.widthAnchor.constraint(equalToConstant: 50),
            coinImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createNameLabelConstraint() {
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: coinImageView.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: addToPortfolioButton.leftAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createSymbolLabelConstraint() {
        
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            symbolLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            symbolLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            symbolLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
    }

    
    func configure(with data: CoinTableViewCellViewModel) {
        detailCoinViewPresenter?.configure(data: data)
    }
    
    func setupFields(viewData: CoinTableViewCellViewModel) {
        nameLabel.text = viewData.name
        symbolLabel.text = viewData.symbol
        currentPriceLabel.text = viewData.currentPrice
        coinImageView.image = viewData.image
        if viewData.priceChangeDay > 0 {
            priceChangeDayLabel.textColor = .systemGreen
            priceChangeDayPercentLabel.textColor = .systemGreen
        } else {
            priceChangeDayLabel.textColor = .systemRed
            priceChangeDayPercentLabel.textColor = .systemRed
        }
        priceChangeDayLabel.text = "\(viewData.priceChangeDay) $"
        priceChangeDayPercentLabel.text = "\(viewData.priceChangePercentageDay) %"
        lowPriceDayLabel.text = "\(viewData.lowDayPrice) $"
        highPriceDayLabel.text = "\(viewData.highDayPrice) $"
        chartViewController = UIHostingController(rootView: ChartView(coin: viewData))
    }
}
