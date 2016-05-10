//
//  InviteCodeViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/5/1.
//  Copyright © 2016年 Zuo. All rights reserved.
//

//https://leancloud.cn:443/1.1/classes/InvitationCode?where=%7B%22key%22%3A%22bsb%22%7D&limit=1&&order=-updatedAt&&keys=-ACL%2C-createdAt%2C-updatedAt%2C-objectId%2C-count

#import "InviteCodeViewController.h"

#define URL @"https://leancloud.cn:443/1.1/classes/InvitationCode?where=%7B%22key%22%3A%22bsb%22%7D&limit=1&&order=-updatedAt&&keys=-ACL%2C-createdAt%2C-updatedAt%2C-objectId%2C-count"

@interface InviteCodeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UIButton *personalBtn;
@property (weak, nonatomic) IBOutlet UIButton *groupBtn;

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
    if (sender.tag == 1000) {
        SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
        [_urlParamsReq setUrlString:URL];
        [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successRequest){
            NSArray *results=[[successRequest.responseString objectFromJSONString] valueForKey:@"results"];
            NSString* key=[results[0] objectForKey:@"key"];
            [MBProgressHUD bwm_showTitle:[@"验证码:" stringByAppendingString:key] toView:self.view  hideAfter:3.0f];
        } failureBlock:^(SSLXResultRequest *failRequest){
            NSString *_errorMsg = [[failRequest.responseString objectFromJSONString] objectForKey:@"error"];
            _errorMsg?[MBProgressHUD showError:_errorMsg]:[MBProgressHUD showError:kMBProgressErrorTitle];
        }];
    }else if(sender.tag == 1001){
        SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
        [_urlParamsReq setUrlString:URL];
        [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successRequest){
            NSArray *results=[[successRequest.responseString objectFromJSONString] valueForKey:@"results"];
            NSString* key=[results[0] objectForKey:@"key"];
            [MBProgressHUD bwm_showTitle:[@"验证码:" stringByAppendingString:key] toView:self.view  hideAfter:3.0f];
        } failureBlock:^(SSLXResultRequest *failRequest){
            NSString *_errorMsg = [[failRequest.responseString objectFromJSONString] objectForKey:@"error"];
            _errorMsg?[MBProgressHUD showError:_errorMsg]:[MBProgressHUD showError:kMBProgressErrorTitle];
        }];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
