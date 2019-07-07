//
//  MockTask.swift
//  ElmenusTests
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit

class MockTask: URLSessionDataTask {

    private let data:Data?
    private let urlResponse:URLResponse?
    private let err:Error?
    
    var completionHander:((Data?,URLResponse?,Error?)->Void)?
    
     init(data:Data?,urlResponse:URLResponse?,err:Error?) {
        self.data = data
        self.urlResponse = urlResponse
        self.err = err
    }
    
    override func resume() {
        DispatchQueue.main.async {
            self.completionHander?(self.data, self.urlResponse, self.err)
        }

    }
}
