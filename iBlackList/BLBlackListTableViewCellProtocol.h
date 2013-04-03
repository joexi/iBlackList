//
//  BLBlaskListTableViewCellProtocol.h
//  iBlackList
//
//  Created by Joe on 13-4-1.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BLBlackListInfo;
@protocol BLBlackListTableViewCellProtocol <NSObject>
- (void)removeBlackListInfo:(BLBlackListInfo *)info;
@end
