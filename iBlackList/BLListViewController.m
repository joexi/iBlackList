//
//  BLListViewController.m
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLListViewController.h"
#import "BLBlackListTableViewCell.h"
@interface BLListViewController ()

@end

@implementation BLListViewController

- (id)init
{
    self = [super init];
    if (self) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        self.view = _tableView;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public method
- (void)reloadData
{
    _blackList = [BLBlackListManager blackList];
    [_tableView reloadData];
}

#pragma mark - tableview delegate
#pragma mark - tableview delegate
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _blackList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLBlackListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[BLBlackListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
    }
    cell.info = [_blackList objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)removeBlackListInfo:(BLBlackListInfo *)info
{
    [BLBlackListManager removeBlackListInfo:info];
    [_tableView reloadData];
}
@end
