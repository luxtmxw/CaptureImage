//
//  Extension+String.swift
//  CteemoCN
//
//  Created by MrMessy on 16/3/31.
//  Copyright © 2016年 bintao. All rights reserved.
//

//MARK: - ExtensionString

import UIKit
import Foundation

extension String {
    //MARK: 汉字转拼音
    func hanZiToPinYinWithString() -> String {
        let str = NSMutableString(string: self) as CFMutableStringRef
        if CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false) == true {
            if CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false) == true {
                return (str as String).stringByReplacingOccurrencesOfString(" ", withString: "")
            }
        }
        return ""
    }
    
    //MARK: 将时间戳转换成String(格式:yyyy-MM-dd HH:mm)
    func timeTransformToString() -> String {
        if self == "" {
            return ""
        }
        let timeInterval = NSTimeInterval(Int(self)!)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.stringFromDate(date)
    }
    
    //MARK: 将时间戳转换成String(格式:M月-d日 HH:mm)
    func timeTransformToStringWithNoYear() -> String {
        if self == "" {
            return ""
        }
        let timeInterval = NSTimeInterval(Int(self)!)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "M月d日 HH:mm"
        return formatter.stringFromDate(date)
    }
    
    //MARK: 将时间戳转换成String(格式:MM-dd HH:mm)
    func timeTransformToStringWithNoYear2() -> String {
        if self == "" {
            return ""
        }
        let timeInterval = NSTimeInterval(Int(self)!)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd HH:mm"
        return formatter.stringFromDate(date)
    }
    
    func addToPasteboard(){//复制到剪切版
        let pasteboard = UIPasteboard.generalPasteboard()
        pasteboard.string = self
    }
    
    func trim()->String{//去除空格
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    func testReg(pattern:String)->Bool{//验证正则表达式
        var error: NSError?
        let expression: NSRegularExpression?
        do {
            expression = try NSRegularExpression(pattern: pattern, options: .CaseInsensitive)
        } catch let error1 as NSError {
            error = error1
            expression = nil
        }
        let matches = expression?.numberOfMatchesInString(self, options: [], range: NSMakeRange(0, self.characters.count))
        return matches > 0
    }
    
    func stringToInt()->Int{
        if let i = Int(self){
            return i
        }else{
            return 0
        }
    }
    
    func stringToDate() -> NSDate? {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if format.dateFromString(self) == nil {
            format.dateFormat = "yyyy-MM-dd"
        }
        return format.dateFromString(self)
    }
    
    func stringToAge() -> String {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        if format.dateFromString(self) == nil {
            return ""
        }
        return "\(format.dateFromString(self)!.getAge())"
    }
    
    func useNs()->NSString {
        let ns: NSString = self
        return ns
    }
    
    func substringLast()->String{
        var ns = self.useNs()
        if ns.length > 0 {
            ns = ns.substringToIndex(ns.length-1)
        }
        return ns as String
    }
    
    func versionToString() -> String {
        return self.stringByReplacingOccurrencesOfString(".", withString: "")
    }
    
    //MARK: - 数字转换成货币
    func numberToCurrency() -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        return formatter.stringFromNumber(NSNumber(integer: Int(self)!))!
    }
    
    //MARK: - 照片url扩展字段
    /*80*80*/
    func extend_80() -> String {
        return "\(self)-80"
    }
    /*100*100*/
    func extend_100() -> String {
        return "\(self)-100"
    }
    /*150*150*/
    func extend_150() -> String {
        return "\(self)-150"
    }
    
    /*200*200*/
    func extend_200() -> String {
        return "\(self)-200"
    }
    
    /*300*300*/
    func extend_300() -> String {
        return "\(self)-300"
    }
    
    /*h200*/
    func extend_h200() -> String {
        return "\(self)-h200"
    }
    //
    
    //MARK: - 将中文进行编码
    func changeStringToUTF8() -> String {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString(self)
        let str = self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
        return str!
    }
    
    //MARK: - 转义特殊符号
    func EscapeSpecialSymbols() -> String {
        let customAllowedSet =  NSCharacterSet(charactersInString:"\"#%/<>@^`{|}").invertedSet
        let escapedString = self.stringByAddingPercentEncodingWithAllowedCharacters(customAllowedSet)
        return escapedString!
    }
    
    // 距离现在的时间换算
    func pastTimeFromNow() -> String {
        // 为了评论时使用本地数据插入cell
        if (self == "0") {
            return "刚刚"
        }
        // 先转化为时间
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(Int(self)!))
        var different = date.timeIntervalSinceNow
        if different < 0 {
            different = -different
        }
        // days = different / (24 * 60 * 60)
        let dayDifferent = floor(different / 86400)
        let days = Int(dayDifferent)
        
        if (dayDifferent <= 0) {
            if (different < 60) { //小于1分钟
                if (different < 3) { //小于三秒
                    return "刚刚"
                }else { //大于3秒小于1分钟
                    return "\(Int(different))秒前"
                }
            }
            if (different < 3600) { //小于60分钟大于1分钟
                return "\(Int(floor(different / 60)))分钟前"
            }
            if (different < 86400) { //少于1天大于1小时
                return "\(Int(floor(different / 3600)))小时前"
            }
        }else if (days < 7) { //少于1周
            if (days == 1) {
                return "昨天"
            }
            return "\(days)天前"
        }else if days == 7 { //等于1周
            return "一周前"
        }else { //大于一周
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd"
            return dateFormatter.stringFromDate(date)
        }
        return ""
    }
    
    //MARK: - 时间戳转换成星期
    func getWeekDay() -> String {
        let date = NSDate(timeIntervalSince1970: NSTimeInterval(Int(self)!))
        
        let secondsPerDay: NSTimeInterval = 24 * 60 * 60
        let today = NSDate()
        let tomorrow = today.dateByAddingTimeInterval(secondsPerDay)
        let yesterday = today.dateByAddingTimeInterval(-secondsPerDay)
        
        let todayStr = (today.description as NSString).substringToIndex(10)
        let yesterdayStr = (yesterday.description as NSString).substringToIndex(10)
        let tomorrowStr = (tomorrow.description as NSString).substringToIndex(10)
        
        let dateStr = (date.description as NSString).substringToIndex(10)
        
        if dateStr == todayStr {
            let format = NSDateFormatter()
            format.dateFormat = "HH:mm"
            return "今天\(format.stringFromDate(date))"
        }else if dateStr == yesterdayStr {
            let format = NSDateFormatter()
            format.dateFormat = "HH:mm"
            return "昨天\(format.stringFromDate(date))"
        }else if dateStr == tomorrowStr {
            let format = NSDateFormatter()
            format.dateFormat = "HH:mm"
            return "明天\(format.stringFromDate(date))"
        }else {
            var weekdays = ["日","一","二","三","四","五","六"]
            let interval = date.timeIntervalSince1970
            let days = Int(interval / 86400)
            let week = (days - 3) % 7
            let format = NSDateFormatter()
            format.dateFormat = "周\(weekdays[week])M-dd"
            return format.stringFromDate(date)
        }
    }
}