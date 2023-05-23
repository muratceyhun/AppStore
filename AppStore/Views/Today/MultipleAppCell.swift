//
//  MultipleAppCell.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 23.05.2023.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 16))
    let companyName = UILabel(text: "Company Name", font: .boldSystemFont(ofSize: 12))
    
    let getButton = UIButton(title: "GET")
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.3)
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        imageView.backgroundColor = .black
        //        imageView.widthAnchor.constraint(equalToConstant: 64).isActive = true
        //        imageView.heightAnchor.constraint(equalToConstant: 64).isActive = true
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        imageView.layer.borderWidth = 0.8
        imageView.layer.borderColor = UIColor(white: 0.6, alpha: 0.6).cgColor
        let stackView = UIStackView(arrangedSubviews: [imageView,VerticalStackView(arrangedSubviews: [nameLabel, companyName], spacing: 4), getButton])
        stackView.spacing = 16
        stackView.alignment = .center
        getButton.backgroundColor = UIColor(white: 0.8, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 16
        addSubview(stackView)
        stackView.fillSuperview()
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -5, right: 0), size: .init(width: 0 , height: 0.5))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
