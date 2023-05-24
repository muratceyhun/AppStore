//
//  TodayMultipleAppController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 23.05.2023.
//

import UIKit

class TodayMultipleAppController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var appItems = [AppResult]()
    
    fileprivate let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: cellID)
//        Service.shared.fetchTopPodcasts { appItems, error in
//            self.appItems = appItems?.feed.results ?? []
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//                self.collectionView.isScrollEnabled = false
//            }
//        }
    }
  

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, appItems.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MultipleAppCell
        cell.app = appItems[indexPath.item]
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
