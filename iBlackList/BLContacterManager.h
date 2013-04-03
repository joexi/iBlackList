//
//  BLContacterManager.h
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLContacterManager : NSObject
/* get device location contacter infomation */
+ (NSMutableArray *)getLocalContacts;

/* request aurhorization */
+ (void)requestAurhorizationStatus:(void(^)(bool granted))callback;
@end
