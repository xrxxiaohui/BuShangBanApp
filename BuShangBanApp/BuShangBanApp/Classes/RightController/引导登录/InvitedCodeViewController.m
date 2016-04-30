//
//  InvitedCodeViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "InvitedCodeViewController.h"

@interface InvitedCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;

@end

@implementation InvitedCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_textView1 sizeToFit];
    [_textView2 sizeToFit];
}

- (IBAction)clickEvent:(id)sender {
    UIButton *btn=sender;
    //个个体邀请
    if (btn.tag == 1000)
    {
        
    }
    else
    {
        
    }
}



@end
