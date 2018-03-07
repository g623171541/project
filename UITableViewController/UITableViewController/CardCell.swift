//
//  CardCell.swift
//  UITableViewController
//
//  Created by PaddyGu on 2018/3/7.
//  Copyright © 2018年 paddygu. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var weaponLabel: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
