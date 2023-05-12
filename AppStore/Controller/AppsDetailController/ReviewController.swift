//
//  ReviewController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 11.05.2023.
//

import UIKit


class ReviewController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "cellID"
    
    var reviewItems: Reviews?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviewItems?.feed.entry.count ?? .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ReviewCell
        let reviewItem = reviewItems?.feed.entry[indexPath.item]
        cell.titleLabel.text = reviewItem?.title.label
        cell.bodyLabel.text = reviewItem?.content.label
        cell.authorLabel.text = reviewItem?.author.name.label
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.width-48, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
