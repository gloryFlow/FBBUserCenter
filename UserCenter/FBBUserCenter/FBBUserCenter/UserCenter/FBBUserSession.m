//
//  FBBUserSession.m
//  FBBUserCenter
//
//  Created by guobingwei on 2017/7/19.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "FBBUserSession.h"
#import "FBBUserSessionDatabase.h"

#define LoginUserId @"userId"

static void *sessionNeeLoginKey = &sessionNeeLoginKey;

static FBBUserSession *session = nil;

@implementation FBBUserSession

+ (FBBUserSession *)shareInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        session = [[FBBUserSessionDatabase shareInstance] getSessionInfoFromDb];
        if (!session) {
            session = [[self alloc] init];
        }
    });
    return session;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.userId = [aDecoder decodeObjectForKey:@"kSessionUserId"];
        self.userNo = [aDecoder decodeObjectForKey:@"kSessionUserNo"];
        self.userPhone = [aDecoder decodeObjectForKey:@"kSessionUserPhone"];
        self.token = [aDecoder decodeObjectForKey:@"kSessionUserToken"];
        self.cookie = [aDecoder decodeObjectForKey:@"kSessionUserCookie"];
        self.isLogin = [aDecoder decodeBoolForKey:@"kSessionIsLogin"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_userId forKey:@"kSessionUserId"];
    [aCoder encodeObject:_userNo forKey:@"kSessionUserNo"];
    [aCoder encodeObject:_userPhone forKey:@"kSessionUserPhone"];
    [aCoder encodeObject:_token forKey:@"kSessionUserToken"];
    [aCoder encodeObject:_cookie forKey:@"kSessionUserCookie"];
    [aCoder encodeBool:_isLogin forKey:@"kSessionIsLogin"];
}

- (void)clear {
    self.userNo = nil;
    self.userPhone = nil;
    self.token = nil;
    self.cookie = nil;
    self.userId = nil;
    self.isLogin = NO;
}

- (void)dealloc {
    self.userNo = nil;
    self.userPhone = nil;
    self.token = nil;
    self.cookie = nil;
    self.userId = nil;
}

@end
