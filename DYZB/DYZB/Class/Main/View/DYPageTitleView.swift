//
//  DYPageTitleView.swift
//  DYZB
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

//MARK: --- 定义协议
protocol DYPageTitleViewDelegate: class{
    func pageTitleView(_ titleView:DYPageTitleView,selectedIndex index: Int)
}

private let lineViewH: CGFloat = 2
private let lineViewX: CGFloat = 5
private let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class DYPageTitleView: UIView {
    
    fileprivate var titles: [String]?
    
    fileprivate var currentIndex: Int = 0
    
    fileprivate var currentLabel: UILabel?
    
    fileprivate var oldLabel: UILabel?
    
    weak var delegate: DYPageTitleViewDelegate?
    

    init(frame: CGRect, titles: [String]) {
        self.titles = titles;
        super.init(frame: frame);
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: --- 懒加载
    
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView ()
        scrollView.scrollsToTop = false;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.bounces = false;
        return scrollView
    }()
    
    fileprivate lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.orange
        return lineView
    }()
    
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()

}

extension DYPageTitleView {
    fileprivate func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupTitleLabels()
        
        
    }
    
    fileprivate func setupTitleLabels () {
        
        var labelX: CGFloat = 0
        let labelW: CGFloat = frame.size.width / CGFloat(titles!.count)
        let labelY: CGFloat = 0
        let labelH: CGFloat = frame.size.height
        
        for (index,title) in titles!.enumerated() {
            //
            let label = UILabel()
            
            label.textAlignment = .center;
            label.font = UIFont.systemFont(ofSize: 16);
            label.textColor = UIColor.darkGray
            label.tag = index
            label.text = title
            
            labelX = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH);
            scrollView.addSubview(label)
            titleLabels.append(label)
        
            
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(_:)))
            label.addGestureRecognizer(tap)
            
            if index == 0 {
                self.oldLabel = label
                titleLabelClick(tap)
            }
        }
        scrollView.addSubview(lineView)
        
        lineView.frame = CGRect(x: lineViewX, y: frame.size.height - lineViewH, width: labelW - 2.0 * lineViewX, height: lineViewH);
        
    }
    
    
}
// MARK: --- 点击事件
extension DYPageTitleView {
    
    @objc fileprivate func titleLabelClick (_ tap: UITapGestureRecognizer) {
        // 获取当前的label
        guard let currentLabel = tap.view as? UILabel  else {
            return
        }
        if currentLabel == self.currentLabel {
            return
        }
        //获取之前的label
        self.oldLabel = self.currentLabel
        //当前的label
        self.currentLabel = currentLabel
        //切换文字的颜色
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        self.oldLabel?.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        //改变线的位置
        let scrollLineX = currentLabel.frame.origin.x + lineViewX
        
        UIView.animate(withDuration: 0.15, animations: {
            self.lineView.frame.origin.x = scrollLineX
        })
        
        delegate?.pageTitleView(self, selectedIndex: currentLabel.tag)
        
    }
}

// MARK: --- 外部公开的方法
extension DYPageTitleView {
    func setTitleWithProgress(_ progress: CGFloat,sourceIndex: Int,targetIndex: Int){
        //取出label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = progress * moveTotalX
        self.lineView.frame.origin.x = sourceLabel.frame.origin.x + moveX + 5
        
        //处理颜色的渐变
        //取出颜色变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0,kSelectColor.1 - kNormalColor.1,kSelectColor.2 - kNormalColor.2)
        //变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        //变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //记录当前的label
        currentLabel = targetLabel
    }

}
