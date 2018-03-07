//
//  UIViewHelper.swift
//  UITableViewController
//
//  Created by paddygu on 2018/3/7.
//  Copyright © 2018年 paddygu. All rights reserved.
//

import UIKit

//对UIView做扩展，所有的视图都可以使用该属性
extension UIView {
    //IBInspectable 修饰符让其可见
    
    //圆角
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    //阴影半径
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    //阴影透明度
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    //阴影颜色
    @IBInspectable
    var shadowColor: UIColor? {//可能为空，所以加一个？
        get {
            return layer.shadowColor != nil ? UIColor(cgColor: layer.shadowColor!) : nil
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }
    
    //阴影偏移
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
}
