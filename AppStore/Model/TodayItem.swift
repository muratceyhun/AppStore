//
//  TodayItem.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 19.05.2023.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    // enum
    let cellType: CellType
    
//    var apps: [AppResult]
    
    enum CellType: String {
        case single, multiple
    }
}
