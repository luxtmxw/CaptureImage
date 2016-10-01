
import Foundation
import UIKit

extension UIFont {
    //微赛默认字体
    class func weisaiFontOfName(size: CGFloat) -> UIFont {
        return UIFont(name: "STHeitiTC-Light", size: size)!
    }
}

class Font: UIFont {
    override class func systemFontOfSize(fontSize: CGFloat) -> UIFont
    {
        return UIFont(name: "Heiti SC", size: fontSize)!
    }
}

extension UILabel{
    func initAutoHeight(rect:CGRect,textColor:UIColor, fontSize:CGFloat, text:NSString, lineSpacing:CGFloat){//自适应高度
        self.frame = rect
        self.textColor = textColor
        self.font = UIFont.systemFontOfSize(fontSize)
        self.numberOfLines = 0
        let attributedString = NSMutableAttributedString(string: text as String)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, text.length))
        self.attributedText = attributedString
        self.sizeToFit()
        self.frame.size.width = rect.width
        self.frame.size.height = max(self.frame.size.height, rect.height)
    }
    
    func autoHeight(rect:CGRect, lineSpacing:CGFloat){
        self.frame = rect
        if self.text != nil{
            self.numberOfLines = 0
            let attributedString = NSMutableAttributedString(string: self.text!)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            let str: NSString = self.text!
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, str.length))
            self.attributedText = attributedString
            self.sizeToFit()
            self.frame.size.width = rect.width
            self.frame.size.height = max(self.frame.size.height, rect.height)
        }
    }
    
    func autoHeightBySpace(lineSpacing:CGFloat){
        self.autoHeight(self.frame, lineSpacing: lineSpacing)
    }
    
    //...
    func setForTitleByFont(s: CGFloat){
        self.textColor = UIColor.whiteColor()
        self.textAlignment = NSTextAlignment.Center
        self.font = UIFont.systemFontOfSize(s)
    }
    
    func sizeFitHeight(){
        let w = self.frame.width
        self.sizeToFit()
        self.frame.size.width = w
    }
    
    func sizeFitWidth(){
        let h = self.frame.height
        self.sizeToFit()
        self.frame.size.height = h
    }
    
    
    func addTextByColor(texts: [MutableTextColor]){
        var curStr = ""
        for text in texts{
            curStr += text.text
        }
        
        let countStr = NSMutableAttributedString(string: curStr)
        for text in texts{
            if (curStr as NSString).rangeOfString(text.text).location != NSNotFound{
                countStr.addAttribute(NSForegroundColorAttributeName, value: text.color, range: (curStr as NSString).rangeOfString(text.text))
                if let font = text.font{
                    countStr.addAttribute(NSFontAttributeName, value: font, range: (curStr as NSString).rangeOfString(text.text))
                }
            }
        }
        self.attributedText = countStr
    }
}

//多种颜色的label
struct MutableTextColor{
    var text: String!
    var color: UIColor!
    var font: UIFont!
    init(text: String, color: UIColor, font: UIFont! = nil){
        self.text = text
        self.color = color
        self.font = font
    }
}

extension UIView {
    
