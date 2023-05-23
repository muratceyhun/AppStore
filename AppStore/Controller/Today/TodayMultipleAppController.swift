//
//  TodayMultipleAppController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 23.05.2023.
//

import UIKit

class TodayMultipleAppController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var appItems: AppGroup?
    
    fileprivate let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellID)
        Service.shared.fetchTopPodcasts { appItems, error in
            self.appItems = appItems
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.isScrollEnabled = false

            }
            
        }
    }
  

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, appItems?.feed.results.count ?? .zero)
//        return appItems?.feed.results.count ?? .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MultipleAppCell
        let appItem = appItems?.feed.results[indexPath.item]
        cell.nameLabel.text = appItem?.name
        cell.companyName.text = appItem?.artistName
        cell.imageView.sd_setImage(with: URL(string: appItem?.artworkUrl100 ?? ""))
        collectionView.reloadData()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        16
    }
    
    fileprivate let spacing : CGFloat = 16
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = ( collectionView.frame.height - 3 * spacing ) / 4
        return .init(width: collectionView.frame.width, height: height)
    }
    
    
    
}
