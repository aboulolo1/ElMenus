//
//  TagsViewController.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftMessageBar

class TagsViewController: UIViewController {
    @IBOutlet weak var tagsTb: UITableView!
    private var tagsViewModel:TagsViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsViewModel = TagsViewModel()
        tagsTb.dataSource = self
        tagsTb.delegate = self
        tagsTb.infiniteScrollIndicatorStyle = .gray
        tagsTb.addInfiniteScroll { [weak self](tableView) -> Void in
            self?.tagsViewModel?.fetchTags()
        }
    }
    override func viewWillAppear(_ animated: Bool) {       
        updateLoading()
        updateTableViewWithTags()
        if tagsViewModel?.pageNum == 1 {
            tagsViewModel?.fetchTags()
        }
    }
    private func updateLoading() {
        
        tagsViewModel?.updateLoadingStatus = { (isLoading) in
            DispatchQueue.main.async {
                if isLoading {
                    SVProgressHUD.show()
                }else {
                    SVProgressHUD.dismiss()
                }
            }
        }
    }
    private func updateTableViewWithTags()
    {
        tagsViewModel?.finishFetchWithError = { [weak self](message) in
            DispatchQueue.main.async {
                SwiftMessageBar.showMessage(withTitle: "Error", message: message, type: .error)
                self?.tagsTb.finishInfiniteScroll()
            }
        }
        tagsViewModel?.finishFetchWithSuccess = { [weak self]() in
            DispatchQueue.main.async {
                self?.tagsTb.finishInfiniteScroll()
                self?.tagsTb.reloadData()
            }

        }
    }
    
}
extension TagsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (tagsViewModel?.getTagsCount())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tagsTb.dequeueReusableCell(withIdentifier: "tagCell") as! TagsTableViewCell
        if let tag =  tagsViewModel?.getTagAtIndex(index: indexPath.row){
            cell.updateView(tag: tag)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemsVC = self.storyboard?.instantiateViewController(withIdentifier: "itemsList") as! ItemsViewController
        if let tag =  tagsViewModel?.getTagAtIndex(index: indexPath.row){
            itemsVC.itemsViewModel = ItemsViewModel(tagsName: tag.tagName ?? "")
        }
        self.navigationController?.pushViewController(itemsVC, animated: true)
    }
}