    func setWane(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func setBorder(color: UIColor, width: CGFloat){
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = width
    }
    
    func setFrameByCenter(rect: CGRect){
        self.bounds = CGRectMake(0, 0, rect.width, rect.height)
        self.center.x = rect.origin.x
        self.center.y = rect.origin.y
    }
    
    var centerX: CGFloat{
        return self.bounds.width/2
    }
    
    var centerY: CGFloat{
        return self.bounds.height/2
    }
    
    var centerP: CGPoint{
        return CGPointMake(self.centerX, self.centerY)
    }
    
    var endX: CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
    
    var endY: CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    
    var originX: CGFloat {
        return self.frame.origin.x
    }
    
    var originY: CGFloat {
        return self.frame.origin.y
    }
    
    var frameWidth: CGFloat {
        return self.frame.width
    }
    
    var frameHeight: CGFloat {
        return self.frame.height
    }
    
    func setOriginY(view: UIView, height: CGFloat) -> CGFloat {
        return view.originY + (view.frameHeight - height) / 2.0
    }
    
    var marginWidth: CGFloat{
        return 10
    }
    
    func addBottomLine(color: UIColor) {
        let lineView = UIView()
        lineView.frame = CGRectMake(0, self.frame.size.height-0.5, UIScreen.mainScreenWidth, 0.5)
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    func addLineByRect(rect: CGRect, color: UIColor = Color_line){
        let lineView = UIView()
        lineView.frame = rect
        lineView.backgroundColor = color
        self.addSubview(lineView)
    }
    
    func hideView(offset: CGFloat) {
        self.transform = CGAffineTransformMakeTranslation(0, offset)
        self.alpha = 0.0
        self.hidden = true
    }
    
    func showView() {
        UIView.animateWithDuration(0.4) { () -> Void in
            self.alpha = 1.0
            self.hidden = false
            self.transform = CGAffineTransformIdentity
        }
    }
}

extension UITextField{
    
}

extension UIScreen {
    class var mainScreenWidth: CGFloat {//主屏幕宽度
        return UIScreen.mainScreen().bounds.size.width
    }
    class var mainScreenHeight: CGFloat {//主屏幕高度
        return UIScreen.mainScreen().bounds.size.height
    }
    
    class var mainScreenBounds: CGRect {
        return UIScreen.mainScreen().bounds
    }
    
    class var mainScreenScale: CGFloat {
        return UIScreen.mainScreen().scale
    }
}

var defaultFrame = CGRectMake(0, 0, 0, 0)
extension UIView{//各种动画效果
    func scaleMyView(){
        let newTransform: CGAffineTransform = CGAffineTransformScale(self.transform, 0.1, 0.1)
        self.transform = newTransform
        self.alpha = 0
    }
    
    func scaleBigAnimation(){
        self.scaleBigWithTime(0.35) { () -> Void in
            self.transform = CGAffineTransformIdentity
        }
    }
    
    func scaleBigWithTime(time: NSTimeInterval, handle: ()->Void){
        UIView.animateWithDuration(time, animations: { () -> Void in
            let newTransform: CGAffineTransform = CGAffineTransformConcat(self.transform, CGAffineTransformInvert(self.transform))
            self.transform = newTransform
            self.alpha = 1
            }) { (f:Bool) -> Void in
                handle()
        }
    }
    
    func scaleSmallWithTime(time: NSTimeInterval, handle: ()->Void){
        UIView.animateWithDuration(time, animations: { () -> Void in
            let newTransform: CGAffineTransform = CGAffineTransformScale(self.transform, 0.1, 0.1)
            self.transform = newTransform
            self.alpha = 0
            }) { (f:Bool) -> Void in
                if f{
                    handle()
                }
        }
    }
    
    func scaleSmallAnimation(){
        self.scaleSmallWithTime(0.35) { () -> Void in
            self.removeFromSuperview()
        }
    }
    
    //MARK: 抖动效果
    func shakeAnimation(){
        UIView.animateKeyframesWithDuration(0.1, delay: 0, options: [.Repeat,.Autoreverse,.AllowUserInteraction], animations: { () -> Void in
            self.transform = CGAffineTransformMakeRotation(0.05)
            }, completion: { (f) -> Void in
        })
    }
    
    func stopShakeAnimation(){
        self.transform = CGAffineTransformIdentity
        self.shakeAnimation()
        self.transform = CGAffineTransformIdentity
    }
    
    //MARK: 点击放大图片
//    func seeBigImageByClick(defaultImageView: UIImageView) {
//        let image = defaultImageView.image
//        print(image?.size)
//        let window = UIApplication.sharedApplication().keyWindow
//        let backgroundView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreenWidth, UIScreen.mainScreenHeight))
//        backgroundView.tag = 1
//        backgroundView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
//        
//        defaultFrame = defaultImageView.convertRect(defaultImageView.bounds, toView: window)
//
//        let imageView = UIImageView(frame: defaultFrame)
//        imageView.image = image
//        imageView.tag = 2
//        
//        backgroundView.addSubview(imageView)
//        window?.addSubview(backgroundView)
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.hideImage(_:)))
//        backgroundView.addGestureRecognizer(tap)
//        
//        let ratio = image!.size.height * UIScreen.mainScreenWidth / image!.size.width
//        UIView.animateWithDuration(0.5, animations: { () -> Void in
//            imageView.frame = CGRectMake(0, (UIScreen.mainScreenHeight - ratio) / 2.0, UIScreen.mainScreenWidth, ratio)
//            print(imageView.frame)
//            backgroundView.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
//            }, completion: { (finished) -> Void in
//                
//        })
//    }
    
    //MARK: 隐藏图片
    func hideImage(tap: UITapGestureRecognizer) {
        let backgroundView = tap.view?.viewWithTag(1)
        let imageView = tap.view?.viewWithTag(2)
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            imageView?.frame = defaultFrame
            backgroundView!.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
            }) { (finished) -> Void in
                backgroundView!.removeFromSuperview()
        }
    }
}

//MARK: - ExtensionUIButton
extension UIButton{
    //MARK: 白色
    var normalColor:UIColor{
        return UIColor.whiteColor()
    }
    
