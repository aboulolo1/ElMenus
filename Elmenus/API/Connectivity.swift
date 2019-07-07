//
//  File.swift
//  Elmenus
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import Foundation
import Alamofire

 class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
