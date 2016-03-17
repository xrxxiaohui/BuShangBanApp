//
//  OneRedViewController.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/10.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "OneRedViewController.h"

@implementation OneRedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;
        //        [[ConstObject instance] setVc:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置标题
    self.view.backgroundColor = COLOR(0xff, 0xff, 0xff);
    // OneRed按钮
    _oneRedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _oneRedBtn.frame = CGRectMake(20, 0 + 210-64+44+20 , kScreenWidth-40, 45);
    [_oneRedBtn setBackgroundColor:COLOR1(255, 62, 48)];
    _oneRedBtn.layer.masksToBounds = YES;
    _oneRedBtn.layer.cornerRadius = 5.0f;
    [_oneRedBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_oneRedBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
//    [_oneRedBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_oneRedBtn addTarget:self action:@selector(oneRedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //    loginBtn.showsTouchWhenHighlighted = YES;
    [self.view addSubview:_oneRedBtn];
}

#pragma mark - Action

-(void)oneRedBtnClick:(UIButton *)sender {
    
}

@end
