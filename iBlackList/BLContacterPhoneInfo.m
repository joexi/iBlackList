//
//  BLContacterPhoneInfo.m
//  iBlackList
//
//  Created by Joe on 13-3-21.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLContacterPhoneInfo.h"

@implementation BLContacterPhoneInfo

- (void)dealloc
{
    [_phoneNumber release];
    [_phoneNumberDescription release];
    [_cleanNumber release];
    [super dealloc];
}

@end
