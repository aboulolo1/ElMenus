//
//  ItemDetailsViewController.swift
//  Elmenus
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import SDWebImage
class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var itemDetailsTB: UITableView!
    
    var itemDetailsViewModel:ItemDetailsViewModel?
    let itemImg = UIImageView()
    let backbtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
                
        itemDetailsTB.estimatedRowHeight = 50
        itemDetailsTB.contentInset = UIEdgeInsets(top: 300, left: 0, bottom: 0, right: 0)
        itemDetailsTB.tableFooterView = UIView()
        itemDetailsTB.dataSource = self
        itemDetailsTB.delegate = self
        
        itemImg.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        itemImg.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        
        if let photUrl = itemDetailsViewModel?.photoUrl {
            itemImg.sd_setImage(with: URL(string: photUrl), completed: nil)
        }

        itemImg.contentMode = .scaleAspectFill
        itemImg.clipsToBounds = true
        view.addSubview(itemImg)
        
        backbtn.frame = CGRect(x: 10, y: 20, width: 30, height: 39)
        backbtn.setBackgroundImage(UIImage(named: "back_icon"), for: .normal)
        backbtn.addTarget(self, action: #selector(backBtnOnClick(sender:)), for: UIControl.Event.touchUpInside)
        view.addSubview(backbtn)

    }
    @objc func backBtnOnClick(sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension ItemDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = itemDetailsTB.dequeueReusableCell(withIdentifier: "itemDetailsCell") as! ItemDetailsTableViewCell
        cell.itemDescription.text = itemDetailsViewModel?.itemDescription
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 400)
        itemImg.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
        
        
    }
}
