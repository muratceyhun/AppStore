//
//  AppsHeaderCell.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 3.05.2023.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let companyName = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
    let imageView = UIImageView(cornerRadius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        companyName.textColor = .blue
        imageView.backgroundColor = .purple
        titleLabel.numberOfLines = 2
        let stackView = VerticalStackView(arrangedSubviews: [companyName, titleLabel, imageView])
        stackView.spacing = 12
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
