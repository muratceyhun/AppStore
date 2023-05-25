//
//  TodayMultipleAppCell.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 21.05.2023.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    
    override var todayItems: TodayItem! {
        didSet {
            categoryLabel.text = todayItems.category
            titleLabel.text = todayItems.title
            
            multipleAppController.appItems = todayItems.apps
            multipleAppController.collectionView.reloadData()
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 26), numberOfLines: 3)
    let multipleAppController = TodayMultipleAppController(mode: .small)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        multipleAppController.view.layer.cornerRadius = 24
        backgroundColor = .white
        layer.cornerRadius = 16
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, multipleAppController.view], spacing: 8)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
