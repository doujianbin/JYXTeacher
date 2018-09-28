//
//  MSFile.m
//  MyShowFoundation
//
//  Created by Michael Ge on 15/11/9.
//

#import "MSFile.h"
#import <UIKit/UIKit.h>
#import <sys/xattr.h>
//#import "MSZipArchive.h"

@implementation MSFile

+ (NSString *_Nullable)ensureDirectoryInLibrary:(NSString * _Nonnull)subPath skipBackup:(BOOL)skip
{
    if (!subPath || subPath.length == 0){
        return nil;
    }
    
    NSArray  *libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *hPath = [libPaths objectAtIndex:0];
    NSString *fullPath = [hPath stringByAppendingPathComponent:subPath];
    
    int r = [self ensureDirectory:fullPath];
    if (r != 0) {
        if (skip && r == 2){
            [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:fullPath]];
        }
        
        return fullPath;
    }
    else{
        return nil;
    }
}

+ (NSString * _Nullable)ensureDirectoryInDocument:(NSString * _Nonnull)subPath skipBackup:(BOOL)skip
{
    if (!subPath || subPath.length == 0){
        return nil;
    }
    
    NSArray  *homePaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *hPath = [homePaths objectAtIndex:0];
    NSString *fullPath = [hPath stringByAppendingPathComponent:subPath];
    
    int r = [self ensureDirectory:fullPath];
    if (r != 0) {
        if (skip && r == 2){
            [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:fullPath]];
        }
        
        return fullPath;
    }
    else{
        return nil;
    }
}

+ (NSString * _Nullable)ensureDirectoryInCache:(NSString * _Nonnull)subPath
{
    if (!subPath || subPath.length == 0){
        return nil;
    }
    
    NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *fullPath = [path stringByAppendingPathComponent:subPath];
    if ([self ensureDirectory:fullPath]) {
        return fullPath;
    }
    else{
        return nil;
    }
}

/**
 *  确保某一个目录存在，如果不存在则尝试创建这个目录。
 *
 *  @param path 目录的全路径
 *
 *  @return 如果目录存在 1，如果创建成功返回 2，如果创建失败则返回 0。
 */
+(int)ensureDirectory:(NSString*)path
{
    if (!path) {
        return 0;
    }
    
    NSFileManager *fm = [[NSFileManager alloc] init];
    [fm changeCurrentDirectoryPath:[path stringByExpandingTildeInPath]];
    
    BOOL isDir   = NO;
    BOOL isExist = [fm fileExistsAtPath:path isDirectory:&isDir];
    
    if (!isExist){
        BOOL success = [fm createDirectoryAtPath:path
                     withIntermediateDirectories:YES
                                      attributes:nil
                                           error:nil];
        
        return success ? 2 : 0;
    }
    
    return 1;
}

+ (BOOL)isExist:(NSString *)fullPath
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    return [fileManager fileExistsAtPath:fullPath];
}

+ (NSString* _Nullable) readFileWithString:(NSString * _Nonnull)fullPath
{
    NSError  *error   = nil;
    NSString *content = nil;
    
    content = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        return nil;
    }
    
    return content;
}

//+ (MSJSONObject* _Nullable) readFileWithJSONObject:(NSString * _Nonnull)fullPath
//{
//    NSString *content = [self readFileWithString:fullPath];
//    
//    if ([NSString isEmpty:content]) {
//        return nil;
//    }
//    
//    return [[MSJSONObject alloc]initWithString:content];
//}

//+ (MSJSONArray* _Nullable) readFileWithJSONArray:(NSString * _Nonnull)fullPath
//{
//    NSString *content = [self readFileWithString:fullPath];
//    
//    if ([NSString isEmpty:content]) {
//        return nil;
//    }
//    
//    return [[MSJSONArray alloc]initWithString:content];
//}

//+ (BOOL)decompressZip:(NSString *_Nonnull)zipFilePath
//               target:(NSString *_Nonnull)directory
//{
//    BOOL ret = NO;
//    
//    MSZipArchive *za = [[MSZipArchive alloc] init];
//    
//    if ([za UnzipOpenFile: zipFilePath]) {
//        ret = [za UnzipFileTo: directory overWrite: YES];
//        [za UnzipCloseFile];
//    }
//    
//    return ret;
//}

+ (BOOL)writeFile:(NSString * _Nonnull)path text:(NSString * _Nonnull)text
{
    return [self writeFile:path data:[text dataUsingEncoding:NSUTF8StringEncoding]];
}

+(BOOL)writeFile:(NSString *_Nonnull)path data:(NSData * _Nonnull)data
{
    BOOL success = NO;
    NSError *error = nil;
    @try
    {
        [self removeFile:path];
        
        if(![self createFile:path]){
            return NO;
        }
        
        [data writeToFile:path options:NSDataWritingAtomic error:&error];
        if (!error) {
            success = YES;
        }
    }
    @catch (NSException *exception){
        success = NO;
    }
    
    return success;
}

+ (BOOL)removeFile:(NSString * _Nonnull)path
{
    BOOL success = NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if ([fileManager fileExistsAtPath:path]) {
        [fileManager removeItemAtPath:path error:nil];
        success = true;
    }
    
    return success;
}

+ (BOOL)createFile:(NSString *_Nonnull)path
{
    return [self createFile:path contents:nil];
}

+ (BOOL)copyFile:(NSString *_Nonnull)sourcePath toDesPath:(NSString *_Nonnull)desPath isOverWrite:(BOOL)flag
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSError *error;
    if ([self isExist:desPath]) {
        if (![self removeFile:desPath]) {
            return NO;
        }
    }
    
    [fileManager copyItemAtPath:sourcePath toPath:desPath error:&error];
    
    if (error) {
        return NO;
    }
    
    return YES;
}

#pragma mark - 私有方法
+ (BOOL)createFile:(NSString *_Nonnull)path contents:(NSData*)data
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    BOOL isDir;
    BOOL isExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        if (isDir) {
            return NO;
        }
        else{
            return YES;
        }
    }
    
    BOOL res = [fileManager createFileAtPath:path contents:data attributes:nil];
    return res;
}

#pragma mark - iCloud不备份方法
/**
 *  把目录设置为iCloud不自动备份(do not back up)
 *  https://developer.apple.com/library/ios/qa/qa1719/_index.html
 *
 *  支付iOS5.0.1及以上版本的SDK
 *
 *  @param URL 路径
 *
 *  @return 是否设置成功
 */
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    if (!URL) return NO;
    
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    
    if ([systemVersion floatValue]>=5.1) {
        NSError *error = nil;
        BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                      forKey: NSURLIsExcludedFromBackupKey error: &error];
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        return success;
    }
    else if ([systemVersion isEqualToString:@"5.0.1"]) {
        
        const char* filePath = [[URL path] fileSystemRepresentation];
        
        const char* attrName = "com.apple.MobileBackup";
        u_int8_t attrValue = 1;
        
        int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
        return result == 0;
    }
    
    return YES;
}
@end
