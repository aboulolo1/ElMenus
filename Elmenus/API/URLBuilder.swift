//
//  URLBuilder.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit

class URLBuilder {

    private var component:URLComponents
    init() {
        self.component = URLComponents()
    }
    func set(scheme:String) -> URLBuilder {
        self.component.scheme = scheme
        return self
    }
    func set(host:String) -> URLBuilder {
        self.component.host = host
        return self
    }
    func set(apiPath:ApiPath) -> URLBuilder {
        var path = apiPath.path
        if !path.hasPrefix("/") {
            path = "/" + path
        }
        self.component.path = path
        return self
    }
    func addQueryParam(params: [String:String]? ) -> URLBuilder {
        params?.forEach{
            if self.component.queryItems == nil
            {
                self.component.queryItems = []
            }
            self.component.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))

        }
        return self
    }
    func build() -> URL? {
        return self.component.url
    }
    
}
