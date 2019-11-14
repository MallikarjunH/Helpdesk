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
#import "GlobalVariables.h"
#import "InboxViewController.h"
#import "AppConstant.h"

@interface LoginViewController () <UITextFieldDelegate>
{
    Utils *utils;
    NSUserDefaults *userdefaults;
    GlobalVariables * globalVariables;
    UIActivityIndicatorView *activityIndicator2;
}
@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    globalVariables = [[GlobalVariables alloc] init];
    utils = [[Utils alloc] init];
    
    // Creating activity indicator programatically
    activityIndicator2 = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(150, 100, 100, 100)];
    activityIndicator2.color=[UIColor blueColor];
    
    [self.view addSubview:activityIndicator2];
    
}

//[activityIndicator2 startAnimating];
//[activityIndicator2 stopAnimating];

- (IBAction)loginButtonClicked:(id)sender {
    
    [activityIndicator2 startAnimating];
    if ([_userNameTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""]){
        // OR - if (self.urlTextfield.text.length==0){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //update UI here
            [self->utils showAlertWithMessage:@"Please enter username or password" sendViewController:self];
            [self->activityIndicator2 stopAnimating];
        });
       
        
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
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   //update UI here
                                   [self->utils showAlertWithMessage:@"The requested URL was not found on this server." sendViewController:self];
                                   [self->activityIndicator2 stopAnimating];
                               });
                               
                           }
                           else if(statusCode == 405)
                           {
                               NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
                              // [[AppDelegate sharedAppdelegate] hideProgressView];
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   //update UI here
                                  [self->utils showAlertWithMessage:@"The request method is known by the server but has been disabled and cannot be used." sendViewController:self];
                                   [self->activityIndicator2 stopAnimating];
                               });
                               
                           }
                           else if(statusCode == 500)
                           {
                               NSLog(@"dataTaskWithRequest HTTP status code: %ld", (long)statusCode);
                             //  [[AppDelegate sharedAppdelegate] hideProgressView];
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  //update UI here
                                 [self->utils showAlertWithMessage:@"Internal Server Error. Something has gone wrong on the website's server." sendViewController:self];
                                  [self->activityIndicator2 stopAnimating];
                              });
                               
                           }
                           
                       }
                       
                   }
                   
                 //  NSString *replyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                  // NSLog(@"Login Response is : %@",replyStr);
                   
                   NSDictionary *jsonData=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                   NSLog(@"JSON is : %@",jsonData);
                   
                   id successMsg = [jsonData objectForKey:@"success"];
                   NSString * sucessMsg = [NSString stringWithFormat:@"%@",successMsg];
                
                 /*  if([successMsg isKindOfClass:[NSNumber class]]) {
                       NSLog(@"tru 111");
                    
                   }else{
                       NSLog(@"false 222");
                   } */
                   
                   if ([sucessMsg isEqualToString:@"0"]) {
                       
                       NSString * message = [jsonData objectForKey:@"message"];
                       
                       if([message isEqualToString:@"Invalid credentials"]){
                           
                           dispatch_async(dispatch_get_main_queue(), ^{
                               //update UI here
                              [self->utils showAlertWithMessage:@"Invalid Crendentials" sendViewController:self];
                               [self->activityIndicator2 stopAnimating];
                           });
                           
                       }
                       else if([message isEqualToString:@"API key is required"]){
                           
                           dispatch_async(dispatch_get_main_queue(), ^{
                               //update UI here
                             [self->utils showAlertWithMessage:@"API key is required. Please enable from the admin panel." sendViewController:self];
                               [self->activityIndicator2 stopAnimating];
                           });
                        
                       }else{
                           dispatch_async(dispatch_get_main_queue(), ^{
                               //update UI here
                              [self->utils showAlertWithMessage:@"Something went wrong" sendViewController:self];
                               [self->activityIndicator2 stopAnimating];
                           });
                       }
                       
                   }else  {
                       
                       NSDictionary *dataDict = [jsonData objectForKey:@"data"];
                       NSString *userToken = [dataDict objectForKey:@"token"];
                       
                       NSDictionary *userDict = [dataDict objectForKey:@"user"];
                       NSString *firstName = [userDict objectForKey:@"first_name"];
                       NSString *lastName = [userDict objectForKey:@"last_name"];
                       NSString *email = [userDict objectForKey:@"email"];
                       NSString *profilePic = [userDict objectForKey:@"profile_pic"];
                       NSString *userRole = [userDict objectForKey:@"role"];
                       
                       self->globalVariables.loggedUserToken = userToken;
                       self->globalVariables.loggedUserFirstName = firstName;
                       self->globalVariables.loggedUserLastName = lastName;
                       self->globalVariables.loggedUserUserEmail = email;
                       self->globalVariables.loggedUserUserRole = userRole;
                       self->globalVariables.loggedUserUserProfilePic = profilePic;
                       
                      // self->globalVariables.userLoggedStatus = @"Yes";
                       dispatch_async(dispatch_get_main_queue(), ^{
                           //update UI here
                          //move to inbox VC InboxViewController
                          InboxViewController *inboxVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InboxViewControllerId"];
                          [self.navigationController pushViewController:inboxVC animated:true];
                           
                          [[self navigationController] setNavigationBarHidden:NO];
                          [self->activityIndicator2 stopAnimating];
                       });
                       
                       
                       
                   }

        
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
