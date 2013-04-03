//
//  BLBlackListManager.m
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLBlackListManager.h"
#import "CoreTelephony/CTTelephonyNetworkInfo.h"
#import "CoreTelephony/CTCarrier.h"
#import "CoreTelephony/CTCall.h"
#import "CoreTelephony/CTCallCenter.h"
#import "BLBlackListInfo.h"
#import "FileManager.h"
#import "PathHelper.h"
#import "BLAlertManager.h"
#define NotificationKey CFSTR("kCTCallStatusChangeNotification")
@implementation BLBlackListManager
static BLBlackListManager *_sharedManager;

#pragma mark - api
static void callBack(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    NSDictionary *info = (NSDictionary *)(userInfo);
    CTCall *call = (CTCall *)[info objectForKey:@"kCTCall"];
    /* error in ARC mode so i had to change my project in half way */
    NSString *caller = (NSString *)CTCallCopyAddress(NULL, call); // caller number
    NSLog(@"phone number is :%@",caller);
    if ([[BLBlackListManager sharedManager] hasPhoneNumberInList:caller]) {
        CTCallDisconnect(call);
    }
}

+ (void)addObserver
{
    CTTelephonyCenterAddObserver(CTTelephonyCenterGetDefault(),
                                 NULL,
                                 &callBack,
                                 NotificationKey,
                                 NULL,
                                 CFNotificationSuspensionBehaviorHold);
    [self sharedManager].state = BLObserverStateOn;
}

+ (void)removeObserver
{
    CTTelephonyCenterRemoveObserver(CTTelephonyCenterGetDefault(),
                                    NULL,
                                    NotificationKey,
                                    NULL);
    [self sharedManager].state = BLObserverStateOff;
}

+ (BOOL)hasContacterInBlack:(BLContacter *)contacter
{
    return [[self sharedManager] hasContacterInBlack:contacter];
}

+ (BLBlackListManager *)sharedManager
{
    if (!_sharedManager) {
        _sharedManager = [[BLBlackListManager alloc]init];
    }
    return _sharedManager;
}

+ (void)addPhoneNumber:(int)phoneNumber
{
    [[self sharedManager] addPhoneNumber:phoneNumber];
}

+ (void)addContacter:(BLContacter *)contacter
{
    [[self sharedManager] addContacter:contacter];
}

+ (void)removeBlackListInfo:(BLBlackListInfo *)info
{
    [[self sharedManager] removeBlackListInfo:info];
}

+ (NSMutableArray *)blackList
{
    return [[self sharedManager] blackList];
}

#pragma mark - life cycle
- (id)init
{
    self = [super init];
    if (self) {
        _blackListPath = [[[PathHelper documentDirectoryPath] stringByAppendingPathComponent:@"BlackList.info"] retain];
        _blackList = [[self loadBlackListFromPath:_blackListPath] retain];
    }
    return self;
}

- (void)dealloc
{
    [_blackList release];
    [_blackListPath release];
    [super dealloc];
}

#pragma mark - method
#pragma mark load & save
- (NSMutableArray *)loadBlackListFromPath:(NSString *)path
{
    NSMutableArray *results = [NSMutableArray array];
    NSArray *records = (NSArray *)[FileManager loadFile:path];
    NSLog(@"%@",records);
    for (NSDictionary *dic in records) {
        BLBlackListInfo *info = [[BLBlackListInfo alloc]initWithDic:dic];
        [results addObject:info];
        [info release];
    }
    return results;
}

- (void)saveList:(NSMutableArray *)blackList path:(NSString *)path
{
    NSMutableArray *results = [NSMutableArray array];
    for (BLBlackListInfo *info in blackList) {
        NSDictionary *dic = [info getDictionary];
        [results addObject:dic];
    }
    [FileManager storeFile:results path:path];
}

#pragma mark - Maintain list
- (BOOL)isPhoneNumber:(NSString *)phoneNumber1 equal:(NSString *)phoneNumber2
{
    //define the rule of phone number equal
    if (!phoneNumber1 || !phoneNumber2) {
        return NO;
    }
    else if ([phoneNumber1 isEqualToString:phoneNumber2]) {
        return YES;
    }
    else if ([phoneNumber2 rangeOfString:phoneNumber1].location != NSNotFound) {
        return YES;
    }
    return NO;
}

- (BOOL)hasPhoneNumberInList:(NSString *)phoneNumber
{
    for (BLBlackListInfo *info in _blackList) {
        if ([self isPhoneNumber:phoneNumber
                          equal:info.phoneNumber]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)hasContacterInBlack:(BLContacter *)contacter
{
    return [self hasPhoneNumberInList:contacter.cleanNumber];
}

- (void)addPhoneNumber:(int)phoneNumber
{
    BLBlackListInfo *info = [[BLBlackListInfo alloc]init];
    info.phoneNumber = [NSString stringWithFormat:@"%d",phoneNumber];
    [_blackList addObject:info];
    [info release];
    [self saveList:_blackList path:_blackListPath];
}

- (BOOL)removePhoneNumber:(NSString *)phoneNumber
{
    [self saveList:_blackList path:_blackListPath];
    return YES;
    //TODO
}

- (void)addContacter:(BLContacter *)contacter
{
    if (!contacter.phoneNumber.length) {
        [BLAlertManager alertWithTitle:@"ADD ERROR"
                               message:@"every contacter in black list need one phone number at least"];
        return;
    }
    BLBlackListInfo *info = [[BLBlackListInfo alloc]init];
    info.name = contacter.name;
    info.phoneNumber = contacter.cleanNumber;
    [_blackList addObject:info];
    [info release];
    [self saveList:_blackList path:_blackListPath];
}

- (void)removeBlackListInfo:(BLBlackListInfo *)info
{
    [_blackList removeObject:info];
    [self saveList:_blackList path:_blackListPath];
}
@end
