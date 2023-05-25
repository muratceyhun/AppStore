//
//  TodayMultipleAppController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 23.05.2023.
//

import UIKit

class TodayMultipleAppController: BaseListController, UICollectionViewDelegateFlowLayout {
    
    var appItems = [AppResult]()
    
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "close_button"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    @objc func handleDismiss() {
        dismiss(animated: true)
        print("41412412142412")
    }
    
        
    
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
        
        if mode == .fullscreen {
            setupCloseButton()
        } else {
            collectionView.isScrollEnabled = false
        }
    }
     
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return .init(top: 12, left: 24, bottom: 12, right: 24)
        }
        return .zero
    }
    
    override var prefersStatusBarHidden: Bool {return true}
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 24), size: .init(width: 44, height: 44))
    }
  

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .small {
            return min(4, appItems.count)

        }
        return appItems.count
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
        let height: CGFloat = 74
        if mode == .fullscreen {
            return .init(width: collectionView.frame.width - 48 , height: height)

        }
        return .init(width: collectionView.frame.width, height: height)
    }
    
    
    fileprivate let mode: Mode
    
    enum Mode {
        case small, fullscreen
    }
    
    init(mode: Mode) {
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
