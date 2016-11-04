//
//  DYHomeViewController.swift
//  DYZB
//
//  Created by apple on 16/10/31.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

private let pageTitleViewH: CGFloat = 40

class DYHomeViewController: UIViewController {

    // MARK --- 系统函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        
        setupUI()
        
    }
    
    
    // MARK --- 懒加载
    fileprivate lazy var pageTitleView: DYPageTitleView = { [weak self] in
        let frame = CGRect(x: 0, y: kStartH + kNavigationH, width: kScreenW, height: pageTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let pageTitleView = DYPageTitleView(frame: frame, titles: titles)
        pageTitleView.delegate = self as? DYPageTitleViewDelegate
        return pageTitleView
    }()
    
    fileprivate lazy var pageContentView: DYPageContentView = { [weak self] in
        
        let frame = CGRect(x: 0, y: kStartH + kNavigationH + pageTitleViewH, width: kScreenW, height: kScreenH - kStartH - kNavigationH - pageTitleViewH)
        var childVC = [UIViewController]()
        
        for _ in 0..<4 {
            let vc = UIViewController()
            
            childVC.append(vc)
        }
        
        let contentView = DYPageContentView(frame: frame, childVCs: childVC, parentVC: self)
        contentView.delegate = self;
        return contentView
    }()
    
}

// MARK --- 设置UI界面
extension DYHomeViewController {
     fileprivate func setupNav() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        //设置左侧的item
        let leftItem = UIBarButtonItem(imageName: "logo")
        navigationItem.leftBarButtonItem = leftItem;
        
        //设置右侧的item
        let size = CGSize(width: 40, height: 40)
    
        let historyItem = UIBarButtonItem(imageName: "image_my_history", heightImageName: "Image_my_history_click", size: size);
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", heightImageName: "btn_search_clicked", size: size)
        
        let scanItem = UIBarButtonItem(imageName: "Image_scan", heightImageName: "Image_scan_click", size: size);
        
        navigationItem.rightBarButtonItems = [searchItem,scanItem,historyItem]
    }
    
    fileprivate func setupUI () {
        view.addSubview(pageTitleView)
        
        view.addSubview(pageContentView)
    }
    
}

// MARK: --- DYPageTitleViewDelegate
extension DYHomeViewController: DYPageTitleViewDelegate {
    func pageTitleView(_ titleView: DYPageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
//        pageContentView.setCurrentIndex(index: index)
    }
}

extension DYHomeViewController: DYPageContentViewDelegate {
    func pageContentView(_ contentView: DYPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

