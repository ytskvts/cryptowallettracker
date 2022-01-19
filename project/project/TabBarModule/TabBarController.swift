//
//  TabBarController.swift
//  project
//
//  Created by Dzmitry on 4.01.22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        // Do any additional setup after loading the view.
    }
    
    func createNavController(vc: UIViewController, itemName: String, itemImage: String) -> UINavigationController {
        #warning("systemName work from 14 iOS")
        let item = UITabBarItem(title: itemName, image: UIImage(systemName: itemImage)?.withAlignmentRectInsets(.init(top: 10, left: 0, bottom: 0, right: 0)), tag: 0)
        item.titlePositionAdjustment = .init(horizontal: 0, vertical: 10)
        
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem = item
        return navController
    }
    
    func setupTabBar() {
        let walletViewController = createNavController(vc: WalletViewController(), itemName: "Wallet", itemImage: "bag")
        let settingsViewController = createNavController(vc: SettingsViewController(), itemName: "Settings", itemImage: "gearshape")
        let coinsListViewController = createNavController(vc: CoinsListViewController(), itemName: "Coins", itemImage: "bitcoinsign.circle")
        
        viewControllers = [coinsListViewController, walletViewController, settingsViewController]
        
    }


}
