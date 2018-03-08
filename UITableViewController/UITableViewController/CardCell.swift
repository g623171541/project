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
    
    //Model：单个武器的收藏状态
    var favorite = false {          //在其后面加个大括号，调用观察者模式
        willSet {                   //即将发生变化，包含一个新值 newValue
            if newValue {
                favBtn.setImage(#imageLiteral(resourceName: "fav"), for: .normal)
            }else{
                favBtn.setImage(#imageLiteral(resourceName: "unfav"), for: .normal)
            }
        }
    }
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
