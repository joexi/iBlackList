//
//  BLBlackListCell.m
//  iBlackList
//
//  Created by Joe on 13-3-21.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLBlackListCell.h"

@implementation BLBlackListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        /* wont initialize button */
        _lblName = [[UILabel alloc]init];
        _lblName.frame = CGRectMake(0, 0, 100, 44);
        _lblPhoneNumber = [[UILabel alloc]init];
        _lblPhoneNumber.frame = CGRectMake(130, 0, 190, 44);
        _lblPhoneNumber.textAlignment = NSTextAlignmentRight;
        [self addSubview:_lblName];
        [self addSubview:_lblPhoneNumber];
    }
    return self;
}
- (void)dealloc
{
    [_lblName release];
    [_lblPhoneNumber release];
    [super dealloc];
}
#pragma mark - private method
- (void)showButton
{
    [BLAnimationManager beginAnimtionWithContext:^(float *duration, UIViewAnimationCurve *curve) {
        *duration = 1;
        *curve = UIViewAnimationCurveEaseInOut;
        _lblPhoneNumber.frame = CGRectMake(80, 0, 190, 44);
        _btnBlack.frame = CGRectMake(270, 0, 44, 44);
    }];
}

- (void)hideButton
{
    [BLAnimationManager beginAnimtionWithContext:^(float *duration, UIViewAnimationCurve *curve) {
        *duration = 1;
        *curve = UIViewAnimationCurveEaseInOut;
        _lblPhoneNumber.frame = CGRectMake(130, 0, 190, 44);
        _btnBlack.frame = CGRectMake(320, 0, 44, 44);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [self showButton];
    }
    else {
        [self hideButton];
    }
    // Configure the view for the selected state
}

@end
