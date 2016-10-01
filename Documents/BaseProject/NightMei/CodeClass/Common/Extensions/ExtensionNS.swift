
// MARK: - Foundation
import Foundation
import AssetsLibrary
import UIKit

extension NSDate {
    
    // MARK: Timestamp - 时间戳
    
    /// **timestamp** 时间戳字符串，纯数字组成
    class func dateFromTimestampString(timestamp: String) -> NSDate! {
        let time = Int(timestamp)!
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(time))
        return date
    }
    
    class func currentLocalTimestamp() -> String! {
        let timezone = NSTimeZone.systemTimeZone()
        return currentTimestamp(timezone: timezone)
    }
    
    class func currentGreenwichTimestamp() -> String! {
        let timezone = NSTimeZone(name: "Europe/London")!
        return currentTimestamp(timezone: timezone)
    }
    
    class func currentTimestamp(timezone timezone: NSTimeZone) -> String! {
        let date = NSDate()
        return timestamp(date: date, timezone: timezone)
    }
    
    class func timestamp(date date: NSDate, timezone: NSTimeZone) -> String! {
        let interval = NSTimeInterval(timezone.secondsFromGMTForDate(date))
        let localeDate = date.dateByAddingTimeInterval(interval)
        let timestamp = NSString.localizedStringWithFormat("%ld", Int64(localeDate.timeIntervalSince1970))
        return String(timestamp)
    }
    
    class var currentDateStringWithoutTimeZoneString: String {
        return dateToString(NSDate(), dateFormat: "yyyy-MM-dd HH:mm:ss")
    }
    
    static func dateToString(date: NSDate, dateFormat: String) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = NSLocale(localeIdentifier: NSCalendarIdentifierGregorian)
        return formatter.stringFromDate(date)
    }
    
    func isToday()->Bool{// 判断日期是否是今天
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.stringFromDate(self) == format.stringFromDate(NSDate())
    }
    func isYestoday()->Bool{// 判断日期是否是昨天
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.stringFromDate(self) == format.stringFromDate(NSDate().dateByAddingTimeInterval(-24*60*60))
    }
    
    
