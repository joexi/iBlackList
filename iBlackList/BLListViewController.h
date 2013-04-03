//
//  BLListViewController.h
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLBlackListTableViewCellProtocol.h"
@interface BLListViewController : UIViewController<
UITableViewDataSource,
UITableViewDelegate,
BLBlackListTableViewCellProtocol
>
{
    NSMutableArray  *_blackList;
    UITableView     *_tableView;
}
- (void)reloadData;
@end
