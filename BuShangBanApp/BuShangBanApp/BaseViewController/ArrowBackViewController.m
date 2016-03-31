//
//  ArrowBackViewController.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/12.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "ArrowBackViewController.h"

@implementation ArrowBackViewController

-(void)viewDidLoad {
    
    [super viewDidLoad];
    
    _navHeight = 64.0f;
    
    //左侧返回
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(7.5f, (self.navView.height - 40)/2, 40, 40)];
    [btn setImage:[UIImage imageNamed:@"returnPic"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"returnLighted"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(toReturn) forControlEvents:UIControlEventTouchUpInside];
    //             btn.showsTouchWhenHighlighted = YES;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self customLeftItemWithBtn:btn];
}

-(void)toReturn{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshLeftView object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
