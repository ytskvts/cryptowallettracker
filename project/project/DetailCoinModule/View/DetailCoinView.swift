//
//  DetailCoinView.swift
//  project
//
//  Created by Dzmitry on 28.12.21.
//

import UIKit

class DetailCoinView: UIView {

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
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
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
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceChangeDayPercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lowPriceDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.textColor = .systemRed
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let highPriceDayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.textColor = .systemGreen
        label.layer.borderWidth = 1
        label.layer.borderColor = #colorLiteral(red: 0.1335558891, green: 0.1335814297, blue: 0.1335502863, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.07139258832, green: 0.07140973955, blue: 0.07138884813, alpha: 1)
        label.layer.cornerRadius = 3
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
    
    private lazy var labelsColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 40
        stackView.addArrangedSubview(currentPriceDecribeLabel)
        stackView.addArrangedSubview(priceChangeDayDecribeLabel)
        stackView.addArrangedSubview(priceChangeDayPercentDecribeLabel)
        stackView.addArrangedSubview(highPriceDayDecribeLabel)
        stackView.addArrangedSubview(lowPriceDayDecribeLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var valuesColumnStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.fill
        stackView.spacing = 40
        stackView.addArrangedSubview(currentPriceLabel)
        stackView.addArrangedSubview(priceChangeDayLabel)
        stackView.addArrangedSubview(priceChangeDayPercentLabel)
        stackView.addArrangedSubview(highPriceDayLabel)
        stackView.addArrangedSubview(lowPriceDayLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        createCoinImageViewConstraint()
        createLabelsColumnStackViewConstraint()
        createLabelsValuesColumnStackViewConstraint()
        createNameLabelConstraint()
        createSymbolLabelConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Constraints
    func createLabelsColumnStackViewConstraint() {
        addSubview(labelsColumnStackView)
        NSLayoutConstraint.activate([
            labelsColumnStackView.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: 250),
            labelsColumnStackView.widthAnchor.constraint(equalToConstant: 200),
            labelsColumnStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            labelsColumnStackView.heightAnchor.constraint(equalToConstant: 390)
        ])
    }
    
    func createLabelsValuesColumnStackViewConstraint() {
        addSubview(valuesColumnStackView)
        NSLayoutConstraint.activate([
            valuesColumnStackView.topAnchor.constraint(equalTo: coinImageView.bottomAnchor, constant: 250),
            valuesColumnStackView.widthAnchor.constraint(equalToConstant: 100),
            valuesColumnStackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            valuesColumnStackView.heightAnchor.constraint(equalToConstant: 390)
        ])
    }
    
    func createCoinImageViewConstraint() {
        addSubview(coinImageView)
        NSLayoutConstraint.activate([
            coinImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            coinImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            coinImageView.widthAnchor.constraint(equalToConstant: 50),
            coinImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createNameLabelConstraint() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: coinImageView.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func createSymbolLabelConstraint() {
        addSubview(symbolLabel)
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            symbolLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            symbolLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            symbolLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor)
        ])
    }
    
    
    
    func configureDetailVC(with viewModel: CoinTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        currentPriceLabel.text = viewModel.currentPrice
        coinImageView.image = viewModel.image
        if viewModel.priceChangeDay > 0 {
            priceChangeDayLabel.textColor = .systemGreen
            priceChangeDayPercentLabel.textColor = .systemGreen
        } else {
            priceChangeDayLabel.textColor = .systemRed
            priceChangeDayPercentLabel.textColor = .systemRed
        }
        priceChangeDayLabel.text = "\(viewModel.priceChangeDay) $"
        priceChangeDayPercentLabel.text = "\(viewModel.priceChangePercentageDay) %"
        lowPriceDayLabel.text = "\(viewModel.lowDayPrice) $"
        highPriceDayLabel.text = "\(viewModel.highDayPrice) $"
    }

}
