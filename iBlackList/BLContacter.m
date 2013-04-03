//
//  BLContacter.m
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLContacter.h"
#import "BLBlackListManager.h"
@implementation BLContacter

#pragma mark - life cycle
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_phoneInfos release];
    [_name release];
    [_email release];
    [_avatar release];
    [super dealloc];
}

#pragma mark - getter
- (NSString *)cleanNumber
{
    if (_phoneInfos.count) {
        return ((BLContacterPhoneInfo *)[_phoneInfos objectAtIndex:0]).cleanNumber;
    }
    return nil;
}

- (NSString *)phoneNumber
{
    if (_phoneInfos.count) {
        return ((BLContacterPhoneInfo *)[_phoneInfos objectAtIndex:0]).phoneNumber;
    }
    return nil;
}

- (BOOL)inBalckList
{
    return [BLBlackListManager hasContacterInBlack:self];
}
@end
