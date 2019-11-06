//
//  Utils.swift
//  FaveoHelpdeskPro_Swift
//
//  Created by mallikarjun on 06/11/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

import Foundation
import UIKit

public  func showAlert(title:String, message:String, vc: UIViewController) {
    
    let alertView1 = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertView1.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
    vc.present(alertView1,animated: true,completion: nil)
}