//    // 判断日期是否小于一分钟
//    func isLessThanOneMinute() -> Bool {
//        let format = NSDateFormatter()
//        format.dateFormat = "ss"
//        return format.stringFromDate(self) == format.stringFromDate(NSDate().dateByAddingTimeInterval(-60))
//    }
//    
//    // 判断日期是否小于1小时
//    func isLessThanOnehour() -> Bool {
//        let format = NSDateFormatter()
//        format.dateFormat = "mm"
//        return format.stringFromDate(self) == format.stringFromDate(NSDate().dateByAddingTimeInterval(-60*60))
//    }
//    
//    // 判断日期是否小于一天
//    func isLessThanOneDay() -> Bool {
//        let format = NSDateFormatter()
//        format.dateFormat = "HH"
//        return format.stringFromDate(self) == format.stringFromDate(NSDate().dateByAddingTimeInterval(-24*60*60))
//    }
//    
//    // 判断日期是否小于一个星期
//    func isLessThanOneWeek() -> Bool {
//        let format = NSDateFormatter()
//        format.dateFormat = "yyyy-MM-dd"
//        return format.stringFromDate(self) == format.stringFromDate(NSDate().dateByAddingTimeInterval(-7*24*60*60))
//    }
    
    func countDownToString(text: String?="") -> String {
        if self.timeIntervalSinceNow <= 0 { //时间已到
            return "00分00秒\(text!)"
        }else { //时间未到
            if self.timeIntervalSinceNow >= 86400 { //距比赛开始超过一天的时间
                let day = Int(floor(self.timeIntervalSinceNow / 86400))
                let result = "\(day>=10 ? "\(day)" : "0\(day)")天\(text!)"
                return result
            }else { //距比赛开始小于一天的时间
                let hour = Int(floor(self.timeIntervalSinceNow / 3600))
                let minute = Int(floor((self.timeIntervalSinceNow % 3600) / 60))
                let second = Int(floor(((self.timeIntervalSinceNow % 3600) % 60)) % 60)
                let result = "\(hour>=10 ? "\(hour)" : "0\(hour)")时\(minute>=10 ? "\(minute)" : "0\(minute)")分\(second>=10 ? "\(second)" : "0\(second)")秒\(text!)"
                return result
            }
        }
    }
    
    func countDown(font: UIFont) -> NSAttributedString {
        if self.timeIntervalSinceNow <= 0 { //比赛时间已到
            let attributedString = NSMutableAttributedString(string: "距下一轮:00 时 00 分 00 秒")
            attributedString.addAttribute(NSForegroundColorAttributeName, value: Color_FF9500, range: NSMakeRange(5, 2))
            attributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(5, 2))
            attributedString.addAttribute(NSForegroundColorAttributeName, value: Color_FF9500, range: NSMakeRange(10, 2))
            attributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(10, 2))
            return attributedString
        }else { //比赛未开始
            if self.timeIntervalSinceNow >= 86400 { //距比赛开始还有超过一天的时间
                let day = Int(floor(self.timeIntervalSinceNow / 86400))
                let attributedString = NSMutableAttributedString(string: "距下一轮:\(day>=10 ? "\(day)" : "0\(day)") 天")
                attributedString.addAttribute(NSForegroundColorAttributeName, value: Color_FF9500, range: NSMakeRange(5, 2))
                attributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(5, 2))
                return attributedString
            }else { //距比赛开始还有小于一天的时间
                let hour = Int(floor(self.timeIntervalSinceNow / 3600))
                let minute = Int(floor((self.timeIntervalSinceNow % 3600) / 60))
                let second = Int(floor(((self.timeIntervalSinceNow % 3600) % 60)) % 60)
                let attributedString = NSMutableAttributedString(string: "距下一轮:\(hour>=10 ? "\(hour)" : "0\(hour)") 时 \(minute>=10 ? "\(minute)" : "0\(minute)") 分 \(second>=10 ? "\(second)" : "0\(second)") 秒")
                attributedString.addAttribute(NSForegroundColorAttributeName, value: Color_FF9500, range: NSMakeRange(5, 2))
                attributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(5, 2))
                attributedString.addAttribute(NSForegroundColorAttributeName, value: Color_FF9500, range: NSMakeRange(10, 2))
                attributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(10, 2))
                attributedString.addAttribute(NSForegroundColorAttributeName, value: Color_FF9500, range: NSMakeRange(15, 2))
                attributedString.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(15, 2))
                return attributedString
            }
        }
    }
    
    func getAstro() -> String {
        let m = Int(self.getMonth())
        let d = Int(self.getDay())
        var s = ["魔羯","水瓶","双鱼","白羊","金牛","双子","巨蟹","狮子","处女","天秤","天蝎","射手","魔羯"]
        var arr = [20,19,21,21,21,22,23,23,23,23,22,22]
        let index = m! - (d < (arr[m!-1]) ? 1 : 0)
        return "\(s[index])"
    }
    
    //MARK: - 获取年龄
    func getAge()->Int{
        if self.getMonth() < NSDate().getMonth() || (self.getMonth() == NSDate().getMonth() && self.getDay() <= NSDate().getDay()){
            return Int(NSDate().getYear())! - Int(self.getYear())!
        }else{
            return Int(NSDate().getYear())! - Int(self.getYear())!-1
        }
    }
    
    
    func getYear()->String{
        let format = NSDateFormatter()
        format.dateFormat = "yyyy"
        return format.stringFromDate(self)
    }
    func getMonth()->String{
        let format = NSDateFormatter()
        format.dateFormat = "MM"
        return format.stringFromDate(self)
    }
    func getDay()->String{
        let format = NSDateFormatter()
        format.dateFormat = "dd"
        return format.stringFromDate(self)
    }
    
    
    //..时间人性化
    //    func humDate() -> String{
    //        return UtilController.showTimeStr(self)
    //    }
    func showTimeMD() -> String{
        let format = NSDateFormatter()
        format.dateFormat = "MM-dd"
        return format.stringFromDate(self)
    }
    func noticeTime() -> String{
        let format = NSDateFormatter()
        if self.isToday(){
            format.dateFormat = "HH:mm"
        }else if self.isYestoday(){
            format.dateFormat = "昨天"
        }else{
            format.dateFormat = "MM-dd"
        }
        return format.stringFromDate(self)
    }
    
    // 距离现在的时间换算
    class func pastTimeFromNow(timeCount: String) -> String {
        // 为了评论时使用本地数据插入cell
        if (timeCount == "0") {
            return "刚刚"
        }
        
        // 先转化为时间
        let time = Int(timeCount)!
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(time))
        
        // 判断是之前还是之后
        var suffix = "后"
        
        var different = date.timeIntervalSinceNow // Date(self)
        if different < 0 {
            different = -different
            suffix = "前"
        }
        
        // days = different / (24 * 60 * 60)
        let dayDifferent = floor(different / 86400)
        
        let days = Int(dayDifferent)
        _ = Int(ceil(dayDifferent / 7))
        _ = Int(ceil(dayDifferent / 30))
