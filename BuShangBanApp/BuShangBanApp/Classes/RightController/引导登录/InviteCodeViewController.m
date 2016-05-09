//
//  InviteCodeViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "InviteCodeViewController.h"

@interface InviteCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;

@end

@implementation InviteCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"邀请码";
    self.textView1.editable=NO;
    self.textView2.editable=NO;
}
- (IBAction)btnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
