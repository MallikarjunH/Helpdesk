//
//  WebServices.swift
//  FaveoHelpdeskPro_Swift
//
//  Created by mallikarjun on 06/11/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

class webConstant:NSObject
{
          static let baseURL = "https://www.stablehelpdesk.faveodemo.com/"
          static let authenticate = "api/v1/authenticate"
}


public func tokenRefreshMethod()
{
    let userDefaults = UserDefaults.standard
    
    var url:String = UserDefaults.standard.string(forKey: "baseURL") ?? ""
    url.append("api/v1/authenticate")
    
    let userName:String = UserDefaults.standard.string(forKey: "userNameValue") ?? ""
    let passWord:String = UserDefaults.standard.string(forKey: "passwordValue") ?? ""
    
    requestPOSTURL(url, params: ["username":userName as AnyObject,
                                 "password":passWord as AnyObject], success: { (data) in
                                    
                                    
                                   // print("JSON is: ",data)
                                    
                                    print("I am in Token Refresh Method in WebServices File")
                                    
                                    if data["message"].exists() && data["success"].exists(){
                                        // failure case
                                        
                                        let msg = data["message"].stringValue
                                        print("Message is: ",msg)
                                        
                                        userDefaults.set(msg, forKey: "valueFromRefreshToken")
                        
                                    }
                                    else if data["success"].exists() && data["data"].exists(){
                                        
                                        let userIdValue = data["data"]["user"]["id"].intValue
                                        userDefaults.set(userIdValue, forKey: "userId")
                                        
                                        let userRole  =  data["data"]["user"]["role"].stringValue
                                        userDefaults.set(userRole, forKey: "userRole")
                                        
                                        var firstName =  data["data"]["user"]["first_name"].stringValue
                                        let lastName  =  data["data"]["user"]["last_name"].stringValue
                                        firstName.append(" ")
                                        firstName.append(lastName)
                                        
                                        let email     =  data["data"]["user"]["email"].stringValue
                                        let profilePicture =  data["data"]["user"]["profile_pic"].stringValue
                                        let tokenValue = data["data"]["token"].stringValue
                                        
                                        userDefaults.set(firstName, forKey: "userFullName")
                                        userDefaults.set(email, forKey: "userEmail")
                                        userDefaults.set(profilePicture, forKey: "userProfilePic")
                                        userDefaults.set(tokenValue, forKey: "token")
                                        
                                        userDefaults.set("LoggedIn", forKey: "loginValue")
                                        userDefaults.synchronize()
                                        
                                        
                                    }

                                    
    }) { (error) in
        print("Error From Token Refresh Method: \(error.localizedDescription)")
        //Example: After timeout error - The request timed out.
        let error1 = error.localizedDescription
        
        if error1 == "A server with the specified hostname could not be found."{
            
            UserDefaults.standard.set(error1, forKey: "valueFromRefreshToken")
        }
        SVProgressHUD.dismiss()
    }
    
}

public func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
    
    if Connectivity.isConnectedToInternet {
        
        // SVProgressHUD.show()
        Alamofire.request(strURL, method: .post, parameters: params, encoding: URLEncoding.default).responseJSON { responseObject in
            
            
            // print(responseObject.request!)
            
            if responseObject.result.isSuccess {
                //  SVProgressHUD.dismiss()
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                //  SVProgressHUD.dismiss()
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }else{
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Your Helpdesk", message: "Please,check your internet connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
    }
}

public func requestGETURL(_ strURL: String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void) {
    
    if Connectivity.isConnectedToInternet {
        // SVProgressHUD.show()
        
        Alamofire.request(strURL, method: .get, parameters: params, encoding: URLEncoding.default).responseJSON { (responseObject) -> Void in
            
            //  print(responseObject)
            
            if responseObject.result.isSuccess {
                //    SVProgressHUD.dismiss()
                let resJson = JSON(responseObject.result.value!)
                success(resJson)
            }
            if responseObject.result.isFailure {
                //    SVProgressHUD.dismiss()
                let error : Error = responseObject.result.error!
                failure(error)
                
            }
        }
    }else{
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
            let alert = UIAlertController(title: "Your Helpdesk", message: "Please check your internet connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
}



    public func requestPATCHURL(_ strURL : String, params : [String : AnyObject]?, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        if Connectivity.isConnectedToInternet {
            
            // SVProgressHUD.show()
            Alamofire.request(strURL, method: .patch, parameters: params, encoding: URLEncoding.default).responseJSON { responseObject in
                
                
                // print(responseObject.request!)
                
                if responseObject.result.isSuccess {
                    //  SVProgressHUD.dismiss()
                    let resJson = JSON(responseObject.result.value!)
                    success(resJson)
                }
                if responseObject.result.isFailure {
                    //  SVProgressHUD.dismiss()
                    let error : Error = responseObject.result.error!
                    failure(error)
                }
            }
        }else{
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                let alert = UIAlertController(title: "Your Helpdesk", message: "Please,check your internet connection", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action)
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                
            }
        }
    }
