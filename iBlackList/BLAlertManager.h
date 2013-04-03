//
//  BLAlertManager.h
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLAlertManager : NSObject

+ (void)alertContacterRequest;
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message;
@end
