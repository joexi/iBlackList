//
//  BLBlackListTabelViewCell.h
//  iBlackList
//
//  Created by Joe on 13-3-21.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLBlackListCell.h"
#import "BLBlackListInfo.h"
#import "BLBlackListTableViewCellProtocol.h"
@interface BLBlackListTableViewCell : BLBlackListCell

@property (nonatomic, strong) BLBlackListInfo *info;
@property (nonatomic, assign) id <BLBlackListTableViewCellProtocol> delegate;
@end
