//
//  BLBlackListInfo.m
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLBlackListInfo.h"

@implementation BLBlackListInfo
+ (id)info
{
    return [[self alloc]init];
}

#pragma mark - life cycyle
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.name = [dic objectForKey:@"Name"];
        self.phoneNumber = [dic objectForKey:@"Number"];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_phoneNumber release];
    [_name release];
    [super dealloc];
}

#pragma mark - 
- (NSDictionary *)getDictionary
{
    NSDictionary *dic = @{@"Number": self.phoneNumber?self.phoneNumber:@"",
                          @"Name": self.name?self.name:@""};
    return dic;
}


@end
