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
    //lazy var detailCoinViewPresenter = DetailCoinViewPresenter(view: self)
    
//    //var detailCoinView = DetailCoinView()
//
//
//    override func loadView() {
//        //view = detailCoinView
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let controller = UIHostingController(rootView: detailCoinViewPresenter?.getChartView())
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(controller)
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            controller.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            controller.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            controller.view.heightAnchor.constraint(equalToConstant: 200)
        ])
        //detailCoinViewPresenter = DetailCoinViewPresenter(view: self)
    }
    

//    func configure(with viewModel: CoinTableViewCellViewModel) {
//        detailCoinView.configureDetailVC(with: viewModel)
//    }
    
    
    func setupView(detailCoinView: DetailCoinView) {
        view = detailCoinView
    }
    

    
 
}
