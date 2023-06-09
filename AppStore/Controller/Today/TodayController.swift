//
//  TodayController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 16.05.2023.
//

import UIKit

class TodayController: BaseListController,UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellID = "cellID"
    fileprivate let multipleCellID = "multipleCellID"
//        var items = [TodayItem.init(category: "LIFE HACK", title: "Test-Drive These CarPlay Apps",
//                                    image: UIImage(named: "garden")!,
//                                    description: "All the tools and apps you need to intelligently organize your life the right way.",
//                                    backgroundColor: .white, cellType: .single),
//                     TodayItem.init(category: "SECOND CELL", title: "Test-Drive These CarPlay Apps",
//                                                 image: UIImage(named: "garden")!,
//                                                 description: "All the tools and apps you need to intelligently organize your life the right way.",
//                                                 backgroundColor: .white, cellType: .multiple),
//                     TodayItem.init(category: "HOLIDAYS", title: "Utilizing your time",
//                                    image: UIImage(named: "holiday")!,
//                                    description: "All the tools and apps you need to intelligently organize your life the right way.",
//                                    backgroundColor: #colorLiteral(red: 0.9847376943, green: 0.9599434733, blue: 0.7276356816, alpha: 1), cellType: .single),
//                     TodayItem.init(category: "MULTIPLE CELL", title: "Travel on a budget",
//                                    image: UIImage(named: "holiday")!,
//                                    description: "Find out all you need to know on how to travel without packing everything!",
//                                    backgroundColor: #colorLiteral(red: 0.9838810563, green: 0.9640342593, blue: 0.7226806879, alpha: 1), cellType: .multiple)]
    
    var items = [TodayItem]()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9490196109, green: 0.9490197301, blue: 0.9490196109, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMultipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        navigationController?.isNavigationBarHidden = true
        view.addSubview(activityIndicatorView)
        activityIndicatorView.centerInSuperview()
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        let dispatchGroup = DispatchGroup()
        
        var topMusicAlbums: AppGroup?
        var topPodcasts: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchTopMusicAlbums { appGroups, error in
            topMusicAlbums = appGroups
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopPodcasts { appGroups, error in
            topPodcasts = appGroups
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            print("Finished Fetching...")
            self.items = [
                TodayItem.init(category: "Daily List", title: topMusicAlbums?.feed.title ?? "", image: UIImage(named: "garden")!, description: "", backgroundColor:  .white, cellType: .multiple, apps: topMusicAlbums?.feed.results ?? []),
                TodayItem.init(category: "LIFE HACK", title: "Test-Drive These CarPlay Apps", image: UIImage(named: "garden")!, description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
                TodayItem.init(category: "Daily List", title: topPodcasts?.feed.title ?? "", image: UIImage(named: "garden")!, description: "", backgroundColor:  .white, cellType: .multiple, apps: topPodcasts?.feed.results ?? []),
                TodayItem.init(category: "HOLIDAYS", title: "Utilizing your time",
                               image: UIImage(named: "holiday")!,
                               description: "All the tools and apps you need to intelligently organize your life the right way.",
                               backgroundColor: #colorLiteral(red: 0.9847376943, green: 0.9599434733, blue: 0.7276356816, alpha: 1), cellType: .single, apps: [])
            ]
            self.collectionView.reloadData()
            
        }
    }
    
    var appsFullscreenController = AppsFullScreenController()
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        if items[indexPath.item].cellType == .multiple {
//            let vc = TodayMultipleAppController(mode: .fullscreen)
//            vc.appItems = self.items[indexPath.item].apps
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true)
//            return
//        }
        
        if items[indexPath.item].cellType == .multiple {
          let fullController = TodayMultipleAppController(mode: .fullscreen)
          let fullscreenNavigationController = UINavigationController(rootViewController: fullController)
            fullController.appItems = items[indexPath.item].apps
          fullscreenNavigationController.modalPresentationStyle = .fullScreen
          navigationController?.present(fullscreenNavigationController, animated: true)
            return
        }
        
        let appFullscreenController = AppsFullScreenController()
        appFullscreenController.todayItems = items[indexPath.item]
        appFullscreenController.dismissHandler = {
            self.handleRemoveDummyView()
        }
        guard let fullscreenView =  appFullscreenController.view else {return}
        fullscreenView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveDummyView)))
        fullscreenView.layer.cornerRadius = 16
        
        view.addSubview(fullscreenView)
        addChild(appFullscreenController)
        self.appsFullscreenController = appFullscreenController
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        self.startingFrame = startingFrame
        
        fullscreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
        //        dummyView.frame = startingFrame
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.widthConstraint?.constant = self.view.frame.width
            self.heightConstraint?.constant = self.view.frame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            self.tabBarController?.tabBar.isHidden = true
            
            guard let cell = appFullscreenController.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else {return}
            cell.todayCell.topConstraint.constant = 64
            cell.layoutIfNeeded()
        }
    }
    
    var startingFrame: CGRect?
    
    @objc fileprivate func handleRemoveDummyView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, animations: {
            self.appsFullscreenController.tableView.scrollRectToVisible(.zero, animated: true)
            //            gesture.view?.frame = self.startingFrame ?? .zero
            guard let startingFrame = self.startingFrame else {return}
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.isHidden = false
            guard let cell = self.appsFullscreenController.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else {return}
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
            
        }) { _ in
            self.appsFullscreenController.removeFromParent()
            self.appsFullscreenController.view.removeFromSuperview()
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellID = items[indexPath.item].cellType.rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! BaseTodayCell
        cell.todayItems = items[indexPath.item]
      
        (cell as? TodayMultipleAppCell)?.multipleAppController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HandleMultipleAppsTap)))
        return cell

    }
    
    @objc fileprivate func HandleMultipleAppsTap(gesture: UIGestureRecognizer) {
        
        let collectionView = gesture.view
        
        var superview = collectionView?.superview
        
        
        while superview != nil {
            
            if let cell = superview as? TodayMultipleAppCell {
                
                guard let indexPath = self.collectionView.indexPath(for: cell) else {return}
                let apps = self.items[indexPath.item].apps
                
                let fullController = TodayMultipleAppController(mode: .fullscreen)
                fullController.appItems = apps
                let navController = UINavigationController(rootViewController: fullController)
                navController.modalPresentationStyle = .fullScreen
                navigationController?.present(navController, animated: true)
            }
            superview = superview?.superview
        }
  
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.frame.width-64, height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 32, left: 0, bottom: 32, right: 0)
    }
}
