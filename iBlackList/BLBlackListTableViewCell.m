//
//  BLBlackListTabelViewCell.m
//  iBlackList
//
//  Created by Joe on 13-3-21.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLBlackListTableViewCell.h"

@implementation BLBlackListTableViewCell
#pragma mark - life cycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _btnBlack = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [_btnBlack addTarget:self
                      action:@selector(btnBlackSelected)
            forControlEvents:UIControlEventTouchUpInside];
        _btnBlack.frame = CGRectMake(320, 0, 44, 44);
        [self addSubview:_btnBlack];
    }
    return self;
}

- (void)dealloc
{
    [_info release];
    [super dealloc];
}

#pragma mark - btn
- (void)btnBlackSelected
{
    [_delegate removeBlackListInfo:_info];
}

#pragma mark - setter
- (void)setInfo:(BLBlackListInfo *)info
{
    if (_info != info) {
        [_info release];
        _info = [info retain];
        _lblName.text = _info.name;
        _lblPhoneNumber.text = _info.phoneNumber;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
