//
//  BLAnimationManager.m
//  iBlackList
//
//  Created by Joe on 13-3-21.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLAnimationManager.h"

@implementation BLAnimationManager
+ (void)beginAnimtionWithContext:(void (^)(float *, UIViewAnimationCurve *))context
{
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    float duration = 0;
    UIViewAnimationCurve curve = 0;
    context(&duration, &curve);
    [UIView setAnimationCurve:curve];
    [UIView setAnimationDuration:duration];
    [UIView commitAnimations];
}
@end
