//
//  LoginViewController.m
//  FaveoHelpdeskPro_ObjC
//
//  Created by mallikarjun on 23/10/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)loginButtonClicked:(id)sender {
    
    if ([_userNameTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""]){
        
       //show alert
        
    }else{
        
        NSString *url = [NSString stringWithFormat:@"https://www.stablehelpdesk.faveodemo.com/api/v1/authenticate"];
        
        
    }
}
@end