    //MARK: 高亮状态颜色
    var highlightColor:UIColor{
        return Color_999.colorWithAlphaComponent(0.5)
    }
    
//    //MARK: 设置高亮状态颜色
//    func setTapHighlight() {
//        self.addTarget(self, action: #selector(UIButton.changeColor(_:)), forControlEvents: UIControlEvents.TouchDown)
//    }
//    
//    //MARK: changeColor方法
//    func changeColor(btn:UIButton) {
//        btn.superview!.backgroundColor = highlightColor
//        btn.addTarget(self, action: #selector(UIButton.reviewColor(_:)), forControlEvents: UIControlEvents.TouchCancel)
//        btn.addTarget(self, action: #selector(UIButton.reviewColor(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        btn.addTarget(self, action: #selector(UIButton.reviewColor(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
//    }
    
    //MARK: reviewColor
    func reviewColor(btn:UIButton) {
        UIView.animateWithDuration(0.1, animations: {
            btn.alpha = 0.9
            }) { (successed) -> Void in
                btn.alpha = 1.0
                btn.superview!.backgroundColor = UIColor.whiteColor()
        }
    }
    
//    //MARK: 改变button的状态
//    func changeButtonStyle() {
//        if self.selected == true {
//            self.layer.borderWidth = 0.0
//            self.backgroundColor = Color_FF9500
//            self.layer.cornerRadius = 2.0
//            self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
//        }
//        else {
//            self.layer.borderWidth = 1.0
//            self.layer.borderColor = UIColor(hex: "dbdbea").CGColor
//            self.layer.cornerRadius = 2.0
//            self.backgroundColor = self.normalColor
//            self.setTitleColor(Color_666, forState: UIControlState.Normal)
//        }
//    }
    
    //MARK: 改变button的边框宽度，颜色，和四边角度
    func changeButtonBorder(color: UIColor, width: CGFloat, radius: CGFloat) {
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = width
        self.layer.cornerRadius = radius
    }
    
    //MARK: 设置样式
    func setStyle(title: String?="", _ color: UIColor?=Color_333, _ image: UIImage?=UIImage(), borderColor: UIColor?=Color_333, state: UIControlState) {
        self.setTitle(title, forState: state)
        self.setTitleColor(color, forState: state)
        self.setImage(image, forState: state)
        self.layer.borderColor = borderColor?.CGColor
    }
    
    func titleEdgeAndImageEdge(width: CGFloat, titleWidth: CGFloat, imageWidth: CGFloat) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, (width - titleWidth - imageWidth) / 2.0, 0, 0)
        self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel!.endX, 0, 0)
    }
    
    
}

extension UIColor{
    class func colorWithHexCode(code : String) -> UIColor {
        let colorComponent = {(startIndex : Int ,length : Int) -> CGFloat in
            var subHex = code.substringWithRange(Range(code.startIndex.advancedBy(startIndex)..<code.startIndex.advancedBy(startIndex + length)))
            subHex = subHex.characters.count < 2 ? "\(subHex)\(subHex)" : subHex
            var component:UInt32 = 0
            NSScanner(string: subHex).scanHexInt(&component)
            return CGFloat(component) / 255.0}
        
        let argb = {() -> (CGFloat,CGFloat,CGFloat,CGFloat) in
            switch(code.characters.count) {
            case 3: //#RGB
                let red = colorComponent(0,1)
                let green = colorComponent(1,1)
                let blue = colorComponent(2,1)
                return (red,green,blue,1.0)
            case 4: //#ARGB
                let alpha = colorComponent(0,1)
                let red = colorComponent(1,1)
                let green = colorComponent(2,1)
                let blue = colorComponent(3,1)
                return (red,green,blue,alpha)
            case 6: //#RRGGBB
                let red = colorComponent(0,2)
                let green = colorComponent(2,2)
                let blue = colorComponent(4,2)
                return (red,green,blue,1.0)
            case 8: //#AARRGGBB
                let alpha = colorComponent(0,2)
                let red = colorComponent(2,2)
                let green = colorComponent(4,2)
                let blue = colorComponent(6,2)
                return (red,green,blue,alpha)
            default:
                return (1.0,1.0,1.0,1.0)
            }}
        
        let color = argb()
        return UIColor(red: color.0, green: color.1, blue: color.2, alpha: color.3)
    }
    
