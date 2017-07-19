//
//  UserHomePageViewController.m
//  FBBUserCenter
//
//  Created by guobingwei on 2017/7/19.
//  Copyright © 2017年 demo. All rights reserved.
//

#import "UserHomePageViewController.h"
#import "HttpMobApi.h"

@interface UserHomePageViewController ()

@property (nonatomic, strong) UIButton *demoButton;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
