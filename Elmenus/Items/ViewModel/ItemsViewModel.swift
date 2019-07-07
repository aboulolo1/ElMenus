//
//  ItemsViewModel.swift
//  Elmenus
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit

class ItemsViewModel: NSObject {
    var updateLoadingStatus:((Bool)->Void)?
    var finishFetchWithError:((String)->Void)?
    var finishFetchWithSuccess:(()->Void)?
    private var itemsList:[Item] = []

    private var isLoading:Bool = false{
        didSet{
            self.updateLoadingStatus?(self.isLoading)
        }
    }
    private var itemsServices:ItemServices
    
    init(itemsServices:ItemServices = ItemServices(),tagsName:String) {
        self.itemsServices = itemsServices
        self.itemsServices.tagName = tagsName
    }

    func fetchItems()  {
        if itemsList.count != 0 {
            return
        }
        self.isLoading = true
        itemsServices.getAllItems() { [weak self](result) in
            self?.isLoading = false
            switch result{
            case .success(let response):
                self?.itemsList = response.items ?? []
                self?.finishFetchWithSuccess?()
            case .failure(let err):
                self?.finishFetchWithError?(err.localizedDescritpion)
            }
        }
    }
    
    func getItemAtIndex(index:Int) -> Item {
        return itemsList[index]
    }
    
    func getItemsCount()->Int {
        return itemsList.count
    }

    
}
