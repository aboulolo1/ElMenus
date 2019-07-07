//
//  TagsViewModel.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit

class TagsViewModel {
    
    var updateLoadingStatus:((Bool)->Void)?
    var finishFetchWithError:((String)->Void)?
    var finishFetchWithSuccess:(()->Void)?
    private var tagsList:[Tag] = []
    var pageNum = 1{
        didSet{
            self.tagsServices.pageNum = self.pageNum
        }
    }
    private var tagsServices:TagsServices
    
    init(tagsServices:TagsServices = TagsServices()) {
        self.tagsServices = tagsServices
        self.tagsServices.pageNum = self.pageNum
    }
    
    private var isLoading:Bool = false{
        didSet{
            self.updateLoadingStatus?(self.isLoading)
        }
    }
    
     func fetchTags()  {
        if pageNum == 1 {
            self.isLoading = true
        }
        tagsServices.getAllTags() { [weak self](result) in
            self?.isLoading = false
            switch result{
            case .success(let tagsObj):
                self?.tagsList.append(contentsOf:tagsObj.tags ?? [])
                self?.pageNum += 1
                self?.finishFetchWithSuccess?()
            case .failure(let err):
                self?.finishFetchWithError?(err.localizedDescritpion)
            }
        }
    }
    
    func getTagAtIndex(index:Int) -> Tag {
        return tagsList[index]
    }
    
    func getTagsCount()->Int {
        return tagsList.count
    }
}
