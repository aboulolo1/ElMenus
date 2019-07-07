//
//  ItemDetails.swift
//  Elmenus
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit

class ItemDetailsViewModel {

    private var itemDetails:Item?
    
    var photoUrl:String{
        get{
            return itemDetails?.photoUrl ?? ""
        }
    }
    
    var itemDescription:String{
        get{
            return itemDetails?.description ?? ""
        }
    }
    
    var itemName:String{
        get{
            return itemDetails?.name ?? ""
        }
    }
    
    init(itemDetails:Item) {
        self.itemDetails = itemDetails
    }
    
}
