//
//  XwTabBar.swift
//  CteemoCM
//
//  Created by luxtmxw on 16/3/23.
//  Copyright © 2016年 Bintao. All rights reserved.
//

import UIKit

class XwTabBar: UITabBar {
    
    lazy var midBtn: UIButton = {
        var btn = UIButton()
//        btn.backgroundColor = Color_FF9500
//        btn.setWane(5)
        btn.sizeToFit()
//        btn.setTitle("+", forState: .Normal)
//        btn.userInteractionEnabled = false
        btn.setBackgroundImage(UIImage(named: "6"), forState: .Normal)
        return btn
    }()
    
    convenience init(frame: CGRect, target: AnyObject, btnAction: Selector) {
        self.init()
        self.frame = frame
//        self.backgroundColor = UIColor.redColor()
        midBtn.addTarget(target, action: btnAction, forControlEvents: .TouchUpInside)
        self.addSubview(midBtn)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let w:CGFloat = self.bounds.size.width
        let h:CGFloat = self.bounds.size.height
        
        var btnX:CGFloat = 0
        let btnY:CGFloat = 0
        let btnW:CGFloat = w / 5
        let btnH:CGFloat = h
        
        var i: CGFloat = 0
        for item in self.subviews {
            if item.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                btnX = i * btnW
                item.frame = CGRectMake(btnX, btnY, btnW, btnH)
                
                if i == 1 {
                    i += 1
                }
                
                i += 1
            }
        }
//        self.midBtn.frame = CGRectMake(0, 0, btnH - 4, btnH - 4)
//        self.midBtn.center = CGPointMake(w * 0.5, h * 0.5)
        self.midBtn.setFrameByCenter(CGRectMake(w * 0.5, h * 0.5, h * 0.8 / 8 * 10, h * 0.8))
    }
}
