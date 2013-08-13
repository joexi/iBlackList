//
//  BLBlackListInfo.h
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLBlackListInfo : NSObject
@property (nonatomic, retain) NSString *phoneNumber;
@property (nonatomic, retain) NSString *name;

/* initial with NSDictionary */
- (id)initWithDic:(NSDictionary *)dic;


/* translate into a dictionary */
- (NSDictionary *)getDictionary;
@end