    func getImageByRect(rect:CGRect)->UIImage{//获取一张纯色的图片
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(context, self.CGColor)
        CGContextFillRect(context, rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    //MARK: - 通过颜色产生图片
    func imageWithColor() -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        
        CGContextSetFillColorWithColor(context, self.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UITextField{
    func addLeftIcon(img: UIImage?, frame: CGRect, imgSize: CGSize){
        let leftView = UIView()
        leftView.frame = frame
        let imgView = UIImageView()
        imgView.frame = CGRectMake(frame.width-10-imgSize.width, (frame.height - imgSize.height)/2, imgSize.width, imgSize.height)
        imgView.image = img
        leftView.addSubview(imgView)
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.Always
    }
    
    func addLeftBlank(w: CGFloat){
        let leftView = UIView()
        leftView.frame = CGRectMake(0, 0, w, self.frame.height)
        self.leftView = leftView
        self.leftViewMode = UITextFieldViewMode.Always
    }
    
    func addRightIcon(img: UIImage?, frame: CGRect, imgSize: CGSize){
        let leftView = UIView()
        leftView.frame = frame
        let imgView = UIImageView()
        imgView.frame = CGRectMake(frame.width-10-imgSize.width, (frame.height - imgSize.height)/2, imgSize.width, imgSize.height)
        imgView.image = img
        leftView.addSubview(imgView)
        self.rightView = leftView
        self.rightViewMode = UITextFieldViewMode.Always
    }
}
extension UIScrollView{
    func addLoadView(){
        
    }
}

extension UITableViewCell{
    
}

extension UIImage{
    //MARK: - 图片安指定比例缩放大小
    func scaleByPercent(percent:CGFloat) -> UIImage {
        let w = self.size.width*percent
        let h = self.size.height*percent
        return self.scaleFromImage(CGSizeMake(w, h))
    }
    
    //MARK: - 图片安指定尺寸缩放大小
    func scaleFromImage(size:CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func subByWh(wh: CGFloat)->UIImage!{
        let oWh = self.size.width/self.size.height
        
        var w: CGFloat!
        var h: CGFloat!
        var x: CGFloat = 0
        var y: CGFloat = 0
        if wh >= oWh{
            w = self.size.width
            h = w / wh
            y = (self.size.height - h)/2
        }else{
            h = self.size.height
            w = h * wh
            x = (self.size.width - w)/2
        }
        return self.subImage(CGRectMake(x, y, w, h))
    }
    
    func subImage(rect: CGRect)->UIImage!{
        let subImageRef: CGImageRef = CGImageCreateWithImageInRect(self.CGImage, rect)!
        let smallBounds = CGRect(x: 0, y: 0, width: CGImageGetWidth(subImageRef), height: CGImageGetHeight(subImageRef))
        
        UIGraphicsBeginImageContext(smallBounds.size)
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextDrawImage(context, smallBounds, subImageRef)
        let smallImage = UIImage(CGImage: subImageRef)
        UIGraphicsEndImageContext()
        return smallImage
    }
    
}

extension UIImageView{
    func getWidthByHeight(h: CGFloat)->CGFloat{
        if self.image == nil{
            return 0
        }
        let imgW = self.image!.size.width
        let imgH = self.image!.size.height
        return h * imgW/imgH
    }
    
    func getHeightByWidth(w: CGFloat)->CGFloat{
        if self.image == nil{
            return 0
        }
        let imgW = self.image!.size.width
        let imgH = self.image!.size.height
        return w * imgH/imgW
    }
}

extension UIViewController {
    //MARK: 显示viewController
    func showChild(viewController: UIViewController, frame: CGRect) {
        addChildViewController(viewController)
        viewController.view.frame = frame
        view.addSubview(viewController.view)
        viewController.didMoveToParentViewController(self)
    }
    
    //MARK: 隐藏viewController
    func hideChild(viewController: UIViewController) {
        viewController.willMoveToParentViewController(self)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
}


extension UILabel {
    func labelInit(title: String, fontSize: CGFloat, textColor: UIColor, alignmentStyle: NSTextAlignment, addSubView: UIView) -> UILabel {
        self.text = title
        self.font = UIFont(name: appFont, size: fontSize)
        self.textColor = textColor
        self.textAlignment = alignmentStyle
        addSubView.addSubview(self)
        return self
    }
}

extension UITextField {
    func textFieldInit(placeholderString: String, fontSize: CGFloat, textColor: UIColor, alignmentStyle: NSTextAlignment) -> UITextField {
        self.font = UIFont(name: appFont, size: fontSize)
        self.textColor = textColor
        self.textAlignment = alignmentStyle
        self.placeholder = placeholderString
        return self
    }
}

extension UIButton {
    func buttonInitWithTitle(title: String, fontSize: CGFloat, titleColor: UIColor, target: AnyObject, action: Selector) -> UIButton {
        self.titleLabel?.font = UIFont(name: appFont, size: fontSize)
        self.setTitle(title, forState: .Normal)
        self.setTitleColor(titleColor, forState: .Normal)
        self.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return self
    }
    
    func buttonInitWithImage(imgName: String, target: AnyObject, action: Selector) -> UIButton {
        self.setImage(UIImage(named: imgName), forState: .Normal)
        self.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return self
    }
}

