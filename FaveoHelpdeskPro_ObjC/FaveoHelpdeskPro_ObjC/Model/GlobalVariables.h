//
//  GlobalVariables.h
//  FaveoHelpdeskPro_ObjC
//
//  Created by mallikarjun on 05/11/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalVariables : NSObject

@property (strong, nonatomic) NSString *loggedUserToken;
@property (strong, nonatomic) NSString *loggedUserFirstName;
@property (strong, nonatomic) NSString *loggedUserLastName;
@property (strong, nonatomic) NSString *loggedUserUserName;
@property (strong, nonatomic) NSString *loggedUserUserEmail;
@property (strong, nonatomic) NSString *loggedUserUserRole;
@property (strong, nonatomic) NSString *loggedUserUserProfilePic;

//@property (strong, nonatomic) NSArray *ccListArray1;
//@property (strong, nonatomic) NSDictionary *dependencyDataDict;


@end

