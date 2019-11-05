//
//  InboxViewController.m
//  FaveoHelpdeskPro_ObjC
//
//  Created by mallikarjun on 04/11/19.
//  Copyright © 2019 Mallikarjun H. All rights reserved.
//

#import "InboxViewController.h"
#import "TicketStructureCell.h"

@interface InboxViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation InboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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





@end
