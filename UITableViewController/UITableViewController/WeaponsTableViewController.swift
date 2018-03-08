//
//  WeaponsTableViewController.swift
//  UITableViewController
//
//  Created by paddygu on 2018/3/6.
//  Copyright © 2018年 paddygu. All rights reserved.
//

import UIKit

class WeaponsTableViewController: UITableViewController {

/*
     带模糊效果的容器 Visual Effect View With Blur
     扩展在storyboard中可设置的项：使用@IBInspectable，把扩展专门写一个文件“ UIViewHelper”
 */
    
    //数据源
    var weapons = ["AUG","AWM","十字弩","DP28","Groza","Kar98k","M16a4","Micro UZI","平底锅","SKS","UMP9"]
    var weaponTypes = ["自动步枪","狙击枪","冷兵器","机枪","自动步枪","狙击枪","自动步枪","冲锋枪","近身武器","半自动步枪","冲锋枪"]
    var origins = ["奥地利","英国","中国","前苏联","俄罗斯","德国","美国","以色列","美国","前苏联","美国"]
    var weapomImages = ["aug","awm","crossbow","dp28","groza","kar98k","m16a4","microuzi","pan","sks","ump9"]
    
    //Model：保存武器的收藏状态
    var favorites = Array(repeating: false, count: 11)
    
    //收藏按钮的点击事件
    @IBAction func favBtnTap(_ sender: UIButton) {
        //找到button按钮在tableView中的位置
        let btnPos = sender.convert(CGPoint.zero, to: self.tableView)
        print("爱心按钮在tableView中的的位置：",btnPos)
        
        let indexPath = tableView.indexPathForRow(at: btnPos)!
        print("爱心按钮所在行：",indexPath) 
        
        //self.favorites[(indexPath?.row)!] indexPath一定有值，所以上面的indexPath可以用感叹号强制拆包
        self.favorites[indexPath.row] = !self.favorites[indexPath.row]
        
        //获取当前的单元格，强转成CardCell
        let cell = tableView.cellForRow(at: indexPath) as! CardCell
        //更新单元格的收藏状态
        cell.favorite = favorites[indexPath.row]
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weapons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath)
        
        //利用这种写法的Id不容易出错，上面的方法也可
        let id = String(describing:CardCell.self)
        // as! CardCell 必须把它强制转换成 CardCell，要不读不到其属性
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! CardCell
        
        cell.typeLabel.text = weaponTypes[indexPath.row]
        cell.weaponLabel.text = weapons[indexPath.row]
        cell.originLabel.text = origins[indexPath.row]
        cell.backImageView.image = UIImage(named: weapomImages[indexPath.row])
        
        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
