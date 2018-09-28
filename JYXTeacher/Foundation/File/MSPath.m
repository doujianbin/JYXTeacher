//
//  MSPath.m
//  MyShowFoundation
//
//  Created by Michael Ge on 15/11/5.
//

#import "MSPath.h"
#import "MSFile.h"

@implementation MSPath

+(NSString* _Nonnull)fullPathFromAssetsInMainBundle:(NSString * _Nullable)path
{
    NSString *mainBundle = [[NSBundle mainBundle] bundlePath];
    
    if (!path || [path length] == 0) {
        return [mainBundle stringByAppendingPathComponent:@"Assets"];
    }
    
    return [[mainBundle stringByAppendingPathComponent:@"Assets"] stringByAppendingPathComponent:path];
}

+ (NSString * _Nonnull)fullPathFromAssetsInLibrary:(NSString* _Nullable)path
{
    [MSFile ensureDirectoryInLibrary:@"Assets" skipBackup:YES];
    NSArray  *libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *hPath = [libPaths objectAtIndex:0];
    NSString *fullPath = [[hPath stringByAppendingPathComponent:@"Assets"] stringByAppendingPathComponent:path];
    
    return fullPath;
}

+ (NSString * _Nullable)getFullPathFromBundle:(NSString* _Nonnull)bundle
                                         file:(NSString* _Nonnull)name
                                       ofType:(NSString* _Nullable)type
{
    NSBundle *b = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:bundle ofType:@"bundle"]];
    if (b) {
        return [b pathForResource:name ofType:type];
    }
    
    return nil;
}

+ (NSString * _Nullable)getFullPathFromBundle:(NSString* _Nonnull)bundle
                                      subpath:(NSString* _Nonnull)subpath
{
    NSString *path = [[NSBundle mainBundle] pathForResource:bundle ofType:@"bundle"];
    if (path) {
        return [path stringByAppendingPathComponent:subpath];
    }
    
    return nil;
}

+ (NSString * _Nonnull)fullPathForCache:(NSString* _Nullable)subPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* dir = [paths objectAtIndex:0];
    
    
    if (subPath){
        [dir stringByAppendingPathComponent:subPath];
    }
    
    return dir;
}

+ (NSString * _Nonnull)fullPathForDocument:(NSString* _Nullable)subPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    
    if (subPath){
        docDir = [NSString stringWithFormat:@"%@/%@",docDir,subPath];
    }
    
    return docDir;
}
@end