//        let years = Int(ceil(dayDifferent / 365))
        
        // 今天
        if (dayDifferent <= 0) {
            // 少于60秒
            if (different < 60) {
                if (different < 3) {
                    return "刚刚"
                } else {
                    return "\(Int(different))秒\(suffix)"
                }
            }
            
            // 少于120秒 => 一分钟加少于60秒
            if (different < 120) {
                return "1分钟\(suffix)"
            }
            
            // 少于60分钟
            if (different < 60 * 60) {
                return "\(Int(floor(different / 60)))分钟\(suffix)"
            }
            
            // 少于60 * 2分钟 => 一小时加少于60分钟
            if (different < 7200) {
                return "1小时\(suffix)"
            }
            
            // 少于1天
            if (different < 86400) {
                return "\(Int(floor(different / 3600)))小时\(suffix)"
            }
        }
            // 少于1周
        else if (days < 7) {
            if (days == 1) {
                return "昨天"
            }
            return "\(days)天\(suffix)"
        }
        else if days == 7 {
            return "一周前"
        }
//            // 大于1周少于1个月
//        else if (weeks < 4) {
//            return "\(weeks)周\(suffix)"
//        }
//            // 大于1个月少于1年
//        else if (months < 12) {
//            return "\(months)个月\(suffix)"
//        }
            // 大于1年
        else {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd"
            return dateFormatter.stringFromDate(date)
        }
        return self.description()
    }
    
    func dateToYmd() -> String{
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        return format.stringFromDate(self)
    }
    func dateIsWeek() -> Int{
        let interval = self.timeIntervalSince1970
        let days = Int(interval / 86400)
        return (days - 3) % 7
    }
    
    //MARK: 时间人性化
    func timeHumanization() -> String {
        // 判断是之前还是之后
        var suffix = "后"
        
        var different = self.timeIntervalSinceNow // Date(self)
        if different < 0 {
            different = -different
            suffix = "前"
        }
        
        // days = different / (24 * 60 * 60), take the floor value
        let dayDifferent = floor(different / 86400)
        
        let days = Int(dayDifferent)
        let weeks = Int(ceil(dayDifferent / 7))
        _ = Int(ceil(dayDifferent / 30))
        let years = Int(ceil(dayDifferent / 365))
        // It belongs to today
        if (dayDifferent <= 0) {
            // lower than 60 seconds
            if (different < 60) {
                return "刚刚"
            }
            
            // lower than 120 seconds => one minute and lower than 60 seconds
            if (different < 120) {
                return "1分钟\(suffix)"
            }
            
            // lower than 60 minutes
            if (different < 60 * 60) {
                return "\(Int(floor(different / 60)))分钟\(suffix)"
            }
            
            // lower than 60 * 2 minutes => one hour and lower than 60 minutes
            if (different < 7200) {
                return "1小时\(suffix)"
            }
            
            // lower than one day
            if (different < 86400) {
                return "\(Int(floor(different / 3600)))小时\(suffix)"
            }
        }
        // lower than one week
        else if (days < 7) {
            if days == 1 {
                return "昨天"
            }
            return "\(days)天\(suffix)"
        }
        // lager than one week but lower than a month
        else if (weeks < 4) {
            if weeks == 1 {
                return "1周\(suffix)"
            }else {
                let format = NSDateFormatter()
                format.dateFormat = "MM-dd"
                return format.stringFromDate(self)
            }
        }
        else if years > 1 {
            let format = NSDateFormatter()
            format.dateFormat = "yy-MM-dd"
            return format.stringFromDate(self)
        }
        else {
            let format = NSDateFormatter()
            format.dateFormat = "MM-dd"
            return format.stringFromDate(self)
        }
        return self.description
    }
    
    //MARK: - NSDate转换成String
    func dateToString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = NSTimeZone.localTimeZone()
        return formatter.stringFromDate(self)
    }
    
    //MARK: - NSDate转换成String
    func dateAndTimeToString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        formatter.timeZone = NSTimeZone.localTimeZone()
        return formatter.stringFromDate(self)
    }
}

