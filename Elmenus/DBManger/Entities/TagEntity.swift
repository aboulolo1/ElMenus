//
//  TagsDB.swift
//  Elmenus
//
//  Created by New  on 7/6/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import RealmSwift
class TagEntity: Object {
    
    @objc dynamic var tagName = ""
    @objc dynamic var photoURL = ""
    @objc dynamic var pageNum = 0

    override static func primaryKey() -> String
    {
        return "tagName"
    }
}
extension TagEntity{
    convenience init(tag:Tag,pageNum:Int) {
        self.init()
        self.tagName = tag.tagName ?? ""
        self.photoURL = tag.photoURL ?? ""
        self.pageNum = pageNum
    }
}
