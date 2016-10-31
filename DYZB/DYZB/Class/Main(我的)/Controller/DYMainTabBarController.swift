//
//  DYMainTabBarController.swift
//  DYZB
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class DYMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC("Home");
        
        addChildVC("Live")
        
        addChildVC("Follow");
        
        addChildVC("My");
        
    }
    
    func addChildVC(_ storyboardName:String) {
        let childVC = UIStoryboard(name: storyboardName,bundle:nil).instantiateInitialViewController()!;
        addChildViewController(childVC);
    }


    


}
