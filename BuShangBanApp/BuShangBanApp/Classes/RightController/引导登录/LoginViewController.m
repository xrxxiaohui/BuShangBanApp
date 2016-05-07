//
//  LoginViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//



#import "LoginViewController.h"
#import "RegistViewController.h"
#import "AFHTTPSessionManager.h"

#define URL @"https://leancloud.cn:443/1.1/login?username=xinzhi&password=666666"


@interface LoginViewController ()
{
    UIButton *_registBtn;
    UITextField *_accountTF;
    UITextField *_passWordTF;
    UIButton *_loginBtn;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __initView];
}

-(void)__initView
{
    _registBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    _registBtn.titleLabel.font=[UIFont fontWithName:@"PingFang TC-Light" size:14];
    [_registBtn setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    _registBtn.frame=CGRectMake(kScreenWidth-60, 20, 44, 44);
    _registBtn.tag=1001;
    [self.view addSubview:_registBtn];
    
    _accountTF=[self textFieldWithPlaceHolder:@"手机号/邮箱" imageNamed:@"phone number"];
    
    _passWordTF=[self textFieldWithPlaceHolder:@"密码" imageNamed:@"password"];
    _passWordTF.top=_accountTF.bottom;
    
    [self shapeLayerWithStartPoint:CGPointMake(_accountTF.left, _accountTF.bottom-8) endPoint:CGPointMake(_accountTF.right, _accountTF.bottom-8)];
    [self shapeLayerWithStartPoint:CGPointMake(_passWordTF.left, _passWordTF.bottom-8) endPoint:CGPointMake(_passWordTF.right, _passWordTF.bottom-8)];
    
    _loginBtn=[self buttonWithImageName:@"Button" tag:1002 frame:CGRectMake(0, _passWordTF.bottom+74, 300, 44) title:@"登录"];
    _loginBtn.centerX=self.view.centerX;
    [_contentView addSubview:_loginBtn];
    
    _contentView.height=_loginBtn.bottom;
}


-(BOOL)__check
{
    if ([_accountTF.text isEqualToString:@""]){
        [MBProgressHUD showError:@"账号不能为空"];
        return NO;
    }
    if ([_passWordTF.text isEqualToString:@""]){
        [MBProgressHUD showError:@"密码不能为空"];
        return NO;
    }
    return YES;
}

-(void)clickEvent:(UIButton *)sender
{
    [super clickEvent:sender];
    switch (sender.tag) {
        case 1000:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 1001:
            [[SliderViewController sharedSliderController].navigationController pushViewController:[[RegistViewController alloc] init] animated:YES];
            break;
        case 1002:
        {
            if([self __check])
            {
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URL]];
                request.HTTPMethod = @"GET";
                [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
                NSDictionary *dic=@{@"password":_passWordTF.text,@"username":_accountTF.text};
                [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil]];
                [request addValue: @"fdOqfdJ3Ypgv6iaQJXLw7CgR-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
                [request addValue: @"MDOagSCTlLw9A6fkrcaphlB8" forHTTPHeaderField:@"X-LC-Key"];
                AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
                [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
                    [self.navigationController popToRootViewControllerAnimated:YES];
                } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
                    if(error.code ==201)
                        [MBProgressHUD showError:@"用户名或密码错误"];
                }];
                [operation start];
            }
            break;
        }
    }
}


@end
