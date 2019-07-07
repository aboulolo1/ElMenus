//
//  MockTagServices.swift
//  ElmenusTests
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
@testable import Elmenus

class MockTagServices: TagsServices {

    var mockUrlSession:MockURLSession?
    var isOffline:Bool = false
    override func getDataFromApi(completion: @escaping TagsServices.responseHandler) {
        
        let apiClient = ApiClient(headers:["Content-Type":"application/json"],apiPath: .tags(1),urlSession:mockUrlSession!)

        apiClient.genericFetch { (results) in
            completion(results)
        }
    }
    override func checkConnectivity() -> Bool {
        return !isOffline
    }
}
