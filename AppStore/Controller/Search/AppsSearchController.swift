//
//  AppsSearchController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 27.04.2023.
//

import UIKit
import SDWebImage

class AppsSearchController: BaseListController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate let cellID = "cell1234"
    fileprivate var appResults = [Result]()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = .white
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 250, left: 50, bottom: 0, right: 50))
//        fetchItunesApps()
        setupSearchBar()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appID = String(appResults[indexPath.item].trackId ?? .zero)
        let appDetailController = AppsDetailController(appID: appID)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        
    }
    
    var timer: Timer?
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            Service.shared.fetchApps(searchTerm: searchText) { res, error in
                if let error = error {
                    print("ERROR: \(error)")
                    return
                }
                self.appResults = res?.results ?? []
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
      
    }

    
    fileprivate func fetchItunesApps() {
        Service.shared.fetchApps(searchTerm: "twitter") { results, error in
            
            if let error = error {
                print("ERROR : \(error)")
                return
            }
            self.appResults = results?.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }

        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appResults.count != 0
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SearchResultCell
        cell.appResult = appResults[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return CGSize(width: view.frame.width, height: 300)
        return .init(width: view.frame.width, height: 350)
    }
    
}
