//
//  AppsController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 1.05.2023.
//

import UIKit

class AppsPageController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let cellID = "id"
    let headerID = "headerID"
    
    var groups = [AppGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.register(AppsPageheader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?

        
        let dispatchGroup = DispatchGroup()
        
//        dispatchGroup.enter()
//        dispatchGroup.leave()
    
        
        dispatchGroup.enter()
        Service.shared.fetchTopFreeApps { appGroup, error in
            
            dispatchGroup.leave()
            print("TopFreeApp")
            if let error = error {
                print("ERROR: \(error)")
            }
            group1 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopMusicAlbums { appGroup, error in
            dispatchGroup.leave()
            print("TopMusic")
            if let error = error {
                print("ERROR: \(error)")
            }
            group2 = appGroup
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopPodcasts { appGroup, error in
            dispatchGroup.leave()
            print("TopPodcast")
            if let error = error {
                print("ERROR: \(error)")
            }
            group3 = appGroup
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Completed Dispatch Group Task...")
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            if let group = group3 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        .init(width: collectionView.frame.width, height: 0)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppsGroupCell
        let appGroup = groups[indexPath.item]
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalVC.topFreeAppsItems = appGroup
        cell.horizontalVC.collectionView.reloadData()
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width, height: 300)
    }
    
}
