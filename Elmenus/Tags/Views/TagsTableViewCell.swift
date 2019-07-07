//
//  TagsTableViewCell.swift
//  Elmenus
//
//  Created by New  on 7/5/19.
//  Copyright © 2019 Elmenus. All rights reserved.
//

import UIKit
import SDWebImage

class TagsTableViewCell: UITableViewCell {

    @IBOutlet weak var tagImg: UIImageView!
    @IBOutlet weak var tagName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateView(tag:Tag)  {
        self.tagName.text = tag.tagName
        self.tagImg.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        if let photUrl = tag.photoURL {
            self.tagImg?.sd_setImage(with: URL(string: photUrl), completed: nil)

        }
    }
}
