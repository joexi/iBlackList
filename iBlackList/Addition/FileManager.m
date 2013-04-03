//
//  PAFileManager.m
//  EOW
//
//  Created by Jason Zhang on 5/25/12.
//  Copyright (c) 2012 Jason Zhang. All rights reserved.
//

#import "FileManager.h"
#import "PathHelper.h"

@implementation FileManager

static dispatch_queue_t _ioQueue;

+ (void)initialize
{
    [super initialize];
    _ioQueue = dispatch_queue_create("com.metalnation.PAFileManager", DISPATCH_QUEUE_SERIAL);
}

+ (void)storeFile:(NSObject *)file path:(NSString *)path
{
    [self storeFile:file path:[path stringByDeletingLastPathComponent] name:[path lastPathComponent]];
}

+ (void)storeFile:(NSObject*)file path:(NSString*)path name:(NSString *)name
{
    if ([path hasSuffix:name] || !name) {
        [self storeFile:file path:path];
        return;
    }
    if ([PathHelper createPathIfNecessary:path]) {
        [NSKeyedArchiver archiveRootObject:file toFile:[path stringByAppendingPathComponent:name]];
    }
    else {
    }
}

+ (NSObject*)loadFile:(NSString*)path
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
//保存nsdata
+ (void)saveData:(NSData *)data withPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createFileAtPath:path contents:data attributes:nil];
}
//根据路径和名称获取纹理
+ (NSData *)dataWithPath:(NSString *)path name:(NSString *)name
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:[path stringByAppendingPathComponent:name]])
    {
        NSData *data = [NSData dataWithContentsOfFile:[path stringByAppendingPathComponent:name]];
        return data;
    }
    return nil;
}
//判断该目录下是否有这个文件
+ (BOOL)hasFileWithPath:(NSString *)path name:(NSString *)name
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return  [fileManager fileExistsAtPath:[path stringByAppendingPathComponent:name]];
}

//移除路径下所有文件
+ (void)removeAllFilesWithPath:(NSString *)path
{
    [self removeAllFilesWithPath:path expireDate:0];
}

//移除路径下所有过期的文件
+ (void)removeAllFilesWithPath:(NSString *)path expireDate:(NSTimeInterval)expireDate
{
    NSFileManager *fm = [NSFileManager defaultManager];
	NSDirectoryEnumerator *e = [fm enumeratorAtPath:path];//获取目录下所有的文件
	for (NSString *fileName; fileName = [e nextObject]; )
    {
		NSString *filePath = [path stringByAppendingPathComponent:fileName];
		NSDictionary *attrs = [fm attributesOfItemAtPath:filePath error:nil];
		NSDate *modified = [attrs objectForKey:NSFileModificationDate];//获取最后修改日期
		NSTimeInterval t = [modified timeIntervalSinceNow];
		if(t < -expireDate)//移除过期的文件
        {
			[fm removeItemAtPath:filePath error:nil];
		}
	}
}

//根据路径了文件名移除文件
+ (BOOL)removeFileWithPath:(NSString *)path name:(NSString *)name
{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm removeItemAtPath:[path stringByAppendingPathComponent:name] error:nil];
}

+ (BOOL)hasResourceFileExit:(NSString *)name
{
    return [FileManager hasFileWithPath:[[NSBundle mainBundle]resourcePath] name:name];
}

#pragma mark - 异步删除
+ (void)asynRemoveFileWithPath:(NSString*)path name:(NSString*)name
{
    dispatch_async(_ioQueue, ^{
        [self removeFileWithPath:path name:name];
    });
}

+ (void)asynRemoveDirectory:(NSString*)path
{
    dispatch_async(_ioQueue, ^{
        [self removeAllFilesWithPath:path];
    });
}

@end
