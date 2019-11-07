//
//  InboxViewController.m
//  FaveoHelpdeskPro_ObjC
//
//  Created by mallikarjun on 04/11/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

#import "InboxViewController.h"
#import "TicketStructureCell.h"
#import "Utils.h"
#import "GlobalVariables.h"
#import "MyWebservices.h"
#import "AppConstant.h"

@interface InboxViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSUserDefaults *userDefaults;
    GlobalVariables * globalVariables;
    Utils *utils;
}
@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    userDefaults=[NSUserDefaults standardUserDefaults];
    utils=[[Utils alloc]init];
    globalVariables = [[GlobalVariables alloc] init];
    
    
}

-(void)getTicketsAPICall{
    
    NSString * apiValue=[NSString stringWithFormat:@"%i",1];
    NSString * showInbox = @"inbox";
    NSString * Alldeparatments=@"All";
    

    NSString * url= [NSString stringWithFormat:@"%@api/v2/helpdesk/get-tickets?token=%@&api=%@&show=%@&departments=%@",HELPDESK_URL,[userDefaults objectForKey:@"token"],apiValue,showInbox,Alldeparatments];
    NSLog(@"URL is : %@",url);
    
    MyWebservices *webservices=[MyWebservices sharedInstance];
    [webservices httpResponseGET:url parameter:@"" callbackHandler:^(NSError *error, id json, NSString *msg) {
        
        NSLog(@"getTicketsAPICall Method Inbox Error is : %@",error );
        NSLog(@"getTicketsAPICall Method Inbox Message is : %@",msg );
        NSLog(@"getTicketsAPICall Method Inbox JSON is: %@",json);
        
    }];
}

//MARK: TableView Data Source and Delegate Methods

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    TicketStructureCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TicketStructureCellId"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TicketStructureCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.0;
}



@end
