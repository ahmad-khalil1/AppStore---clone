//
//  todayItemModel.swift
//  AppStore
//
//  Created by Ahmad Khalil on 7/16/20.
//  Copyright © 2020 ahmad. All rights reserved.
//

import UIKit

struct todayItem  {
    
    var itemTitle : String
    var itemImage : UIImage?
    var itemSubtitle : String
    var itemDescription : String
    var itemColor : UIColor
    var itemCellType : cellType?
    var itemAppGroup : [App]?
    
    
    enum cellType {
        case list
        case today
        case todayMovingIcon
    }
}
 
