//
//  PreviewCell.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 11.05.2023.
//

import UIKit

class PreviewCell: UICollectionViewCell {
    
    
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 20))
    let horizontalVC = PreviewScreenshotsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(previewLabel)
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        addSubview(horizontalVC.view)
        horizontalVC.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } 
}
