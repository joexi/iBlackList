//
//  BLAnimationManager.h
//  iBlackList
//
//  Created by Joe on 13-3-21.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLAnimationManager : NSObject

+ (void)beginAnimtionWithContext:(void (^)(float *duration,UIViewAnimationCurve *curve))context;
@end
