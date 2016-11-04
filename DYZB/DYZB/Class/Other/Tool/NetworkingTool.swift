//
//  NetworkingTool.swift
//  DYZB
//
//  Created by apple on 16/11/4.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import Alamofire

enum MethType {
    case get
    case post
}

class NetworkingTool {
    class func requestData(_ type: MethType, URLString: String,paremater: [String : NSString]? = nil,finishCallBack: @escaping(_ resurt: AnyObject)->()) {
        // 1.获取类型
//        let method = type == .get ? Method.GET : Method.POST
        
        
    
    }
}
