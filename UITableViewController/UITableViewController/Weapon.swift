//
//  Weapon.swift
//  UITableViewController
//
//  Created by PaddyGu on 2018/3/25.
//  Copyright © 2018年 paddygu. All rights reserved.
//

import Foundation

//swift中的面向对象：swift中推荐使用结构体（struct），默认实现构造方法，无需内存管理

//创建枪的对象
struct Weapon {
    var name = ""
    var type = ""
    var origin = ""
    var image = ""
    var favorite = false
    
    //子弹类型
    var bullet = 0.0
    //子弹速度
    var mv = 0
    //整体介绍
    var text = ""
}

//可以这样创建一个对象
//Weapon(name: <#T##String#>, type: <#T##String#>, origin: <#T##String#>, image: <#T##String#>, favorite: <#T##String#>, bullet: <#T##Double#>, mv: <#T##Int#>, text: <#T##String#>)
