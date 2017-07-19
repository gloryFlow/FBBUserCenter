//
//  FBBUserSessionDatabase.h
//  FBBUserCenter
//
//  Created by guobingwei on 2017/7/19.
//  Copyright © 2017年 demo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBBUserSession.h"

#define kSessionUserInfo @"sessionUserInfo"

@interface FBBUserSessionDatabase : NSObject

+ (id)shareInstance;

- (FBBUserSession *)getSessionInfoFromDb;

- (void)saveSessionInfoToDb:(FBBUserSession *)info;

@end
