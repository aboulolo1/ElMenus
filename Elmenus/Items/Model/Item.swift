//
//  Item.swift
//  Elmenus
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import Foundation
struct Item:Codable {

    var id : Int?
    var name : String?
    var photoUrl : String?
    var description : String?

    init(itemEntity:ItemEntity) {
        self.photoUrl = itemEntity.photoUrl
        self.name = itemEntity.name
        self.id = itemEntity.id
        self.description = itemEntity.itemDescription

    }
    init() {
        
    }
}
