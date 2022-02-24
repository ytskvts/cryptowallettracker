//
//  DetailCoinViewController.swift
//  project
//
//  Created by Dzmitry on 7.12.21.
//

import UIKit

class DetailCoinViewController: UIViewController, DetailCoinViewProtocol {
    
    var detailCoinViewPresenter: DetailCoinViewPresenterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        detailCoinViewPresenter = DetailCoinViewPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //lazy var detailCoinViewPresenter = DetailCoinViewPresenter(view: self)
    
//    //var detailCoinView = DetailCoinView()
//
//
//    override func loadView() {
//        //view = detailCoinView
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //detailCoinViewPresenter = DetailCoinViewPresenter(view: self)
    }
    

//    func configure(with viewModel: CoinTableViewCellViewModel) {
//        detailCoinView.configureDetailVC(with: viewModel)
//    }
    
//    func setupView(detailCoinView: DetailCoinView) {
//        view = detailCoinView
//    }
    
    func configure(with data: CoinTableViewCellViewModel) {
        detailCoinViewPresenter?.configure(data: data)
    }
    
    func setupFields(viewData: CoinTableViewCellViewModel) {
//        nameLabel.text = viewModel.name
//        symbolLabel.text = viewModel.symbol
//        currentPriceLabel.text = viewModel.currentPrice
//        coinImageView.image = viewModel.image
//        if viewModel.priceChangeDay > 0 {
//            priceChangeDayLabel.textColor = .systemGreen
//            priceChangeDayPercentLabel.textColor = .systemGreen
//        } else {
//            priceChangeDayLabel.textColor = .systemRed
//            priceChangeDayPercentLabel.textColor = .systemRed
//        }
//        priceChangeDayLabel.text = "\(viewModel.priceChangeDay) $"
//        priceChangeDayPercentLabel.text = "\(viewModel.priceChangePercentageDay) %"
//        lowPriceDayLabel.text = "\(viewModel.lowDayPrice) $"
//        highPriceDayLabel.text = "\(viewModel.highDayPrice) $"
    }
}
