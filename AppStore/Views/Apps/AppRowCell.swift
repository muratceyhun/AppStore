//
//  AppRowCell.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 1.05.2023.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)

    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 16))
    let companyName = UILabel(text: "Company Name", font: .boldSystemFont(ofSize: 12))
    
    let getButton = UIButton(title: "GET")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        imageView.backgroundColor = .black
//        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
//        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        let stackView = UIStackView(arrangedSubviews: [imageView,VerticalStackView(arrangedSubviews: [nameLabel, companyName], spacing: 4), getButton])
        stackView.spacing = 16
        stackView.alignment = .center
        getButton.backgroundColor = UIColor(white: 0.8, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 16
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
