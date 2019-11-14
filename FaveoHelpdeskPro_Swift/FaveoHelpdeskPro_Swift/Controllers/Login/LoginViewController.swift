//
//  LoginViewController.swift
//  FaveoHelpdeskPro_Swift
//
//  Created by mallikarjun on 06/11/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var paswordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // to set black background color mask for Progress view
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
    }

   override func viewDidAppear(_ animated: Bool) {
        
        userNameTextField.becomeFirstResponder()
    }
    
    //MARK: TetxField Delegates methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return textField.resignFirstResponder()
    }
    
    //MARK: Login Button and Login API Call
    @IBAction func loginButtonClicked(_ sender: Any) {
   
        SVProgressHUD.show(withStatus: "Please wait...")
        
        if  userNameTextField.text == "" && paswordTextField.text == "" {
            
            showAlert(title: "Your Helpdesk", message: "Please Enter Username & Password.", vc: self)
            SVProgressHUD.dismiss()
            
        }
        else if  userNameTextField.text == ""{
            showAlert(title: "Your Helpdesk", message: "Please Enter Username.", vc: self)
            SVProgressHUD.dismiss()
        }
        else if  paswordTextField.text == ""{
            showAlert(title: "Your Helpdesk", message: "Please Enter Password.", vc: self)
            SVProgressHUD.dismiss()
        }
        else{
            
            SVProgressHUD.show(withStatus: "Validating Account")
            loginApiCallMethodSimple()
           // loginApiCallMethodWithModel()
        }
            
    }
    
    func loginApiCallMethodSimple(){
        
        let url = webConstant.baseURL + webConstant.authenticate
        
        requestPOSTURL(url, params: ["username":userNameTextField.text as AnyObject, "password": paswordTextField.text as AnyObject], success: { (data) in
            
            print("JSON is: ",data)
            
            
        }) { (error) in
            
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func loginApiCallMethodWithModel(){
        
        let url = webConstant.baseURL + webConstant.authenticate
        
        requestPOSTURL(url, params: ["username":userNameTextField.text as AnyObject, "password": paswordTextField.text as AnyObject], success: { (data) in
            
            print("JSON is: ",data)
            
            
        }) { (error) in
            
            print("Error: \(error.localizedDescription)")
        }
    }
    
}
