//
//  ShopCenterModule.m
//  FBBShopCenter
//
//  Created by guobingwei on 2017/7/20.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "ShopCenterModule.h"
#import <MGJRouter/MGJRouter.h>
#import "ShopCenterPageViewController.h"

@implementation ShopCenterModule

// 在load方法中自动注册，在主工程中不用写任何代码。
+ (void)load {
    [MGJRouter registerURLPattern:@"fbb://scheme/shoppage" toHandler:^(NSDictionary *routerParameters) {
        UINavigationController *navigationVC = routerParameters[MGJRouterParameterUserInfo][@"navigationVC"];
        
        ShopCenterPageViewController *shopPageVC = [[ShopCenterPageViewController alloc] init];
        [navigationVC pushViewController:shopPageVC animated:YES];
    }];
}

@end

