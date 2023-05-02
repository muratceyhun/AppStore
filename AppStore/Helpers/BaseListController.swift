//
//  BaseListController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 1.05.2023.
//

import UIKit

class BaseListController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
