//
//  CoinTableViewCell.swift
//  project
//
//  Created by Dzmitry on 6.12.21.
//

import UIKit

#warning("Correct this")
struct CoinTableViewCellViewModel {
    
    let name: String
    let symbol: String
    let currentPrice: String
    let image: UIImage
    let highDayPrice: Double
    let lowDayPrice: Double
    let priceChangeDay: Double
    let priceChangePercentageDay: Double
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let ath: Double
    let atl: Double
}

class CoinTableViewCell: UITableViewCell {
    
    static let identifier = "CoinTableViewCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(coinImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(currentPriceLabel)
        contentView.addSubview(symbolLabel)
        
        createCoinImageViewConstraint()
        createNameLabelConstraint()
        createCurrentPriceLabelConstraint()
        createSymbolLabelConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with viewModel: CoinTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        currentPriceLabel.text = viewModel.currentPrice
        coinImageView.image = viewModel.image
    }
    
    func createCoinImageViewConstraint() {
        NSLayoutConstraint.activate([
            coinImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            coinImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            coinImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            coinImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func createNameLabelConstraint() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 80),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            nameLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func createSymbolLabelConstraint() {
        NSLayoutConstraint.activate([
            symbolLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            symbolLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            symbolLabel.heightAnchor.constraint(equalToConstant: 20),
            symbolLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func createCurrentPriceLabelConstraint() {
        NSLayoutConstraint.activate([
            currentPriceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            currentPriceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            currentPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            currentPriceLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
    }

}
