//
//  ItemTableViewCell.swift
//  Elmenus
//
//  Created by New  on 7/7/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import SDWebImage
class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateView(item:Item)  {
        self.itemName.text = item.name
        self.itemImg.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        if let photUrl = item.photoUrl {
            self.itemImg?.sd_setImage(with: URL(string: photUrl), completed: nil)
        }
    }
}
