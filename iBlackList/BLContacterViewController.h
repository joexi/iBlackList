//
//  BLContacterViewController.h
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLContacterViewController : UIViewController <
UITableViewDataSource,
UITableViewDelegate
>
{
    UITableView *_tabelView;
}
@property (nonatomic, strong) NSMutableArray *contacters;

- (void)reloadData;
@end
