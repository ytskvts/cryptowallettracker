//
//  DetailCoinViewController.swift
//  project
//
//  Created by Dzmitry on 7.12.21.
//

import UIKit

class DetailCoinViewController: UIViewController {
    
    private var detailCoinView = DetailCoinView()

    
    override func loadView() {
        view = detailCoinView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    func configure(with viewModel: CoinTableViewCellViewModel) {
        detailCoinView.configureDetailVC(with: viewModel)
    }
}
