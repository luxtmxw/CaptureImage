//
//  Extension+UIColor.swift
//  CteemoCN
//
//  Created by MrMessy on 16/4/12.
//  Copyright © 2016年 bintao. All rights reserved.
//

import UIKit

//MARK: - ExtensionUIColor
extension UIColor {
    
    //MARK: - 获取随机颜色
    func getRandomColor() -> UIColor {
        let red = CGFloat((arc4random() % 100) / 100)
        let green = CGFloat((arc4random() % 100) / 100)
        let blue = CGFloat((arc4random() % 100) / 100)
        
        let randomColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        return randomColor
    }
}
