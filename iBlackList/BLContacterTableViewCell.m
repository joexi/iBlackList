//
//  BLContacterTableViewCell.m
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLContacterTableViewCell.h"
#import "BLBlackListManager.h"
#import "BLContacter.h"

@implementation BLContacterTableViewCell
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
    [_lblName release];
    [_lblPhoneNumber release];
    [_contacter release];
    [_btnBlack release];
    [super dealloc];
}

#pragma mark - private
- (void)reset
{
    if (_contacter.inBalckList) {
        _lblName.textColor = [UIColor redColor];
        _btnBlack.enabled = NO;
    }
    else {
        _lblName.textColor = [UIColor blackColor];
        _btnBlack.enabled = YES;
    }
}

#pragma mark - btn
- (void)btnBlackSelected
{
    [BLBlackListManager addContacter:_contacter];
    [self reset];
}
#pragma mark - setter
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setContacter:(BLContacter *)contacter
{
    if (_contacter != contacter) {
        _contacter = contacter;
        _lblName.text = _contacter.name;
        _lblPhoneNumber.text = _contacter.phoneNumber;
    }
    [self reset];
}
@end
