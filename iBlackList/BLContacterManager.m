//
//  BLContacterManager.m
//  iBlackList
//
//  Created by Joe on 13-3-20.
//  Copyright (c) 2013年 Joe. All rights reserved.
//

#import "BLContacterManager.h"
#import "AddressBook/AddressBook.h"
#import <AddressBookUI/ABPersonViewController.h>
#import "BLContacter.h"
#import "BLAlertManager.h"

@implementation BLContacterManager
+ (void)requestAurhorizationStatus:(void(^)(bool granted))callback
{
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    if (status == kABAuthorizationStatusAuthorized) {
        callback(YES);
    }
    else if (status == kABAuthorizationStatusNotDetermined){
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
        {
            if (granted) {
                callback(YES);
            }
            else {
                callback(NO);
            }
        });
    }
    else {
        callback(NO);
        [BLAlertManager alertContacterRequest];
    }
}


+ (NSMutableArray *)getLocalContacts
{
    NSMutableArray *contacts = [NSMutableArray array];
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(nil, nil);
    if (!addressBook) {
        return nil;
    }
    CFArrayRef results = ABAddressBookCopyArrayOfAllPeople(addressBook);
    if (!results) {
        CFRelease(addressBook);
        return nil;
    }
    for (int i = 0; i < CFArrayGetCount(results); i++) {
        ABRecordRef person = CFArrayGetValueAtIndex(results, i);
        BLContacter *contacter = [[BLContacter alloc]init];
        contacter.name = [self nameFromRecord:person];
        contacter.email = [self emailFromRecord:person];
        contacter.avatar = [self imageFromRecord:person];
        contacter.phoneInfos = [self phoneInfosWithRecord:person];
        [contacts addObject:contacter];
        [contacter release];
    }
    CFRelease(results);
    CFRelease(addressBook);
    return contacts;
}

+ (NSArray *)phoneInfosWithRecord:(ABRecordRef)record
{
    NSMutableArray *phoneList = [NSMutableArray array];
    ABMultiValueRef phoneNumbers = ABRecordCopyValue(record,kABPersonPhoneProperty);
    if (phoneNumbers) {
        int count = ABMultiValueGetCount(phoneNumbers);
        for (int i = 0; i < count; i++) {
            NSString *phoneLabel = (NSString *)ABMultiValueCopyLabelAtIndex(phoneNumbers, i);
            NSString *phoneNumber = (NSString *)ABMultiValueCopyValueAtIndex(phoneNumbers, i);
            BLContacterPhoneInfo *phoneInfo = [[BLContacterPhoneInfo alloc]init];
            phoneInfo.phoneNumber = phoneNumber;
            phoneInfo.phoneNumberDescription = phoneLabel;
            if (phoneNumber) {
                NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^0-9]"
                                                                                       options:NSRegularExpressionCaseInsensitive                     error:nil];
                NSMutableString *pNumber = [NSMutableString stringWithString:phoneNumber];
                [regex replaceMatchesInString:pNumber options:0 range:NSMakeRange(0, phoneNumber.length) withTemplate:@""];
                phoneInfo.cleanNumber = pNumber;
            }
            [phoneList addObject:phoneInfo];
        }
    }
    return phoneList;
}

+ (NSString *)phoneInfoWithRecord:(ABRecordRef)record
{
    NSArray *ary = [self phoneInfosWithRecord:record];
    if (ary.count) {
        return [ary objectAtIndex:0];
    }
    return nil;
}

/* get image */
+ (UIImage *)imageFromRecord:(ABRecordRef)record
{
    NSData *imageData = (NSData *)ABPersonCopyImageData(record);
    UIImage *image = [UIImage imageWithData:imageData];
    imageData = nil;
    return image;
}

/* get contacter name */
+ (NSString *)nameFromRecord:(ABRecordRef)record
{
    NSString *fristName = (NSString*)ABRecordCopyValue(record, kABPersonFirstNameProperty);
    NSString *lastname = (NSString*)ABRecordCopyValue(record, kABPersonLastNameProperty);
    if (!fristName.length) {
        fristName = @"";
    }
    if (!lastname.length) {
        lastname = @"";
    }
    return [NSString stringWithFormat:@"%@ %@",fristName,lastname];
}

/* get email */
+ (NSString *)emailFromRecord:(ABRecordRef)record
{
    ABMultiValueRef emailInfo = ABRecordCopyValue(record, kABPersonEmailProperty);
    int emailCount = ABMultiValueGetCount(emailInfo);
    NSString *email = nil;
    for (int x = 0; x < emailCount; x++) {
        NSString *emailContent = (NSString*)ABMultiValueCopyValueAtIndex(emailInfo, x);
        if(emailContent.length) {
            email = emailContent;
        }
    }
    CFRelease(emailInfo);
    return email;
}
@end
