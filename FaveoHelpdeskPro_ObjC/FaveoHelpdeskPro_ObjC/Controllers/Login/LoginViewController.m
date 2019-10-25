//
//  LoginViewController.m
//  FaveoHelpdeskPro_ObjC
//
//  Created by mallikarjun on 23/10/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

#import "LoginViewController.h"
#import "Utils.h"
#import "Reachability.h"
#import "MyWebservices.h"

@interface LoginViewController () <UITextFieldDelegate>
{
    Utils *utils;
    NSUserDefaults *userdefaults;
}
@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)loginButtonClicked:(id)sender {
    
    if ([_userNameTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""]){
        // OR - if (self.urlTextfield.text.length==0){
        
        [utils showAlertWithMessage:@"Please enter username or password" sendViewController:self];
        
    }else{
        if([[Reachability reachabilityForInternetConnection]currentReachabilityStatus] == NotReachable){
            
        }else{
            NSString *url = [NSString stringWithFormat:@"https://www.stablehelpdesk.faveodemo.com/api/v1/authenticate?username=%@&password=%@",_userNameTextField.text, _passwordTextField.text];
            
            MyWebservices *webservices=[MyWebservices sharedInstance];
            
            [webservices httpResponsePOST:url parameter:@"" callbackHandler:^(NSError *error,id json,NSString* msg) {
                
               NSLog(@"Message is-%@",msg);
               NSLog(@"JSON is-%@",json);
                
            }];
            
        }
        
        
    }
}

//MARK: TextField Delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return true;
}
@end
