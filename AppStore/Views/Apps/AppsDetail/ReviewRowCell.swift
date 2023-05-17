//
//  AppReviewCell.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 11.05.2023.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    let reviewController = ReviewController()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(reviewController.view)
        reviewController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
