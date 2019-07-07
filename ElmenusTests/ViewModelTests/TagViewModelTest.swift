//
//  TagViewModelTest.swift
//  ElmenusTests
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import XCTest
import RealmSwift

@testable import Elmenus

class TagViewModelTest: XCTestCase {
    
    var tagViewModel:TagsViewModel?
    var tagService:MockTagServices?
    let jsonData = "{\"tags\":[{\"tagName\": \"Deserts\",\"photoURL\": \"https://s3-eu-west-1.amazonaws.com//elmenusv5/Normal/b2276d5d-27b7-11e8-add5-0242ac110011.jpg\"}]}".data(using: .utf8)
    let httpResponse = HTTPURLResponse(url: URL(string: "https://elmenus-assignment.getsandbox.com/tags/1")!, statusCode: 200, httpVersion: nil, headerFields: nil)

    override func setUp() {
        Realm.Configuration.defaultConfiguration.inMemoryIdentifier = "Test_DB"
        DBManger.sharedInstance.setRealm()
        tagService = MockTagServices()
    }
    
    override func tearDown() {
        try! DBManger.sharedInstance.realm.write {
            DBManger.sharedInstance.realm.deleteAll()
        }
    }

    func testFetchDataWithSuccess() {
        let mockUrlSession = MockURLSession(data: jsonData,urlResponse: httpResponse,err: nil)
        tagService?.mockUrlSession = mockUrlSession
        tagViewModel = TagsViewModel(tagsServices: tagService!)
        tagViewModel?.fetchTags()
        tagViewModel?.finishFetchWithSuccess = {[weak self]() in
            XCTAssertEqual(self?.tagViewModel?.getTagsCount(), 1)
        }
    }
    func testCachedDataAfterSuccess() {
                
        let mockUrlSession = MockURLSession(data: jsonData,urlResponse: httpResponse,err: nil)
        tagService?.mockUrlSession = mockUrlSession
        tagViewModel = TagsViewModel(tagsServices: tagService!)
        tagViewModel?.fetchTags()
        tagViewModel?.finishFetchWithSuccess = {() in
            XCTAssertEqual(DBManger.sharedInstance.getTags(pageNum: 1).count, 1)
        }
    }
    func testFetchDataWithError() {
        let error = NSError(domain: "error", code: 1234, userInfo: nil)
        let mockUrlSession = MockURLSession(data: nil,urlResponse: nil,err: error)
        tagService?.mockUrlSession = mockUrlSession
        tagViewModel = TagsViewModel(tagsServices: tagService!)
        tagViewModel?.fetchTags()
        tagViewModel?.finishFetchWithError = {(err) in
            XCTAssertNotNil(err)
        }
    }
    func testOfflineData() {
        var tagsList:[Tag] = []
        var tag = Tag()
        tag.tagName = "desert"
        tag.photoURL = "https://s3.amazonaws.com/elmenusV3/Photos/Normal/i4g2ehuqrvuw61or.jpg"
        tagsList.append(tag)
        tagService?.saveTagEntity(tagsList: tagsList)
        tagService?.isOffline = true
        tagViewModel?.fetchTags()
        tagViewModel?.finishFetchWithSuccess = {[weak self]() in
            XCTAssertEqual(self?.tagViewModel?.getTagAtIndex(index: 0).tagName, "desert")
        }

        
    }
}
