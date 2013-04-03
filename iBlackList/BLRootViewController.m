//
//  BLRootViewController.m
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLRootViewController.h"

@interface BLRootViewController ()

@end

@implementation BLRootViewController

#pragma mark - life cycle
- (id)init
{
    self = [super init];
    if (self) {
        _contacterViewController = [[BLContacterViewController alloc]init];
        UITabBarItem *barItemContacter = [[UITabBarItem alloc]initWithTitle:@"Contacter" image:nil tag:0];
        _contacterViewController.tabBarItem = barItemContacter;
        
        _listViewController = [[BLListViewController alloc]init];
        UITabBarItem *barItemList = [[UITabBarItem alloc]initWithTitle:@"BlackList" image:nil tag:1];
        _listViewController.tabBarItem = barItemList;
        [self setViewControllers:@[_contacterViewController,_listViewController] animated:YES];
        self.delegate = self;
        [self setSelectedViewController:_contacterViewController];
    }
    return self;
}

- (void)dealloc
{
    [_contacterViewController release];
    [_listViewController release];
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

#pragma mark - tabbar delegate
- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    [super setSelectedViewController:selectedViewController];
    if (selectedViewController == _contacterViewController) {
        [_contacterViewController reloadData];
    }
    else if (selectedViewController == _listViewController) {
        [_listViewController reloadData];
    }
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
}

@end
