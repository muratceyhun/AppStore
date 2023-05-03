//
//  AppsPageHeader.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 3.05.2023.
//

import UIKit

class AppsPageheader: UICollectionReusableView {
    
    let appHeaderHorizontalController = AppsHeaderHorizontalController()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(appHeaderHorizontalController.view)
        appHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
