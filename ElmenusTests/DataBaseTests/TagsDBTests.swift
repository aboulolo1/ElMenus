//
//  TagsDBTests.swift
//  ElmenusTests
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import Realm
import RealmSwift
import XCTest
@testable import Elmenus
@testable import Pods_Elmenus

class TagsDBTests: XCTestCase {
    var tag = Tag()
    var item = Item()

    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "Test_DB"
        DBManger.sharedInstance.setRealm()
        tag.tagName = "desert"
        tag.photoURL = "https://s3.amazonaws.com/elmenusV3/Photos/Normal/i4g2ehuqrvuw61or.jpg"
        item.description = "Custom premium cut by farm frites. Add melted cheese for 7LE"
        item.name = "6 - Deserts -  French Fries"
        item.id = 122

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try! DBManger.sharedInstance.realm.write {
            DBManger.sharedInstance.realm.deleteAll()
        }
    }
    
    func testAddTag()  {
        DBManger.sharedInstance.addTag(tag: TagEntity(tag: tag, pageNum: 1))
        XCTAssertEqual(DBManger.sharedInstance.getTags(pageNum: 1).count,1 )
    }
    func testFetchTag()  {
        DBManger.sharedInstance.addTag(tag: TagEntity(tag: tag, pageNum: 1))
        let tagEntity = DBManger.sharedInstance.getTags(pageNum: 1)
        let tagssss = Tag(tagEntity: tagEntity[0])
        XCTAssertEqual(tagssss.tagName,"desert")
    }
    func testEmptyTags()
    {
        let tagEntity = DBManger.sharedInstance.getTags(pageNum: 1)
        XCTAssertEqual(tagEntity.count,0)
    }
    
    func testAddItem()  {
        DBManger.sharedInstance.addItem(item: ItemEntity(item: item, tagName: "Deserts"))
        XCTAssertEqual(DBManger.sharedInstance.getItems(tagName: "Deserts").count,1 )
    }
    func testFetchItem()  {
        DBManger.sharedInstance.addItem(item: ItemEntity(item: item, tagName: "Deserts"))
        let itemEntity = DBManger.sharedInstance.getItems(tagName: "Deserts")
        let items = Item(itemEntity: itemEntity[0])
        XCTAssertEqual(items.id,122)
    }
    func testEmptyItem()
    {
        let itemEntity = DBManger.sharedInstance.getItems(tagName: "Desertsdddd")
        XCTAssertEqual(itemEntity.count,0)
    }
}
