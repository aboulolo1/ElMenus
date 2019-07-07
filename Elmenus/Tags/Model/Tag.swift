//
//  Tag.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit

struct Tag:Codable {
    var photoURL : String?
    var tagName : String? 
    init(tagEntity:TagEntity) {
        self.photoURL = tagEntity.photoURL
        self.tagName = tagEntity.tagName
    }
    init() {
        
    }
}
