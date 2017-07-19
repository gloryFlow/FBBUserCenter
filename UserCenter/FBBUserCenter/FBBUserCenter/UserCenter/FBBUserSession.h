//
//  FBBUserSession.h
//  FBBUserCenter
//
//  Created by guobingwei on 2017/7/19.
//  Copyright © 2017年 demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBBUserSession : NSObject<NSCoding>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userNo;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *cookie;

@property (nonatomic, assign) BOOL isLogin;

+ (FBBUserSession *)shareInstance;

//退出情况数据
- (void)clear;

@end
