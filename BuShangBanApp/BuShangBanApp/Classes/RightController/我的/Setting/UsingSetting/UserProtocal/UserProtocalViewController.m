//
//  UserProtocalViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "UserProtocalViewController.h"

@interface UserProtocalViewController ()

@end

@implementation UserProtocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBarWithTitle:@"用户协议"];
    [self defaultLeftItem];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
