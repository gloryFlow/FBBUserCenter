//
//  ShopCenterPageViewController.m
//  FBBShopCenter
//
//  Created by guobingwei on 2017/7/20.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "ShopCenterPageViewController.h"
#import "HttpMobApi.h"
#import <MGJRouter/MGJRouter.h>

@interface ShopCenterPageViewController ()

@property (nonatomic, strong) UIButton *shopDemoButton;
@property (nonatomic, strong) UIButton *userDemoButton;

@end

@implementation ShopCenterPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.98 green:0.90 blue:0.90 alpha:1.0];
    self.title = @"商家模块";
    
    _shopDemoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _shopDemoButton.frame = CGRectMake(100.0, 250.0, 100.0, 50.0);
    _shopDemoButton.backgroundColor = [UIColor purpleColor];
    [_shopDemoButton setTitle:@"获取天气数据" forState:UIControlStateNormal];
    _shopDemoButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_shopDemoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shopDemoButton addTarget:self action:@selector(shopDemoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _shopDemoButton.layer.borderWidth = 0.5;
    _shopDemoButton.layer.masksToBounds = YES;
    [self.view addSubview:_shopDemoButton];
    
    _userDemoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _userDemoButton.frame = CGRectMake(100.0, 250.0, 200.0, 50.0);
    _userDemoButton.backgroundColor = [UIColor purpleColor];
    [_userDemoButton setTitle:@"从商家模块跳转到用户模块" forState:UIControlStateNormal];
    _userDemoButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_userDemoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_userDemoButton addTarget:self action:@selector(userDemoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _userDemoButton.layer.borderWidth = 0.5;
    _userDemoButton.layer.masksToBounds = YES;
    [self.view addSubview:_userDemoButton];
}

- (void)shopDemoButtonAction {
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"杭州",@"city",
                                   @"浙江",@"province",
                                   @"174d9f1f86365",@"key",
                                   nil];
    
    NSString *url = @"v1/weather/query";
    [HttpMobApi get:url params:params success:^(id responseObj) {
        NSLog(@"responseObj:%@",responseObj);
    } failure:^(HttpError *e) {
        NSLog(@"e:%@",e);
    }];
}

- (void)userDemoButtonAction {
    [MGJRouter openURL:@"fbb://scheme/userpage?userId=100000"
          withUserInfo:@{@"navigationVC" : self.navigationController}
            completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
