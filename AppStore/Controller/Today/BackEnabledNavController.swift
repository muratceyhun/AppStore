//
//  BackEnabledNavController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 31.05.2023.
//

import UIKit

class BackEnabledNavController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