//MARK: - ExtensionNSObject
extension NSObject {
    /**
    在主队列上延迟指定的时间执行闭包的操作，用于更新界面
    
    - parameter seconds: 秒数，类型为Double
    - parameter closure: 闭包，将在主队列上执行
    */
    func delayWithSeconds(seconds: Double, closure: () -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(seconds * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    //MARK: 延时方法
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    //MARK: 使用NSUserDefaults储存列表信息
    func saveDataByUserDefaults(targetId: String, dataName: String, dataPic: String) {
        let infoDic = [
            "dataId"   : targetId,
            "dataName" : dataName,
            "dataPic"  : dataPic
        ]
        NSUserDefaults.standardUserDefaults().setObject(infoDic, forKey: targetId)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //MARK: 使用NSUserDefaults储存列表信息
    func saveDataByUserDefaultsType(targetId: String, dataName: String, dataPic: String, type: String?="") {
        let infoDic: [String: AnyObject] = [
            "dataId"   : targetId,
            "dataName" : dataName,
            "dataPic"  : dataPic,
            "dataType" : type!
        ]
        NSUserDefaults.standardUserDefaults().setObject(infoDic , forKey: targetId)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}

extension NSUserDefaults {
    
    static func defaultsRegisterDefaults(registrationDictionary: [NSObject : AnyObject]) -> NSUserDefaults {
        //        NSUserDefaults.standardUserDefaults().registerDefaults(registrationDictionary)
        return NSUserDefaults.standardUserDefaults()
    }
    
    static func defaultsSetValue<T: AnyObject>(value: T?, forKey defaultName: String) -> NSUserDefaults.Type {
        let ud = NSUserDefaults.standardUserDefaults()
        
        switch value {
        case let realValue as Int:
            ud.setInteger(realValue, forKey: defaultName)
        case let realValue as Float:
            ud.setFloat(realValue, forKey: defaultName)
        case let realValue as Double:
            ud.setDouble(realValue, forKey: defaultName)
        case let realValue as Bool:
            ud.setBool(realValue, forKey: defaultName)
        case let realValue as NSURL:
            ud.setURL(realValue, forKey: defaultName)
        default:
            ud.setObject(value, forKey: defaultName)
        }
        
        return self
    }
    
    static func defaultsValueForKey<T>(name: String, inout value: T?) -> NSUserDefaults.Type {
        let ud = NSUserDefaults.standardUserDefaults()
        
        switch T.self {
        case is Int.Type:
            value = ud.integerForKey(name) as? T
        case is Float.Type:
            value = ud.floatForKey(name) as? T
        case is Double.Type:
            value = ud.doubleForKey(name) as? T
        case is Bool.Type:
            value = ud.boolForKey(name) as? T
        case is NSURL.Type:
            value = ud.URLForKey(name) as? T
        case is String.Type:
            value = ud.stringForKey(name) as? T
        case is NSData.Type:
            value = ud.dataForKey(name) as? T
        default:
            value = ud.objectForKey(name) as? T
        }
        return self
    }
    
    static func defaultsSynchronize() -> Bool {
        return NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}

extension NSBundle {
    class func pathForResource(name: String, type: String?) -> String? {
        return NSBundle.mainBundle().pathForResource("minus", ofType: ".png")
    }
}

extension NSDictionary{
    
    func getIntByKey(key: String)->Int{
        var returnStr = -101
        if let str = self[key] as? Int{
            returnStr = str
        }
        return returnStr
    }
    
    func getStringByKey(key: String)->String{
        var returnStr: String = ""
        if let str = self[key] as? String{
            returnStr = str
        }
        return returnStr
    }
    
    func getIntOrStr(key: String)->String{
        var returnStr: String = ""
        if let str = self[key] as? String{
            returnStr = str
        }
        if let str = self[key] as? Int{
            returnStr = "\(str)"
        }
        return returnStr
    }
    
    
    func getStringByKeys(keys: [String])->String{
        var returnStr: String = ""
        for key in keys{
            if let str = self[key] as? String{
                returnStr = str
            }
        }
        return returnStr
    }
    
    
}

//Mark: 根据6尺寸适配...
let scaleH6 = UIScreen.mainScreen().bounds.size.height/667.0
let scaleW6 = UIScreen.mainScreen().bounds.size.width/375.0
//scale为按原尺寸大小
extension CGFloat{
    func Sh(scale:CGFloat = 0)->CGFloat{
        if scale >= CGFloat(self){
            return CGFloat(self)
        }
        return (CGFloat(self)-scale) * scaleH6 + scale
    }
    
    func Sw(scale:CGFloat = 0)->CGFloat{
        if scale >= CGFloat(self){
            return CGFloat(self)
        }
        return (CGFloat(self)-scale) * scaleW6 + scale
    }
}
//MARK: - ExtensionDouble
extension Double {
    func Sh(scale:CGFloat = 0)->CGFloat{
        if scale >= CGFloat(self){
            return CGFloat(self)
        }
        return (CGFloat(self)-scale) * scaleH6 + scale
    }
    
    func Sw(scale:CGFloat = 0)->CGFloat{
        if scale >= CGFloat(self){
            return CGFloat(self)
        }
        return (CGFloat(self)-scale) * scaleW6 + scale
    }
    
    //MARK: Double型保留小数点后几位
    func doubleToDecimalPoint(several: Int) -> Double {
        let str = String(format: "%.\(several)f", self)
        return Double(str)!
    }
    
    //MARK: Double型保留小数点后几位
    func floatToDecimalPoint(several: Int) -> Float {
        let str = String(format: "%.\(several)f", self)
        return Float(str)!
    }
}

extension Int{
    func Sh(scale:CGFloat = 0)->CGFloat{
        if scale >= CGFloat(self){
            return CGFloat(self)
        }
        return (CGFloat(self)-scale) * scaleH6 + scale
    }
    
    func Sw(scale:CGFloat = 0)->CGFloat{
        if scale >= CGFloat(self){
            return CGFloat(self)
        }
        return (CGFloat(self)-scale) * scaleW6 + scale
    }
}
//Mark...end

extension Float {
    //MARK: Float型保留小数点后几位
    func FloatToDecimalPoint(several: Int) -> Float {
        let str = String(format: "%.\(several)f", self)
        return Float(str)!
    }
}

