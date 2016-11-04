//
//  UIBarButtonItem_Extension.swift
//  DYZB
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func creatItem(iamgeName:String, heightImageName: String,size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named:iamgeName), for: .normal);
        btn.setImage(UIImage(named:heightImageName), for: .selected);
        btn.frame.size = size;
        
        let item = UIBarButtonItem(customView: btn);
        
        return item;
    }
    */
    //使用构造函数
    convenience init(imageName:String, heightImageName: String = "",size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal);
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame.size = size;
        }
        
        if heightImageName != "" {
            btn.setImage(UIImage(named:heightImageName), for: .highlighted);
        }
        
        self.init(customView: btn);
        
    }
    
}
