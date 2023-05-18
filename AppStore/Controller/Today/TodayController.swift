//
//  TodayController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 16.05.2023.
//

import UIKit

class TodayController: BaseListController,UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellID = "cellID"
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = #colorLiteral(red: 0.9490196109, green: 0.9490197301, blue: 0.9490196109, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: cellID)
        navigationController?.isNavigationBarHidden = true
    }
    
    var appsFullscreenController = AppsFullScreenController()
    
    var topConstraint: NSLayoutConstraint?
    var leadingConstraint: NSLayoutConstraint?
    var widthConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = AppsFullScreenController()
        guard let dummyView =  VC.view else {return}
        dummyView.layer.cornerRadius = 16
        dummyView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleRemoveDummyView)))
        view.addSubview(dummyView)
        addChild(VC)
        self.appsFullscreenController = VC
        guard let cell = collectionView.cellForItem(at: indexPath) else {return}
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else {return}
        self.startingFrame = startingFrame
        
        dummyView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = dummyView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = dummyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = dummyView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = dummyView.heightAnchor.constraint(equalToConstant: startingFrame.height)
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
        }
    }
    
    var startingFrame: CGRect?
    
    @objc fileprivate func handleRemoveDummyView(gesture: UITapGestureRecognizer) {
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

        }) { _ in
            gesture.view?.removeFromSuperview()
            self.appsFullscreenController.removeFromParent()

        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TodayCell
        cell.layer.cornerRadius = 16
        return cell
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