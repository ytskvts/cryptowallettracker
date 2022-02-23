//
//  DetailCoinViewController.swift
//  project
//
//  Created by Dzmitry on 7.12.21.
//

import UIKit

class DetailCoinViewController: UIViewController, DetailCoinViewProtocol {
    
    var detailCoinViewPresenter: DetailCoinViewPresenterProtocol!
    
    //var detailCoinView = DetailCoinView()

    
    override func loadView() {
        //view = detailCoinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        detailCoinViewPresenter = DetailCoinViewPresenter(view: self)
    }
    

//    func configure(with viewModel: CoinTableViewCellViewModel) {
//        detailCoinView.configureDetailVC(with: viewModel)
//    }
    
    func setupView(detailCoinView: DetailCoinView) {
        view = detailCoinView
    }
}
