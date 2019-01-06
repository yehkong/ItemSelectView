# ItemSelectView
滑动选择，点击选择，联动选择


序言： 需求是从数组中选择内容，需要可左右滑动选择，可点击选择，并且对选择的内容高亮显示和展示，且在需要时多个数组的数据进行联动选择。

* 满足这样的需求，比较简单的实现就是UIButton和UIScrollview的运用。

以下效果也是基于类似的思路实现：
![2.gif](https://upload-images.jianshu.io/upload_images/2737326-ee9020a9713b7273.gif?imageMogr2/auto-orient/strip)

#####  show the code
* 下载Demo-[github地址](https://github.com/yehkong/ItemSelectView)

```
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
```
