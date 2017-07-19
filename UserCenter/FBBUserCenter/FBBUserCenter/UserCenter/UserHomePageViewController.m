//
//  UserHomePageViewController.m
//  FBBUserCenter
//
//  Created by guobingwei on 2017/7/19.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "UserHomePageViewController.h"
#import "HttpMobApi.h"
#import "FBBUserSessionDatabase.h"

@interface UserHomePageViewController ()

@property (nonatomic, strong) UIButton *demoButton;
@property (nonatomic, strong) UIButton *saveButton;

@end

@implementation UserHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.91 blue:0.93 alpha:1.0];
    
    _demoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _demoButton.frame = CGRectMake(100.0, 150.0, 100.0, 50.0);
    _demoButton.backgroundColor = [UIColor brownColor];
    [_demoButton setTitle:@"获取数据" forState:UIControlStateNormal];
    _demoButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_demoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_demoButton addTarget:self action:@selector(demoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _demoButton.layer.borderWidth = 0.5;
    _demoButton.layer.masksToBounds = YES;
    [self.view addSubview:_demoButton];
    
    _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveButton.frame = CGRectMake(150.0, 250.0, 100.0, 50.0);
    _saveButton.backgroundColor = [UIColor brownColor];
    [_saveButton setTitle:@"保存用户数据" forState:UIControlStateNormal];
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];
    _saveButton.layer.borderWidth = 0.5;
    _saveButton.layer.masksToBounds = YES;
    [self.view addSubview:_saveButton];
}

- (void)demoButtonAction {
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

- (void)saveButtonAction {
    [FBBUserSession shareInstance].token = @"2222323232";
    [FBBUserSession shareInstance].userPhone = @"18758189050";
    [FBBUserSession shareInstance].userNo = @"10086";
    [FBBUserSession shareInstance].userId = @"10086";
    [FBBUserSession shareInstance].isLogin = YES;
    [[FBBUserSessionDatabase shareInstance] saveSessionInfoToDb:[FBBUserSession shareInstance]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
