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
    UIStoryboard *UserProtocal=[UIStoryboard storyboardWithName:@"UserProtocal" bundle:nil];
    UIView *view=[UserProtocal instantiateViewControllerWithIdentifier:@"UserProtocal"].view;
    [self.view addSubview:view];
    
//    for (UIView *aview; <#condition#>; <#increment#>) {
//        <#statements#>
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
