//
//  WeaponDetailViewController.swift
//  UITableViewController
//
//  Created by paddygu on 2018/3/9.
//  Copyright © 2018年 paddygu. All rights reserved.
//

import UIKit

class WeaponDetailViewController: UIViewController {

    var imageName = ""
    @IBOutlet weak var headerImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.headerImageView.image = UIImage(named: self.imageName)
        
        //详情页就不显示大标题了
        navigationItem.largeTitleDisplayMode = .never
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
