//
//  UserProtocalViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/26.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "UserProtocalViewController.h"

@interface UserProtocalViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation UserProtocalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBarWithTitle:@"用户协议"];
    [self defaultLeftItem];
    self.textView.editable=NO;
}

@end
