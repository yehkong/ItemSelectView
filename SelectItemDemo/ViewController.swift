//
//  ViewController.swift
//  SelectItemDemo
//
//  Created by yetaiwen on 2019/1/5.
//  Copyright © 2019年 yetaiwen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var pickerView1: THPickViewer?
    var pickerView2: THPickViewer?
    var pickerView3: THPickViewer?
    var pickerView4: THPickViewer?
    
    lazy var cities_from = ["成都","海口","广州","赣州","深圳"]
    lazy var cities_to = [["成都","海口","广州","赣州","深圳"],["成都","海口","广州","赣州","深圳"],["成都","海口","广州","赣州","深圳"],["成都","海口","广州","赣州","深圳"],["成都","海口","广州","赣州","深圳"]]
    
    let PickerView_H = CGFloat(60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerView1 = THPickViewer.init(CGRect.init(x: 0, y: PickerView_H+64, width: self.view.bounds.size.width, height: PickerView_H), layout: 3, select: 1)
        pickerView1?.datasource = self
        pickerView1?.delegate = self
        pickerView1?.backgroundColor = UIColor.orange
        pickerView1?.setUpPickerContents()
        self.view.addSubview(pickerView1!)
        
        pickerView2 = THPickViewer.init(CGRect.init(x: 0, y: PickerView_H*2+64, width: self.view.bounds.size.width, height: PickerView_H), layout: 3, select: 3)
        pickerView2?.datasource = self
        pickerView2?.delegate = self
        pickerView2?.setUpPickerContents()
        pickerView2?.backgroundColor = UIColor.yellow
        self.view.addSubview(pickerView2!)
        
        pickerView3 = THPickViewer.init(CGRect.init(x: 0, y: PickerView_H*4+64, width: self.view.bounds.size.width, height: PickerView_H), layout: 4, select: 2)
        pickerView3?.datasource = self
        pickerView3?.delegate = self
        pickerView3?.setUpPickerContents()
        pickerView3?.backgroundColor = UIColor.blue
        self.view.addSubview(pickerView3!)
        
        pickerView4 = THPickViewer.init(CGRect.init(x: 0, y: PickerView_H*6+64, width: self.view.bounds.size.width, height: PickerView_H), layout: 5, select: 4)
        pickerView4?.datasource = self
        pickerView4?.delegate = self
        pickerView4?.setUpPickerContents()
        pickerView4?.backgroundColor = UIColor.purple
        self.view.addSubview(pickerView4!)
    }
    
}

extension ViewController:THPickerDelegate,UIScrollViewDelegate{
    func number(ofItems pickerView: THPickViewer) -> Int {
        if pickerView == pickerView1 {
            return self.cities_from.count
        }else if pickerView == pickerView2 {
            let me_select = pickerView1?.selectedIndex
            return self.cities_to[me_select!].count
        }else if pickerView == pickerView3 {
            return self.cities_from.count
        }else {
            return self.cities_from.count
        }
    }
    
    func pickerView(_ pickerView: THPickViewer, itemForIndex index: Int) -> String {
        if pickerView == pickerView1 {
            return self.cities_from[index]
        }else if pickerView == pickerView2 {
            let me_select = pickerView1?.selectedIndex
            return self.cities_to[me_select!][index]
        }else if pickerView == pickerView3 {
            return self.cities_from[index]
        }else {
            return self.cities_from[index]
        }
    }
    
    func pickerView(_ pickerView: THPickViewer, didSelect index: Int) {
        if pickerView == pickerView1 {
            pickerView2?.setUpPickerContents()
            let offestx = (pickerView2?.itemWidth)!-((pickerView2?.bounds.size.width)!-(pickerView2?.itemWidth)!)/2
            pickerView2?.selectIndexAnimation(WithIndex: 0, offect:CGPoint.init(x: offestx, y: 0) )
        }else {
            
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == pickerView1 {
            let offNumber = ceil(Float.init(scrollView.contentOffset.x/(pickerView1?.itemWidth)!+0.5))
            let offest = CGFloat.init(offNumber) * (pickerView1?.itemWidth)! - ((pickerView1?.bounds.size.width)!-(pickerView1?.itemWidth)!)/2
            pickerView1?.selectIndexAnimation(WithIndex: Int.init(offNumber-1), offect: CGPoint.init(x: offest, y: 0))
            self.pickerView(pickerView1!, didSelect: Int(offNumber))
        }else {
            self.scroll(by: scrollView as? THPickViewer)
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == pickerView1 {
            let offNumber = ceil(Float.init(scrollView.contentOffset.x/(pickerView1?.itemWidth)!+0.5))
            let offest = CGFloat.init(offNumber) * (pickerView1?.itemWidth)! - ((pickerView1?.bounds.size.width)!-(pickerView1?.itemWidth)!)/2
            pickerView1?.selectIndexAnimation(WithIndex: Int.init(offNumber-1), offect: CGPoint.init(x: offest, y: 0))
            self.pickerView(pickerView1!, didSelect: Int(offNumber))
        }else {
            self.scroll(by: scrollView as? THPickViewer)
        }
    }
    
    
    func scroll(by scrollView: THPickViewer?) -> () {
        let offNumber = ceil(Float.init(scrollView!.contentOffset.x/(scrollView?.itemWidth)!+0.5))
        let offest = CGFloat.init(offNumber) * (scrollView?.itemWidth)! - ((scrollView?.bounds.size.width)!-(scrollView?.itemWidth)!)/2
        scrollView?.selectIndexAnimation(WithIndex: Int.init(offNumber-1), offect: CGPoint.init(x: offest, y: 0))
        self.pickerView(scrollView!, didSelect: Int(offNumber))
    }
}

