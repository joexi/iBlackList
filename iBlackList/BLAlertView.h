//
//  BLAlertView.h
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    BLAlertTypeContact,
    BLAlertTypeCustom,
}BLAlertType;
@interface BLAlertView : UIAlertView

@property (nonatomic, assign) BLAlertType type;
@property (nonatomic, assign) SEL selecter;
@property (nonatomic, retain) id target;
@property (nonatomic, strong) void (^callback)(bool granted);
@end
