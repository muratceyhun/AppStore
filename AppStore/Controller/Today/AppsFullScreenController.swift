//
//  TodayFullController.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 16.05.2023.
//

import UIKit

class AppsFullScreenController: UITableViewController {
    
    var dismissHandler: (() -> ())?
    
    var todayItems: TodayItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = AppFullscreenHeaderCell()
            headerCell.closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            headerCell.todayCell.todayItems = todayItems
            return headerCell
        } else {
            let cell = AppsFulscreenDescriptionCell(style: .default, reuseIdentifier: nil)
            return cell
        }
    }

    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 450
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
        
        
    }
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let header = TodayCell()
    //        return header
    //    }
    //
    //    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return 450
    //    }
}
