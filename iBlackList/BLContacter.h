//
//  BLContacter.h
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLContacterPhoneInfo.h"
@interface BLContacter : NSObject
{
    
}
@property (nonatomic, retain)   NSString    *name;
@property (nonatomic, retain)   NSString    *email;
@property (nonatomic, readonly) NSString    *phoneNumber;
@property (nonatomic, readonly) NSString    *cleanNumber;
@property (nonatomic, retain)   UIImage     *avatar;
@property (nonatomic, retain)   NSArray     *phoneInfos;
@property (nonatomic, readonly) BOOL        inBalckList;
@end
