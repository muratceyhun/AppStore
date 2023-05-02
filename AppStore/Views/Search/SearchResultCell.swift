//
//  SearchResultCell.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 27.04.2023.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    var appResult: Result! {
        didSet {
            nameLabel.text = appResult.trackName
            categoryLabel.text = appResult.primaryGenreName
            ratingsLabel.text = "Rating: \(appResult.averageUserRating ?? .zero)"
            let urlAppIcon = URL(string: appResult.artworkUrl100 ?? "")
            appIconImageView.sd_setImage(with: urlAppIcon)
            
            if appResult.screenshotUrls.count > 0 {
                let urlScreenShots1 = URL(string: appResult.screenshotUrls[0] )
                screenShot1ImageView.sd_setImage(with: urlScreenShots1)
            }
            
            if appResult.screenshotUrls.count > 1 {
                let urlScreenShots2 = URL(string: appResult.screenshotUrls[1] )
                screenShot2ImageView.sd_setImage(with: urlScreenShots2)
            }
            
            if appResult.screenshotUrls.count > 2 {
                 let urlScreenShots3 = URL(string: appResult.screenshotUrls[2] )
                 screenShot3ImageView.sd_setImage(with: urlScreenShots3)
            }
            
        
        }
    }
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photo & Video"
        return label
    }()
    
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var screenShot1ImageView = self.crateScreenShotImageView()
    lazy var screenShot2ImageView = self.crateScreenShotImageView()
    lazy var screenShot3ImageView = self.crateScreenShotImageView()

    
    
    func crateScreenShotImageView() -> UIImageView{
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.6
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        
//        let labelsStackView = UIStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
//        labelsStackView.axis = .vertical
        let labelsStackView = VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingsLabel])
        let infoTopStackView = UIStackView(arrangedSubviews: [appIconImageView, labelsStackView, getButton])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenShotsView = UIStackView(arrangedSubviews: [screenShot1ImageView, screenShot2ImageView, screenShot3ImageView])
        screenShotsView.axis = .horizontal
        screenShotsView.spacing = 12
        screenShotsView.distribution = .fillEqually
        
//        let overallStackView = UIStackView(arrangedSubviews: [infoTopStackView, screenShotsView])
//        overallStackView.axis = .vertical
        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screenShotsView], spacing: 16)
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
