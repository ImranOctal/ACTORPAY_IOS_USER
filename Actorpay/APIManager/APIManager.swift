//
//  APIManager.swift
//  Actorpay
//
//  Created by iMac on 20/12/21.
//

import Foundation
import Alamofire
import SwiftyJSON

typealias APICompletionBlock = (_ respone:APIResponse) -> Void
//
struct APIResponse {
    
    var success = false
    var message = ""
    var response:JSON
    
    static func createAPIResponse(_ success:Bool,_ message:String = "", _ response:JSON = JSON.null) -> APIResponse {
        return APIResponse.init(success: success, message: message, response: response)
    }
    
    static func createSuccessAPIResponse(_ message:String = "",_ response:JSON = JSON.null) -> APIResponse {
        return APIResponse.init(success: true, message: message, response: response)
    }
    
    static func createFailureAPIResponse(_ message:String = "", _ response:JSON = JSON.null) -> APIResponse {
        return  APIResponse.init(success: false, message: message, response: response)
    }
    
}


class APIManager {
    
    static var shared = APIManager()
    var manager = Session.default
    var absoluteUrl = ""
    
    func getMethod(method : HTTPMethod = .get, url:String, parameters:Parameters = [:], success:@escaping APICompletionBlock){
        showLoading()
        absoluteUrl = APIBaseUrlPoint.localHostBaseURL.rawValue + url
        let headers: HTTPHeaders = [.authorization(bearerToken: AppManager.shared.token)]
        var param:Parameters? = parameters
        if method == .get {
            if let urlParameters = param {
                if !(urlParameters.isEmpty) {
                    absoluteUrl.append("?")
                    var array:[String] = []
                    let _ = urlParameters.map { (key, value) -> Bool in
                        let str = key + "=" +  String(describing: value)
                        array.append(str)
                        return true
                    }
                    absoluteUrl.append(array.joined(separator: "&"))
                }
            }
            param = nil
        }
        print(absoluteUrl)
        manager.request(absoluteUrl, method: method, /*parameters: parameters, encoding: JSONEncoding.default,*/ headers: headers)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let retrivedResult):
                    dissmissLoader()
                    let responseJSON = JSON(retrivedResult)
                    let message = responseJSON["message"].stringValue
                    success(APIResponse.createSuccessAPIResponse(message, responseJSON))
                    break
                case .failure(let errorGiven):
                    dissmissLoader()
                    let message = errorGiven.errorDescription ?? ""
                    success(APIResponse.createFailureAPIResponse(message))
                    print(errorGiven.errorDescription ?? "")
                    break
                }
            })
    }
    
    func getMethodWithoutAuth(method : HTTPMethod = .get, url:String, parameters:Parameters = [:], success:@escaping APICompletionBlock){
        showLoading()
        absoluteUrl = APIBaseUrlPoint.localHostBaseURL.rawValue + url
//        let headers: HTTPHeaders = [.authorization(bearerToken: AppManager.shared.token)]
        var param:Parameters? = parameters
        if method == .get {
            if let urlParameters = param {
                if !(urlParameters.isEmpty) {
                    absoluteUrl.append("?")
                    var array:[String] = []
                    let _ = urlParameters.map { (key, value) -> Bool in
                        let str = key + "=" +  String(describing: value)
                        array.append(str)
                        return true
                    }
                    absoluteUrl.append(array.joined(separator: "&"))
                }
            }
            param = nil
        }
        print(absoluteUrl)
        manager.request(absoluteUrl, method: method /*parameters: parameters, encoding: JSONEncoding.default,*/)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let retrivedResult):
                    dissmissLoader()
                    let responseJSON = JSON(retrivedResult)
                    let message = responseJSON["message"].stringValue
                    success(APIResponse.createSuccessAPIResponse(message, responseJSON))
                    break
                case .failure(let errorGiven):
                    dissmissLoader()
                    let message = errorGiven.errorDescription ?? ""
                    success(APIResponse.createFailureAPIResponse(message))
                    print(errorGiven.errorDescription ?? "")
                    break
                }
            })
    }
    
    func request(method : HTTPMethod, url:String, parameters:Parameters, success:@escaping APICompletionBlock){
        absoluteUrl = APIBaseUrlPoint.localHostBaseURL.rawValue + url
        print(absoluteUrl)
        manager.request(absoluteUrl, method: method, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let retrivedResult):
                    let responseJSON = JSON(retrivedResult)
                    let message = responseJSON["message"].stringValue
                    success(APIResponse.createSuccessAPIResponse(message, responseJSON))
                    break
                case .failure(let errorGiven):
                    let message = errorGiven.errorDescription ?? ""
                    success(APIResponse.createFailureAPIResponse(message))
                    break
                }
            })
    }
    
    
    func request2(method : HTTPMethod, url:String, parameters:Parameters, success:@escaping APICompletionBlock){
        absoluteUrl = APIBaseUrlPoint.localHostBaseURL.rawValue + url
        print(absoluteUrl)
        let headers: HTTPHeaders = [.authorization(bearerToken: AppManager.shared.token)]
        var param:Parameters? = parameters
        if method == .put {
            if let urlParameters = param {
                if !(urlParameters.isEmpty) {
                    absoluteUrl.append("?")
                    var array:[String] = []
                    let _ = urlParameters.map { (key, value) -> Bool in
                        let str = key + "=" +  String(describing: value)
                        array.append(str)
                        return true
                    }
                    absoluteUrl.append(array.joined(separator: "&"))
                }
            }
            param = nil
        }
        manager.request(absoluteUrl, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let retrivedResult):
                    let responseJSON = JSON(retrivedResult)
                    let message = responseJSON["message"].stringValue
                    success(APIResponse.createSuccessAPIResponse(message, responseJSON))
                    break
                case .failure(let errorGiven):
                    dissmissLoader()
                    let message = errorGiven.errorDescription ?? ""
                    success(APIResponse.createFailureAPIResponse(message))
                    break
                }
            })
    }
    
    func putRequest(method : HTTPMethod = .put, url:String, parameters:Parameters, success:@escaping APICompletionBlock){
        absoluteUrl = APIBaseUrlPoint.localHostBaseURL.rawValue + url
        print(absoluteUrl)
        let headers: HTTPHeaders = [.authorization(bearerToken: AppManager.shared.token)]
//        var param:Parameters? = parameters
//        if method == .put {
//            if let urlParameters = param {
//                if !(urlParameters.isEmpty) {
//                    absoluteUrl.append("?")
//                    var array:[String] = []
//                    let _ = urlParameters.map { (key, value) -> Bool in
//                        let str = key + "=" +  String(describing: value)
//                        array.append(str)
//                        return true
//                    }
//                    absoluteUrl.append(array.joined(separator: "&"))
//                }
//            }
//            param = nil
//        }
        manager.request(absoluteUrl, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let retrivedResult):
                    let responseJSON = JSON(retrivedResult)
                    let message = responseJSON["message"].stringValue
                    success(APIResponse.createSuccessAPIResponse(message, responseJSON))
                    break
                case .failure(let errorGiven):
                    dissmissLoader()
                    let message = errorGiven.errorDescription ?? ""
                    success(APIResponse.createFailureAPIResponse(message))
                    break
                }
            })
    }
    
    func uploadData(method : HTTPMethod,url:String,parameters:Parameters, imgData:Data?, imageKey:String, success:@escaping (APICompletionBlock)) {
        
        let headers: HTTPHeaders = [.authorization(bearerToken: AppManager.shared.token)]
        print(headers)
        let absoluteUrl = APIBaseUrlPoint.localHostBaseURL.rawValue + url
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in parameters {
                var jsonString: String?
                if let theJSONData = try? JSONSerialization.data(
                    withJSONObject: value,
                    options: []) {
                    let theJSONText = String(data: theJSONData,
                                             encoding: .ascii)
                    print("JSON string = \(theJSONText!)")
                    jsonString = theJSONText!
                }
                multipartFormData.append(((jsonString ?? "") as String).data(using: String.Encoding.utf8)!, withName: key as String, mimeType: "application/json")
            }
            if let data = imgData {
                multipartFormData.append(data, withName: imageKey, fileName: "file.jpg", mimeType: "image/jpg")
            }
        }, to: absoluteUrl, method: method, headers: headers).uploadProgress { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }
        .downloadProgress { progress in
            print("Download Progress: \(progress.fractionCompleted)")
        }.responseJSON { (response) in
            switch response.result {
            case .success(let retrivedResult):
                let responseJSON = JSON(retrivedResult)
                let message = responseJSON["message"].stringValue
                success(APIResponse.createSuccessAPIResponse(message, responseJSON))
                break
            case .failure(let errorGiven):
                dissmissLoader()
                let message = errorGiven.errorDescription ?? ""
                success(APIResponse.createFailureAPIResponse(message))
                break
            }
        }
        
    }
    
    func mainRequest(method : HTTPMethod, url:String, urlParameters:Parameters = [:], bodyParameter: Parameters = [:], needUserToken:Bool = false, success:@escaping APICompletionBlock) {
        
        absoluteUrl = APIBaseUrlPoint.localHostBaseURL.rawValue + url
        let headers: HTTPHeaders =  needUserToken ? [.authorization(bearerToken: AppManager.shared.token)] : []
        
        var urlParams: Parameters? = urlParameters
        if let urlParameters = urlParams {
            if !(urlParameters.isEmpty) {
                absoluteUrl.append("?")
                var array:[String] = []
                let _ = urlParameters.map { (key, value) -> Bool in
                    let str = key + "=" +  String(describing: value)
                    array.append(str)
                    return true
                }
                absoluteUrl.append(array.joined(separator: "&"))
            }
        }
        //urlParams = nil
        print(headers)
        print("absoluteUrl")
        print(absoluteUrl)
        print("bodyParameter")
        print(bodyParameter)
        manager.request(absoluteUrl, method: method, parameters: bodyParameter, encoding: JSONEncoding.default, headers: headers)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let retrivedResult):
                    let responseJSON = JSON(retrivedResult)
                    print("responseJSON")
                    print(responseJSON)
                    let message = responseJSON["message"].stringValue
                    success(APIResponse.createSuccessAPIResponse(message, responseJSON))
                    break
                case .failure(let errorGiven):
                    dissmissLoader()
                    let message = errorGiven.errorDescription ?? ""
                    success(APIResponse.createFailureAPIResponse(message))
                    break
                }
            })
    }
}
