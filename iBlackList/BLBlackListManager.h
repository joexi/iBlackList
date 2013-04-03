//
//  BLBlackListManager.h
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BLContacter.h"
typedef enum {
    BLObserverStateOn = 0,
    BLObserverStateOff = 1
}BLObserverState;
@class BLBlackListInfo;
@interface BLBlackListManager : NSObject
{
    NSString *_blackListPath;
}
@property (nonatomic, assign) BLObserverState   state;
@property (nonatomic, strong) NSMutableArray    *blackList;
/* start black list watching */
+ (void)addObserver;

/* stop black list watching */
+ (void)removeObserver;


/* add a new number to black list */
+ (void)addPhoneNumber:(int)phoneNumber;

/* add a contacter to black list */
+ (void)addContacter:(BLContacter *)contacter;

/* find contacter */
+ (BOOL)hasContacterInBlack:(BLContacter *)contacter;

/* remove info in black list */
+ (void)removeBlackListInfo:(BLBlackListInfo *)info;

/* get black list */
+ (NSMutableArray *)blackList;
@end
