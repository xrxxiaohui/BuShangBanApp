//
//  InviteCodeViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "InviteCodeViewController.h"

@interface InviteCodeViewController ()

@end

@implementation InviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"邀请码";
}
- (IBAction)btnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
