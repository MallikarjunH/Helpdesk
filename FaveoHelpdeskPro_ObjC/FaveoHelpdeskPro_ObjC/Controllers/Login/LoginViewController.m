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
            NSString *url = [NSString stringWithFormat:@"https://www.stablehelpdesk.faveodemo.com/api/v1/authenticate"];
            
            NSDictionary *param=[NSDictionary dictionaryWithObjectsAndKeys:self.userNameTextField.text,@"username",self.passwordTextField.text,@"password",nil];
            

            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
               
               [request setURL:[NSURL URLWithString:url]];
               [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
               [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
               [request setTimeoutInterval:60];
               
               [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:param options:kNilOptions error:nil]];
               [request setHTTPMethod:@"POST"];
               
               NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] ];
               
               [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                   
                   if (error) {
                       NSLog(@"dataTaskWithRequest error: %@", error);
                       return;
                   }else if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                       
                       NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                       NSLog(@"Status code in Login : %ld",(long)statusCode);
                     
                       if (statusCode != 200) {
                           
                       
                         if(statusCode == 404)
                           {
                               NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
                             //  [[AppDelegate sharedAppdelegate] hideProgressView];
                               [self->utils showAlertWithMessage:@"The requested URL was not found on this server." sendViewController:self];
                           }
                       
                           else if(statusCode == 405)
                           {
                               NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
                              // [[AppDelegate sharedAppdelegate] hideProgressView];
                               [self->utils showAlertWithMessage:@"The request method is known by the server but has been disabled and cannot be used." sendViewController:self];
                           }
                           else if(statusCode == 500)
                           {
                               NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
                             //  [[AppDelegate sharedAppdelegate] hideProgressView];
                               [self->utils showAlertWithMessage:@"Internal Server Error. Something has gone wrong on the website's server." sendViewController:self];
                           }
                           
                       }
                       
                   }
                   
                   NSString *replyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                   
                   NSLog(@"Login Response is : %@",replyStr);
                   
                   NSDictionary *jsonData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                   NSLog(@"JSON is : %@",jsonData);
        
         }] resume];
            
        }
    }
}

//MARK: TextField Delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return true;
}
        
@end
