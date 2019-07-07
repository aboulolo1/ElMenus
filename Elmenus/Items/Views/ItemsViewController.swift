//
//  ItemsViewController.swift
//  Elmenus
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import SVProgressHUD
import SCLAlertView
import SwiftMessageBar

class ItemsViewController: UIViewController {

    @IBOutlet weak var itemsTB: UITableView!
     var itemsViewModel:ItemsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        itemsTB.dataSource = self
        itemsTB.delegate = self
        itemsTB.tableFooterView = UIView()

    }
    override func viewWillAppear(_ animated: Bool) {
        updateLoading()
        updateTableViewWithTags()
        itemsViewModel?.fetchItems()
    }

    private func updateLoading() {
        
        itemsViewModel?.updateLoadingStatus = { (isLoading) in
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
        itemsViewModel?.finishFetchWithError = { (message) in
            DispatchQueue.main.async {
                SwiftMessageBar.showMessage(withTitle: "Error", message: message, type: .error)
            }
        }
        itemsViewModel?.finishFetchWithSuccess = { [weak self]() in
            DispatchQueue.main.async {
                self?.itemsTB.reloadData()
            }
            
        }
    }

}
extension ItemsViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (itemsViewModel?.getItemsCount())!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemsTB.dequeueReusableCell(withIdentifier: "itemCell") as! ItemTableViewCell
        if let item =  itemsViewModel?.getItemAtIndex(index: indexPath.row){
            cell.updateView(item: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "itemDetails") as! ItemDetailsViewController
        if let item =  itemsViewModel?.getItemAtIndex(index: indexPath.row){
            itemDetailVC.itemDetailsViewModel = ItemDetailsViewModel(itemDetails: item)
        }
        self.present(itemDetailVC, animated: true, completion: nil)

    }
}
