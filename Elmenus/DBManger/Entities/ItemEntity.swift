//
//  ItemEntity.swift
//  Elmenus
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import RealmSwift

class ItemEntity: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photoUrl = ""
    @objc dynamic var itemDescription = ""
    @objc dynamic var tagName = ""

    override static func primaryKey() -> String
    {
        return "name"
    }
}
extension ItemEntity{
    convenience init(item:Item,tagName:String) {
        self.init()
        self.id = item.id ?? 0
        self.photoUrl = item.photoUrl ?? ""
        self.itemDescription = item.description ?? ""
        self.tagName = tagName
        self.name = item.name ?? ""
    }
}
