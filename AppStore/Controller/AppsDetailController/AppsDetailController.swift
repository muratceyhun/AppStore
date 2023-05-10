//
//  AppsDetailController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 9.05.2023.
//

import UIKit

class AppsDetailController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    let detailCellID = "detailCellID"
    
    var items: SearchResult?
    
    var appID: String! {
        didSet {
            print("HERE is my appID: \(appID ?? "")")
            let urlString = "https://itunes.apple.com/lookup?id=\(appID ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (detailResult: SearchResult?, err) in
                //                print(detailResult?.results.first?.releaseNotes)
                self.items = detailResult
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppsDetailCell.self, forCellWithReuseIdentifier: detailCellID)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellID, for: indexPath) as! AppsDetailCell
        let item = items?.results[indexPath.item]
        cell.nameLabel.text = item?.trackName
        cell.priceButton.setTitle(item?.formattedPrice, for: .normal)
        cell.appIconImageView.sd_setImage(with: URL(string: item?.artworkUrl100 ?? ""))
        cell.relaseNotLabel.text = item?.releaseNotes
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // calculating the necessary size for the cell
        
        let dummyCell = AppsDetailCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 1000))
        dummyCell.relaseNotLabel.text = items?.results.first?.releaseNotes
        dummyCell.layoutIfNeeded()
        
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
      
        
        return .init(width: view.frame.width, height: estimatedSize.height)
        
    }
}
