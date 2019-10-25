//
//  LoginViewController.m
//  FaveoHelpdeskPro_ObjC
//
//  Created by mallikarjun on 23/10/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController () <UITextFieldDelegate>

@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)loginButtonClicked:(id)sender {
    
    if ([_userNameTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""]){
        // OR - if (self.urlTextfield.text.length==0){
        
       //show alert
        
    }else{
        
        NSString *url = [NSString stringWithFormat:@"https://www.stablehelpdesk.faveodemo.com/api/v1/authenticate"];
        
        
    }
}

//MARK: TextField Delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return true;
}
@end
