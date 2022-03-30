//
//  PieChartViewController.swift
//  project
//
//  Created by Dmitry on 23.03.22.
//

import UIKit
import Charts

class PieChartViewController: UIViewController, PieChartViewProtocol {

    var pieChartViewPresenter: PieChartViewPresenterProtocol?
    
    var chartDataEntries = [PieChartDataEntry]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        pieChartViewPresenter = PieChartViewPresenter(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var pieChart = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        pieChart.holeColor = .systemBackground
        pieChart.delegate = self
        pieChart.chartDescription.text = "Portfolio"
        //pieChart.chartDescription.textAlign = .center
        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pieChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.width)
        pieChart.center = view.center
        view.addSubview(pieChart)
    }
    
    
    func configure(data: [WalletTableViewCellModel]) {
        pieChartViewPresenter?.setData(data: data)
    }
    
    func updateChartData(totalCost: String) {
        let attString = NSMutableAttributedString(string: totalCost)
        attString.addAttribute(.font, value: NSUIFont.systemFont(ofSize: 16.0), range: NSMakeRange(0, attString.length))
        pieChart.centerAttributedText = attString
        
        let chartDataSet = PieChartDataSet(entries: chartDataEntries)
        chartDataSet.colors = ChartColorTemplates.colorful()
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChart.data = chartData
    }
    
    func addChartDataEntry(cost: Double, symbol: String) {
        let chartDataEntry = PieChartDataEntry(value: cost, label: symbol)
//        chartDataEntry.value = cost
//        chartDataEntry.label = symbol
        chartDataEntries.append(chartDataEntry)
        
    }

}


extension PieChartViewController: ChartViewDelegate {
    
}
