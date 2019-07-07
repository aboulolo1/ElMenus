//
//  TgesMangesDB.swift
//  Elmenus
//
//  Created by New  on 7/6/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import RealmSwift

class DBManger {
    
    static let sharedInstance = DBManger()
    var realm : Realm!
    
    private init() {
    }
    
    func setRealm(realm:Realm = try! Realm())
    {
        self.realm = realm
    }
     func addTag(tag:TagEntity)
    {
        
        try! realm.write {
            realm.add(tag, update: .all)
        }
    }
     func getTags(pageNum:Int)->[TagEntity]
    {

        let tagsDB = realm.objects(TagEntity.self).filter("pageNum = \(pageNum)")
        var tagsDBList : [TagEntity] = []
        tagsDB.forEach { (obj) in
            tagsDBList.append(obj)
        }
        return tagsDBList
    }
    
    func addItem(item:ItemEntity)  {
        try! realm.write {
            realm.add(item, update: .all)
        }
    }
    func getItems(tagName:String)->[ItemEntity]
    {
        
        let itemsDB = realm.objects(ItemEntity.self).filter("tagName == %@",tagName)
        var itemsDBList : [ItemEntity] = []
        itemsDB.forEach { (obj) in
            itemsDBList.append(obj)
        }
        return itemsDBList
    }
}
