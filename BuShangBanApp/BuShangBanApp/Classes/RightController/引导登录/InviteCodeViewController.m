//
//  InviteCodeViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 Zuo. All rights reserved.
//

//https://leancloud.cn:443/1.1/classes/InvitationCode?where=%7B%22key%22%3A%22bsb%22%7D&limit=1&&order=-updatedAt&&keys=-ACL%2C-createdAt%2C-updatedAt%2C-objectId%2C-count

//个人邀请码 http://bushangban.duapp.com/invitationCode/invitationCode/personalInvitationCode.html

//企业邀请码申请 http://bushangban.duapp.com/invitationCode/invitationCode/companyInvitationCode.html

#define URL @"https://leancloud.cn:443/1.1/classes/InvitationCode?where=%7B%22key%22%3A%22bsb%22%7D&limit=1&&order=-updatedAt&&keys=-ACL%2C-createdAt%2C-updatedAt%2C-objectId%2C-count"

#import "InviteCodeViewController.h"

@interface InviteCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UIButton *personalBtn;
@property (weak, nonatomic) IBOutlet UIButton *groupBtn;
@property(nonatomic,weak)UIWebView *webView;
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
    
    if (sender.tag == 1000)
        [self __loadWebViewWithURL:@"http://form.mikecrm.com/m91Rdl"];
    else if(sender.tag == 1001)
         [self __loadWebViewWithURL:@"http://form.mikecrm.com/D7yX9W"];
    else if(sender.tag ==1003)
        [self.navigationController popViewControllerAnimated:YES];
}

-(void)__loadWebViewWithURL:(NSString *)url
{
    if (!_webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 66, kScreenWidth, kScreenHeight-66)];
        [webView setScalesPageToFit:YES];
        [webView setContentMode:UIViewContentModeTop];
        _webView=webView;
        [self.view addSubview:_webView];
        NSURLRequest *_request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        [_webView loadRequest:_request];
    }else
    {
        [_webView removeFromSuperview];
    }
}

@end
