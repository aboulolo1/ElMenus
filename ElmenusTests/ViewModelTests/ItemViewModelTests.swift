//
//  ItemViewModelTests.swift
//  ElmenusTests
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import XCTest
import RealmSwift
@testable import Elmenus

class ItemViewModelTests: XCTestCase {
    var itemViewModel:ItemsViewModel?
    var itemService:MockItemServices?
    let jsonData = "{\"items\":[{\"description\": \"Deserts\",\"id\": 123,\"name\": \"Deserts\",\"photoURL\": \"https://s3-eu-west-1.amazonaws.com//elmenusv5/Normal/b2276d5d-27b7-11e8-add5-0242ac110011.jpg\"}]}".data(using: .utf8)
    
    let httpResponse = HTTPURLResponse(url: URL(string: "https://elmenus-assignment.getsandbox.com/items/6-Deserts")!, statusCode: 200, httpVersion: nil, headerFields: nil)

    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "DB"
        DBManger.sharedInstance.setRealm()
        itemService = MockItemServices()
    }
    
    override func tearDown() {
        try! DBManger.sharedInstance.realm.write {
            DBManger.sharedInstance.realm.deleteAll()
        }
    }
    func testFetchDataWithSuccess() {

        let mockUrlSession = MockURLSession(data: jsonData,urlResponse: httpResponse,err: nil)
        itemService?.mockUrlSession = mockUrlSession
        itemViewModel = ItemsViewModel(itemsServices: itemService!, tagsName: "Deserts")
        itemViewModel?.fetchItems()
        itemViewModel?.finishFetchWithSuccess = {[weak self]() in
            XCTAssertEqual(self?.itemViewModel?.getItemsCount(), 1)
        }
    }
    func testCachedDataAfterSuccess() {        
        let mockUrlSession = MockURLSession(data: jsonData,urlResponse: httpResponse,err: nil)
        itemService?.mockUrlSession = mockUrlSession
        itemViewModel = ItemsViewModel(itemsServices: itemService!, tagsName: "Deserts")
        itemViewModel?.fetchItems()
        itemViewModel?.finishFetchWithSuccess = {[weak self]() in
            XCTAssertEqual(DBManger.sharedInstance.getItems(tagName:(self?.itemService!.tagName)!).count, 1)
        }
    }
    func testFetchDataWithError() {
        let error = NSError(domain: "error", code: 1234, userInfo: nil)
        let mockUrlSession = MockURLSession(data: nil,urlResponse: nil,err: error)
        itemService?.mockUrlSession = mockUrlSession
        itemViewModel = ItemsViewModel(itemsServices: itemService!, tagsName: "Deserts")
        itemViewModel?.fetchItems()
        itemViewModel?.finishFetchWithError = {(err) in
            XCTAssertNotNil(err)
        }
    }
    func testOfflineData() {
        var itemList:[Item] = []
        var item = Item()
        item.name = "desert"
        item.photoUrl = "https://s3.amazonaws.com/elmenusV3/Photos/Normal/i4g2ehuqrvuw61or.jpg"
        itemList.append(item)
        itemService?.saveItemEntity(itemList: itemList)
        itemService?.isOffline = true
        itemViewModel?.fetchItems()
        itemViewModel?.finishFetchWithSuccess = {[weak self]() in
            XCTAssertEqual(self?.itemViewModel?.getItemAtIndex(index: 0).name, "desert")
        }
    }
}
