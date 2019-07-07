//
//  Result.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import Foundation

enum Result<T,U> where U:Error {
    case success(T)
    case failure(U)
}
