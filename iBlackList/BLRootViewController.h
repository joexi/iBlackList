//
//  BLRootViewController.h
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLContacterViewController.h"
#import "BLListViewController.h"
@interface BLRootViewController : UITabBarController <UITabBarControllerDelegate>
{
    BLContacterViewController   *_contacterViewController;
    BLListViewController        *_listViewController;
}
@end
