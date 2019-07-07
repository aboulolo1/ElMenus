//
//  HttpMethod.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import Foundation

enum HttpMethod {
    case get
    case post
    case delete
    case put
}

extension HttpMethod
{
    var method:String{
        switch self {
        case .get:
            return "Get"
        case .put:
            return "PUT"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        }
    }
}
