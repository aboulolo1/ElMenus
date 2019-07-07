//
//  RequestBuilder.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit

class RequestBuilder {
    
    private var request : URLRequest
    init(url:URL?) {
        self.request = URLRequest(url:url!)
    }
    func set(headers:[String:String]?) -> RequestBuilder {
        headers?.forEach{
            self.request.setValue($0.value, forHTTPHeaderField: $0.key)
        }
        return self
    }
    
    func set(httpMethod:HttpMethod) -> RequestBuilder {
        self.request.httpMethod = httpMethod.method
        return self
    }
    func setBody(body:[String:Any]?) -> RequestBuilder {
        guard let bodyDic = body else {
            return self
        }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: bodyDic, options: []) else {
            return self
        }
        self.request.httpBody = httpBody
        return self

    }
    func build() -> URLRequest {
        return self.request
    }
    
    
}
