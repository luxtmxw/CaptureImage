import UIKit
import Alamofire
import SwiftyJSON


let AlamofireInstance = ServiceManager.sharedInstance

class ServiceManager: NSObject {
    static let sharedInstance = ServiceManager()
    var response: (Response<AnyObject, NSError> -> Void)!

    func request(method: Alamofire.Method,
        _ URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = [
            "Content-Type" : "application/json",
            "Authorization" : "Bearer"// \(UserInstance.user.token)
        ],
        completionHandler: (response: NSHTTPURLResponse?, data: Result<AnyObject, NSError>) -> Void)
        ->Self
    {
        Alamofire.Manager.mcInstance.request(method, URLString, parameters: parameters, encoding: encoding, headers: headers).responseJSON{response in
            if let error = response.result.error{
                self.handleErrorByCode(error.code)
            }
//            RuningSai.sharedInstance.dismissWithAnimation()
            completionHandler(response: response.response, data: response.result)
        }
        return self
    }
    
    func requestNoHeader(method: Alamofire.Method,
        _ URLString: URLStringConvertible,
        parameters: [String: AnyObject]? = nil,
        encoding: ParameterEncoding = .URL,
        headers: [String: String]? = nil,
        completionHandler: (response: NSHTTPURLResponse?, data: Result<AnyObject, NSError>) -> Void)
    {
        Alamofire.Manager.mcInstance.request(method, URLString, parameters: parameters, encoding: encoding, headers: headers).responseJSON{response in
            if let error = response.result.error{
                self.handleErrorByCode(error.code)
            }
            completionHandler(response: response.response, data: response.result)
        }
    }
    
    //网络请求错误处理
    func handleErrorByCode(code: Int){
//        RuningSai.sharedInstance.dismissWithAnimation { () -> Void in
            if code == -1001{
//                CustomAlertView.shareInstance.showAlert("提示",content: "服务器连接超时", disappear: nil)
            }else{
//                CustomAlertView.shareInstance.showAlert("提示",content: "服务器连接错误", disappear: nil)
//            }
        }
    }
}

extension Alamofire.Manager{
    //设置超时参数...
    public static let mcInstance: Alamofire.Manager = {
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 15
        return Manager(configuration: configuration)
    }()
}
