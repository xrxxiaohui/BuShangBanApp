//
//  BaseViewController.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/10.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController

-(void)viewDidLoad {

    [super viewDidLoad];
    
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
    
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshLeftView object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    //    if ([self respondsToSelector:@selector(presentingViewController)])
    //        [self dismissViewControllerAnimated:YES completion:nil];
    //    else
    //        [self.navigationController popViewControllerAnimated:YES];
    
}

@end
