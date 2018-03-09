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
     
     知识点：
        1.可以打断点让其停在某一行，在控制台写 po weapons 可以查看weapons这个对象
        2.嵌入导航条后，在tableView同级添加title，再勾选上Navigation Bar中的 Prefers Large Titles就可以变成大标题了
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
        cell.favorite = favorites[indexPath.row]

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    //DataSource方法：对单元格的操作
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        weapomImages.remove(at: indexPath.row)
        weaponTypes.remove(at: indexPath.row)
        favorites.remove(at: indexPath.row)
        origins.remove(at: indexPath.row)
        weapons.remove(at: indexPath.row)
        
        print("count",weapons.count)
        tableView.deleteRows(at: [indexPath], with: .fade)
  
    }
    
    //向左滑删除分享操作，重写了这个方法上面的方法就失效
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //删除操作
        let delAction = UIContextualAction(style: .destructive, title: "delete") { (_, _, completion) in
            self.weapomImages.remove(at: indexPath.row)
            self.weaponTypes.remove(at: indexPath.row)
            self.favorites.remove(at: indexPath.row)
            self.origins.remove(at: indexPath.row)
            self.weapons.remove(at: indexPath.row)
            
            print("count",self.weapons.count)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            completion(true)
        }
        
        //分享操作
        let shareAction = UIContextualAction(style: .normal, title: "share") { (_, _, completion) in
            let text = "这是一个武器\(self.weapons[indexPath.row])"
            let img = UIImage(named: self.weapomImages[indexPath.row])!
            
            //尽量使用系统中的分享工具，不适用第三方分享
            let ac = UIActivityViewController(activityItems: [text,img], applicationActivities: nil)
            
            
            //-------在iPad上模态弹出分享框不好看，就修改一下分享样式
            if let pc = ac.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath){
                    pc.sourceView = cell
                    pc.sourceRect = cell.bounds
                }
            }
            
            
            //这个操作类似于action弹框
            self.present(ac, animated: true, completion: nil)
            //分享完成后要把 ”share“按钮收起来
            completion(true)
        }
        shareAction.backgroundColor = UIColor.orange
        
        let config = UISwipeActionsConfiguration(actions: [delAction,shareAction])
        return config
    }
    
    //向右滑喜欢菜单
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favAction = UIContextualAction(style: .normal, title: "like") { (_, _, completion) in
            self.favorites[indexPath.row] = !self.favorites[indexPath.row]
            
            completion(true)
        }
        
        favAction.backgroundColor = UIColor.purple
        favAction.image = self.favorites[indexPath.row] == true ? #imageLiteral(resourceName: "fav") : #imageLiteral(resourceName: "unfav")
        
        let config = UISwipeActionsConfiguration(actions: [favAction])
        return config
        
    }
    
    

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //转场之前的准备工作
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //找到是点击的第几行
        let row = tableView.indexPathForSelectedRow?.row
        
        //从segue中取出目的场景，强转成WeaponDetailViewController
        let destination = segue.destination as! WeaponDetailViewController
        
        destination.imageName = weapomImages[row!]
        
        
        
    }
    

}
