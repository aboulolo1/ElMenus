//
//  File.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import Foundation

enum ApiPath {
    case tags(Int)
    case items(String)
}
extension ApiPath{
    var path:String{
        switch self {
        case .tags(let page):
            return "/tags/\(page)"
        case .items(let tagName):
            return "/items/\(tagName)"
        }
    }
}
