//
//  ItemServices.swift
//  Elmenus
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit

class ItemServices {
    typealias responseHandler = (Result<Items, ApiError>)->Void
    var tagName = ""

    func getAllItems(completion:@escaping responseHandler)
    {
        if checkConnectivity() {
            getItemsFromApi() { [weak self](result) in
                switch result {
                case .success(let response):
                    self?.saveItemEntity(itemList: response.items ?? [])
                default:break
                }
                completion(result)
            }
            
        }
        else
        {
            let itemList = self.getAllItemsFromDB()
            if itemList.count != 0 {
                let items = Items(items: itemList)
                completion(.success(items))
            }
            completion(.failure(ApiError.noConnetion))

        }
    }
    func getItemsFromApi(completion:@escaping responseHandler) {
        let apiClient = ApiClient(headers:["Content-Type":"application/json"], apiPath:.items(tagName))
        
        apiClient.genericFetch { (results) in
            completion(results)
        }
    }
    func checkConnectivity()->Bool {
        if Connectivity.isConnectedToInternet {
            return true
        }
        return false
    }
    func saveItemEntity(itemList:[Item])
    {
        DBManger.sharedInstance.setRealm()
        itemList.forEach { (item) in
            let itemEntity = ItemEntity(item: item, tagName: tagName)
            DBManger.sharedInstance.addItem(item: itemEntity)
        }
    }
    func getAllItemsFromDB()->[Item]
    {
        var itemsList:[Item] = []
        DBManger.sharedInstance.setRealm()
        DBManger.sharedInstance.getItems(tagName: tagName).forEach { (itemEntity) in
            itemsList.append(Item(itemEntity: itemEntity))
        }
        return itemsList
    }

}
