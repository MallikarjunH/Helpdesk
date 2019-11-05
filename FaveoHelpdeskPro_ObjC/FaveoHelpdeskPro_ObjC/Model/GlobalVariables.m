//
//  GlobalVariables.m
//  FaveoHelpdeskPro_ObjC
//
//  Created by mallikarjun on 05/11/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

#import "GlobalVariables.h"

@implementation GlobalVariables

+ (instancetype)sharedInstance
{
    static GlobalVariables *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GlobalVariables alloc] init];
        NSLog(@"SingleTon-GlobalVariables");
    });
    return sharedInstance;
}
@end
