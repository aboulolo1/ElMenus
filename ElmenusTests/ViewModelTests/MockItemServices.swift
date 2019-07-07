//
//  MockItemServices.swift
//  ElmenusTests
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
@testable import Elmenus

class MockItemServices: ItemServices {
    var mockUrlSession:MockURLSession?
    var isOffline:Bool = false

    override func getItemsFromApi(completion: @escaping ItemServices.responseHandler) {
        let apiClient = ApiClient(headers:["Content-Type":"application/json"],apiPath: .items(self.tagName),urlSession:mockUrlSession!)
        
        apiClient.genericFetch { (results) in
            completion(results)
        }

    }
    override func checkConnectivity() -> Bool {
        return !isOffline
    }
}
