//
//  PieChartViewController.swift
//  project
//
//  Created by Dmitry on 23.03.22.
//

import UIKit

class PieChartViewController: UIViewController, PieChartViewProtocol {

    var pieChartViewPresenter: PieChartViewPresenterProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        pieChartViewPresenter = PieChartViewPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func configure(data: [WalletTableViewCellModel]) {
        pieChartViewPresenter?.setData(data: data)
    }

}
