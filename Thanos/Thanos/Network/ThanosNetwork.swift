//
//  PaveNetwork.swift
//  PAVE
//
//  Created by kakashi on 3/19/20.
//  Copyright © 2020 Discovery Loft. All rights reserved.
//

import Foundation

struct ThanosNetwork {
    private static let endpoint = "https://session-dev.paveapi.com/api%@"
    
    static func upload(data: Data, params: [String:String], path: String, success: @escaping (_ result: AnyObject) -> Void, fail: ((_ error: ThanosError) -> Void)?) {
        var url = String(format: endpoint, path)
        if path.contains("http") || path.contains("https") {
            url = path
        }
        
        AF.upload(multipartFormData: { (multipart) in
            let code = params["photo_code"]!
            multipart.append(data, withName: "image", fileName: "IMAG\(code).jpg", mimeType: "image/jpeg")
            multipart.append(params["session_key"]!.data(using: String.Encoding.utf8)!, withName: "session_key")
            multipart.append(code.data(using: String.Encoding.utf8)!, withName: "photo_code")
        }, to: URL(string: url)!, method: .post, headers: getHeader()).responseJSON { (response) in
            responseJson(response: response, withSuccessAction: success, failAction: fail)
        }
    }
    
    static func request(_ method: HTTPMethod, path: String, body: [String:Any]? = nil, success: @escaping (_ result: AnyObject) -> Void, fail: ((_ err: ThanosError) -> Void)?) {
        var url = String(format: endpoint, path)
        if path.contains("http") || path.contains("https") {
            url = path
        }
        
        AF.request(URL(string: url)!, method: method, parameters: body, encoding: URLEncoding.httpBody, headers: getHeader(), interceptor: nil).responseJSON { (response) in
            responseJson(response: response, withSuccessAction: success, failAction: fail)
        }
    }
    
    private static func responseJson(response: AFDataResponse<Any>,
                         withSuccessAction success: @escaping (_ result: AnyObject) -> Void,
                         failAction fail: ((_ err: ThanosError) -> Void)?) {
        if let code = response.response?.statusCode, code != 200 && code != 201 {
            let msg = (response.value as AnyObject)["message"] as? String ?? "Oops something went wrong"
            fail?(ThanosError(code: code, message: msg))
            return
        }
        
        if let value = response.value {
            success(value as AnyObject)
        }
    }
    
    private static func getHeader() -> HTTPHeaders {
        return [:]
    }
}
