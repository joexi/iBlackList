//
//  BLContacterTableViewCell.h
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLBlackListCell.h"
#import "BLContacter.h"
#import "BLContacterTableViewCellProtocol.h"
@interface BLContacterTableViewCell : BLBlackListCell
{
    
}
@property (nonatomic, strong) BLContacter *contacter;

@end
