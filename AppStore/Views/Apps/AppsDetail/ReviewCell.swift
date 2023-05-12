//
//  ReviewCell.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 11.05.2023.
//

import UIKit


class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 20))
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    let starsLabel = UILabel(text: "Stars", font: .systemFont(ofSize: 14))
    let bodyLabel = UILabel(text: "Bla Bla Bla\nBla Bla Bla\nBla Bla Bla", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        layer.cornerRadius = 16
        
        let stackView = VerticalStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titleLabel, authorLabel], customSpacing: 8), starsLabel, bodyLabel], spacing: 12)
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        authorLabel.textAlignment = .right
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
