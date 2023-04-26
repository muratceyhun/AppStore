//
//  MainTabBarController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 26.04.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let redViewController = UIViewController()
        redViewController.view.backgroundColor = .red
        redViewController.tabBarItem.title = "RED"
        redViewController.navigationItem.title = "Apps"
        let redNavController = UINavigationController(rootViewController: redViewController)
        redNavController.tabBarItem.title = "RED NAV"
        redNavController.navigationBar.prefersLargeTitles = true

        let blueViewController = UIViewController()
        blueViewController.view.backgroundColor = .blue
        blueViewController.tabBarItem.title = "BLUE"
        blueViewController.navigationItem.title = "Search"
        let blueNavController = UINavigationController(rootViewController: blueViewController)
        blueNavController.tabBarItem.title = "BLUE NAV"
        blueNavController.navigationBar.prefersLargeTitles = true

        viewControllers = [redNavController,
                           blueNavController
        ]
        
    }
}
