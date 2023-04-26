//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 27.04.2023.
//

import UIKit

class AppsSearchController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
