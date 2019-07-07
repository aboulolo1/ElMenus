//
//  TagsServices.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit

class TagsServices {
    
    typealias responseHandler = (Result<Tags, ApiError>)->Void
    var pageNum = 0
    
    init() {
    }
    
    func getAllTags(completion:@escaping responseHandler)
    {
        if checkConnectivity() {
            getDataFromApi() { [weak self](result) in
                switch result {
                case .success(let response):
                    self?.saveTagEntity(tagsList: response.tags ?? [])
                default:break
                }
                 completion(result)
            }
            
        }
        else
        {
            let tagList = self.getAllTagsFromDB()
            if tagList.count != 0 {
                let tags = Tags(tags: tagList)
                completion(.success(tags))
            }
            
            completion(.failure(ApiError.noConnetion))
        }
    }
    func checkConnectivity()->Bool {
        if Connectivity.isConnectedToInternet {
            return true
        }
        return false
    }
    func getDataFromApi(completion:@escaping responseHandler) {
       let apiClient = ApiClient(headers:["Content-Type":"application/json"], apiPath:.tags(pageNum))

        apiClient.genericFetch { (results) in
            completion(results)
        }
    }
    
    func saveTagEntity(tagsList:[Tag])
    {
        DBManger.sharedInstance.setRealm()
        tagsList.forEach { (tag) in
            let tagEntity = TagEntity(tag: tag, pageNum: pageNum)
            DBManger.sharedInstance.addTag(tag: tagEntity)
        }
    }
    func getAllTagsFromDB()->[Tag]
    {
        var tagsList:[Tag] = []
        DBManger.sharedInstance.setRealm()
        DBManger.sharedInstance.getTags(pageNum: pageNum).forEach { (tagEntity) in
            tagsList.append(Tag(tagEntity: tagEntity))
        }
        return tagsList
    }
}

