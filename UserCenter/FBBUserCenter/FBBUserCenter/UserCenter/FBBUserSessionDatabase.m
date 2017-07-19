//
//  FBBUserSessionDatabase.m
//  FBBUserCenter
//
//  Created by guobingwei on 2017/7/19.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "FBBUserSessionDatabase.h"

static NSString *userInfoPath = @"loginUserInfoPathKey";
static FBBUserSessionDatabase *instance = nil;

@implementation FBBUserSessionDatabase

+ (id)shareInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSString *)userInfoPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *userPath = [documentPath stringByAppendingPathComponent:userInfoPath];
    
    return userPath;
}

- (FBBUserSession *)getSessionInfoFromDb
{
    NSString *dataFile = [self userInfoPath];
    @try
    {
        FBBUserSession *session = [NSKeyedUnarchiver unarchiveObjectWithFile:dataFile];
        if (session) {
            return session;
        }
    }
    @catch (NSException *e)
    {
        
    }
    
    return nil;
}

- (void)saveSessionInfoToDb:(FBBUserSession *)info
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:info];
    NSString *dataFile = [self userInfoPath];
    
    BOOL isSave = [data writeToFile:dataFile atomically:YES];
    if (isSave) {
        NSLog(@"存储成功");
    } else {
        NSLog(@"存储失败");
    }
}

@end
