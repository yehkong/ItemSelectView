//
//  THPickViewer.swift
//  SelectItemDemo
//
//  Created by yetaiwen on 2019/1/5.
//  Copyright © 2019 yetaiwen. All rights reserved.
//

import UIKit


///pickerView Datasoure protocol
protocol THPickerDelegate {
    
    func number(ofItems pickerView: THPickViewer) -> Int
    
    func pickerView(_ pickerView: THPickViewer, itemForIndex index: Int) -> String
    
    func pickerView(_ pickerView: THPickViewer, didSelect index: Int) -> ()
}

///pickerView
class THPickViewer: UIScrollView {
    
    var datasource: THPickerDelegate?
    
    var selectedIndex: Int = 0

    var itemWidth: CGFloat = 0
    
    private var items: Array<String>?
    
    private var itemHeight: CGFloat = 0
    
    init(_ frame: CGRect, layout count: Int, select selectedIndex: Int) {
        super.init(frame: frame)
        
        self.items = Array.init()
        
        itemWidth = self.bounds.size.width/CGFloat(count)
        
        itemHeight = self.bounds.size.height
        
        self.selectedIndex = selectedIndex
        
        self.showsVerticalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPickerContents() -> () {
        
        if (self.items?.count)! > 0 {
            self.items?.removeAll()
            for btn in self.subviews {
                btn.removeFromSuperview()
            }
        }
        
        let count = self.datasource?.number(ofItems: self)
        
        for i in 0..<count! {
            let title = self.datasource?.pickerView(self, itemForIndex: i)
            self.items?.append(title!)
            
            let btn = UIButton.init(frame: CGRect.init(x: CGFloat.init(i) * itemWidth + itemWidth, y: 0, width: itemWidth, height: itemHeight))
            btn.tag = i
            btn.setTitle(title, for: .normal)
            btn.addTarget(self, action: #selector(clickItemAction(_:)), for: .touchUpInside)
            if i == self.selectedIndex {
                btn.setTitleColor(UIColor.Color(WithHex: 0x418eff), for: .normal)
                btn.titleLabel?.font = UIFont.PingFangSC(with: UIFont.PingFangType.PingFangSCMedium, size: 26)
            }else {
                btn.setTitleColor(UIColor.Color(WithHex: 0x999999), for: .normal)
                btn.titleLabel?.font = UIFont.PingFangSC(with: UIFont.PingFangType.PingFangSCMedium, size: 18)
                
            }
            self.addSubview(btn)
        }
        
        self.contentMode = .scaleAspectFit
        self.contentSize = CGSize.init(width: (CGFloat.init(count!)+2)*itemWidth, height: itemHeight)
        
        let offPoint = CGPoint.init(x: (CGFloat.init(self.selectedIndex+1) * itemWidth)-(self.bounds.size.width-self.itemWidth)/2, y: 0)
        self.setContentOffset(offPoint, animated: true)
        
    }
    
    func selectIndexAnimation(WithIndex selectColume: Int, offect offPoint: CGPoint) -> () {
        self.selectedIndex = selectColume
        setUpPickerContents()
        self.setContentOffset(offPoint, animated: true)
    }
    
    @objc private func clickItemAction(_ sender: UIButton) -> () {
        let index = sender.tag
        let offPoint = CGPoint.init(x: (CGFloat.init(index+1) * itemWidth)-(self.bounds.size.width-self.itemWidth)/2, y: 0)
        self.selectIndexAnimation(WithIndex: index, offect: offPoint)
        self.datasource?.pickerView(self, didSelect: index+1)
    }

    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}

///苹方字体
extension UIFont {
    
    enum PingFangType {
        case PingFangSCMedium
        case PingFangSCSemibold
        case PingFangSCLight
        case PingFangSCUltralight
        case PingFangSCRegular
        case PingFangSCThin
    }
    
    static func PingFangSC(with fontType: PingFangType?, size fontsize: CGFloat) -> (UIFont) {
        
        //        for familyName in UIFont.familyNames {
        //            print("familyName:\(familyName)")
        //            for fontName in UIFont.fontNames(forFamilyName: familyName){
        //                print("fontName:\(fontName)")
        //            }
        //        }
        
        var fontName = "PingFangSC-Regular"
        switch fontType {
        case .PingFangSCMedium?:
            fontName = "PingFangSC-Medium"
        case .PingFangSCSemibold?:
            fontName = "PingFangSC-Semibold"
        case .PingFangSCLight?:
            fontName = "PingFangSC-Light"
        case .PingFangSCUltralight?:
            fontName = "PingFangSC-Ultralight"
        case .PingFangSCThin?:
            fontName = "PingFangSC-Thin"
        default:
            fontName = "PingFangSC-Regular"
        }
        let font = UIFont.init(name: fontName, size: fontsize)
        return font!
    }
}

///hexColor
extension UIColor {
    static func Color(WithHex hex: Int) -> (UIColor) {
        let r = (hex >> 16) & 0xFF
        let g = (hex >> 8) & 0xFF
        let b = hex & 0xFF
        let color = UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
        return color
    }
}

