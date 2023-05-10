//
//  Detail.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 9.05.2023.
//

import UIKit

class AppsDetailCell: UICollectionViewCell {
    
    let appIconImageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let priceButton = UIButton(title: "$4.99")
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    let relaseNotLabel = UILabel(text: "Description", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        appIconImageView.backgroundColor = .black
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
        priceButton.backgroundColor = .blue
        priceButton.tintColor = .white
        priceButton.constrainHeight(constant: 32)
        priceButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        priceButton.layer.cornerRadius = 16
        priceButton.constrainWidth(constant: 80)
        let stackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [appIconImageView, VerticalStackView(arrangedSubviews: [nameLabel, UIStackView(arrangedSubviews: [priceButton, UIView()])], spacing: 12)], customSpacing: 16), whatsNewLabel, relaseNotLabel], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
