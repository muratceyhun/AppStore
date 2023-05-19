//
//  TodayCell.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 16.05.2023.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    var todayItems: TodayItem! {
        didSet {
            categoryLabel.text = todayItems.category
            imageView.image = todayItems.image
            titleLabel.text = todayItems.title
            descriptionLabel.text = todayItems.description
            backgroundColor = todayItems.backgroundColor
            
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 26))
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way.", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    var topConstraint: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.clipsToBounds = true
        imageView.centerInSuperview(size: .init(width: 250, height: 250))
        let stackView = VerticalStackView(arrangedSubviews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 8)
        addSubview(stackView)
//        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        topConstraint.isActive = true
        
        imageView.contentMode = .scaleAspectFill
        backgroundColor = .white
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
