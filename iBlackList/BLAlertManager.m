//
//  BLAlertManager.m
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLAlertManager.h"
#import "BLAlertView.h"
@implementation BLAlertManager
static BLAlertManager *_sharedManager;
+ (BLAlertManager *)sharedManager
{
    if (!_sharedManager) {
        _sharedManager = [[self alloc]init];
    }
    return _sharedManager;
}

+ (void)alertContacterRequest
{
    BLAlertView *alertView = [[BLAlertView alloc]initWithTitle:@"Address Book"
                                                       message:@"We Need Your Aurhorization For Address Book"
                                                      delegate:[self sharedManager]
                                             cancelButtonTitle:@"CANCEL"
                                             otherButtonTitles:@"OK", nil];
    alertView.type = BLAlertTypeContact;
    [alertView show];
}

+ (void)alertWithTitle:(NSString *)title message:(NSString *)message
{
    BLAlertView *alertView = [[BLAlertView alloc]initWithTitle:title
                                                       message:message
                                                      delegate:[self sharedManager]
                                             cancelButtonTitle:@"CANCEL"
                                             otherButtonTitles:nil];
    alertView.type = BLAlertTypeCustom;
    [alertView show];
}


- (void)alertView:(BLAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.type) {
        case BLAlertTypeContact:
        {
            if (buttonIndex == 1) {
                NSString *escaped = [@"prefs:root=LOCATION_SERVICES" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:escaped]];
            }
            else {
                
            }
            break;
        }
        default:
            break;
    }
}
@end
