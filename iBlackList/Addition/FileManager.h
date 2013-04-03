//
//  PAFileManager.h
//  EOW
//
//  Created by Jason Zhang on 5/25/12.
//  Copyright (c) 2012 Jason Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+ (void)storeFile:(NSObject *)file path:(NSString *)path;

+ (void)storeFile:(NSObject *)file path:(NSString *)path name:(NSString *)name; //序列化存储

+ (NSObject*)loadFile:(NSString*)path;                                          //序列化读取

+ (void)saveData:(NSData *)data withPath:(NSString *)path;
//保存data至本地

+ (NSData *)dataWithPath:(NSString *)path name:(NSString *)name;
//根据路径获取纹理

+ (BOOL)removeFileWithPath:(NSString *)path name:(NSString *)name;              
//更具路径和文件名移除文件

+ (void)removeAllFilesWithPath:(NSString *)path expireDate:(NSTimeInterval)expireDate;
//移除路径下所有的过期文件

+ (void)removeAllFilesWithPath:(NSString *)path;
//移除路径下所有的文件

+ (BOOL)hasFileWithPath:(NSString *)path name:(NSString *)name;
//判断该路径是否存在

+ (BOOL)hasResourceFileExit:(NSString *)name;
//判断资源文件是否存在

//异步删除文件
+ (void)asynRemoveFileWithPath:(NSString*)path name:(NSString*)name;
+ (void)asynRemoveDirectory:(NSString*)path;

@end
