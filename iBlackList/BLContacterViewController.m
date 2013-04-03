//
//  BLContacterViewController.m
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLContacterViewController.h"
#import "BLContacterTableViewCell.h"
#import "BLContacterManager.h"
@interface BLContacterViewController ()

@end

@implementation BLContacterViewController

#pragma mark - life cycle
- (id)init
{
    self = [super init];
    if (self) {
        _tabelView = [[UITableView alloc]initWithFrame:self.view.frame];
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        self.view = _tabelView;
    }
    return self;
}

- (void)dealloc
{
    [_contacters release];
    [_tabelView release];
    [super dealloc];
}

#pragma mark - display
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
    if (!_contacters) {
        [BLContacterManager requestAurhorizationStatus:^(bool granted) {
            if (granted) {
                self.contacters = [BLContacterManager getLocalContacts];
            }
            else {
                
            }
        }];
    }
    [_tabelView reloadData];
}

#pragma mark - setter
- (void)setContacters:(NSMutableArray *)contacters
{
    if (_contacters != contacters) {
        [_contacters release];
        _contacters = [contacters retain];
    }
}

#pragma mark - tabelview delegate
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contacters.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BLContacterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[BLContacterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.contacter = [_contacters objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
