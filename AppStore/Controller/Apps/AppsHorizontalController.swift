//
//  AppsHorizontalController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 1.05.2023.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "Id"
    var topFreeAppsItems: AppGroup?
    
    var didSelectHandler : ((AppResult?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellID)
//        collectionView.isPagingEnabled = true
//        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
//            layout.scrollDirection = .horizontal
//        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let app = topFreeAppsItems?.feed.results[indexPath.item]
//        print(app?.name ?? "")
        if let app = app {
            didSelectHandler?(app)
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topFreeAppsItems?.feed.results.count ?? .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppRowCell
        let topFreeAppsItem = topFreeAppsItems?.feed.results[indexPath.item]
        cell.nameLabel.text = topFreeAppsItem?.name
        cell.companyName.text = topFreeAppsItem?.artistName
        cell.imageView.sd_setImage(with: URL(string: topFreeAppsItem?.artworkUrl100 ?? ""))
        return cell
    }
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2*topBottomPadding - 2*lineSpacing)/3
        return .init(width: collectionView.frame.width-48, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topBottomPadding, left: 16, bottom: topBottomPadding, right: 16)
    }

}
