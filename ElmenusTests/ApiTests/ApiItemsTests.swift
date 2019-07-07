//
//  ApiItemsTests.swift
//  ElmenusTests
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import XCTest
@testable import Elmenus

class ApiItemsTests: XCTestCase {
    typealias responseHandler = (Result<Items, ApiError>)->Void
    var jsonData = "{\"items\":[{\"description\": \"Deserts\",\"id\": 123,\"name\": \"Deserts\",\"photoURL\": \"https://s3-eu-west-1.amazonaws.com//elmenusv5/Normal/b2276d5d-27b7-11e8-add5-0242ac110011.jpg\"}]}".data(using: .utf8)
    
    let httpResponse = HTTPURLResponse(url: URL(string: "https://elmenus-assignment.getsandbox.com/items/6-Deserts")!, statusCode: 200, httpVersion: nil, headerFields: nil)

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetTagsWithExpectedURLHostAndPath() {
        let mockUrlSession = MockURLSession(data: nil,urlResponse: nil,err: nil)
        let apiClient = ApiClient(headers:["Content-Type":"application/json"],apiPath: .items("6 - Deserts"),urlSession:mockUrlSession)
        callingApi(apiClient: apiClient) { (result) in
            
        }
        XCTAssertEqual(mockUrlSession.cachedUrl?.host, "elmenus-assignment.getsandbox.com")
        XCTAssertEqual(mockUrlSession.cachedUrl?.path, "/items/6 - Deserts")
        
    }
    func testGetTagsSuccessReturnsTags() {
        
        let mockUrlSession = MockURLSession(data: jsonData,urlResponse: httpResponse,err: nil)
        
        let apiClient = ApiClient(headers:["Content-Type":"application/json"],apiPath: .tags(1),urlSession:mockUrlSession)
        
        var items:[Item]?
        let tagsExpectation = expectation(description: "tags")
        callingApi(apiClient: apiClient) { (result) in
            switch result{
            case .success(let model):
                items = model.items
                tagsExpectation.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 10) { (err) in
            XCTAssertNotNil(items)
        }
        
    }
    func testGetTagsWhenResponseErrorReturnsError() {
        
        let error = NSError(domain: "error", code: 1234, userInfo: nil)
        let mockUrlSession = MockURLSession(data: nil,urlResponse: nil,err: error)
        let apiClient = ApiClient(headers:["Content-Type":"application/json"],apiPath: .tags(1),urlSession:mockUrlSession)
        
        let errorExpectation = expectation(description: "error")
        var errorResponse: ApiError?
        callingApi(apiClient: apiClient) { (result) in
            switch result{
            case .failure(let err):
                errorResponse = err
                errorExpectation.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }
    func testGetTagsInvalidJSONReturnsError() {
         jsonData = "[{\"t\"}]".data(using: .utf8)
        
        
        let mockUrlSession = MockURLSession(data: jsonData,urlResponse: httpResponse,err: nil)
        
        let apiClient = ApiClient(headers:["Content-Type":"application/json"],apiPath: .tags(1),urlSession:mockUrlSession)
        let errorExpectation = expectation(description: "error")
        var errorResponse: ApiError?
        callingApi(apiClient: apiClient) { (result) in
            switch result{
            case .failure(let err):
                errorResponse = err
                errorExpectation.fulfill()
            default:
                break
            }
        }
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(errorResponse)
        }
    }
    func callingApi(apiClient:ApiClient,completion:@escaping responseHandler)  {
        apiClient.genericFetch { (result) in
            completion(result)
        }
        
    }

}
