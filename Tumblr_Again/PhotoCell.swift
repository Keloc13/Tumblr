//
//  CustomCellTableViewCell.swift
//  Tumblr_Again
//
//  Created by Kevin Nguyen on 2/3/18.
//  Copyright © 2018 KevinVuNguyen. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var Photo: UIImageView!
    // @IBOutlet weak var Photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
