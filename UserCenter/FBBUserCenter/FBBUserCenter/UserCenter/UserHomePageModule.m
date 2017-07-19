//
//  UserHomePageModule.m
//  FBBUserCenter
//
//  Created by guobingwei on 2017/7/19.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "UserHomePageModule.h"
#import <MGJRouter/MGJRouter.h>
#import "UserHomePageViewController.h"

@implementation UserHomePageModule

// 在load方法中自动注册，在主工程中不用写任何代码。
+ (void)load {
    [MGJRouter registerURLPattern:@"fbb://scheme/userpage" toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        
        UserHomePageViewController *homePageVC = [[UserHomePageViewController alloc] init];
        [navigationVC pushViewController:homePageVC animated:YES];
    }];
}

@end
