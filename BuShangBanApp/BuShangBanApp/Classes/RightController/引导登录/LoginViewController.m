//
//  LoginViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#define URL @"https://leancloud.cn:443/1.1/login?username=%@&password=%@"

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "AFHTTPSessionManager.h"
#import "MainTabViewController.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]

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
    _registBtn.titleLabel.font=[UIFont fontWithName:@"PingFang TC Light" size:14];
    [_registBtn setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    _registBtn.frame=CGRectMake(kScreenWidth-50, 20, 44,44);
    _registBtn.tag=1001;
    [self.view addSubview:_registBtn];
    
    _accountTF=[self textFieldWithPlaceHolder:@"手机号" imageNamed:@"phone number"];
    _passWordTF=[self textFieldWithPlaceHolder:@"密码" imageNamed:@"password"];
    _passWordTF.top=_accountTF.bottom;
    
    
    [self shapeLayerWithStartPoint:CGPointMake(_accountTF.left, _accountTF.bottom-8) endPoint:CGPointMake(_accountTF.right, _accountTF.bottom-8)];
    [self shapeLayerWithStartPoint:CGPointMake(_passWordTF.left, _passWordTF.bottom-8) endPoint:CGPointMake(_passWordTF.right, _passWordTF.bottom-8)];
    
    _loginBtn=[self buttonWithImageName:@"Button" tag:1002 frame:CGRectMake(0, _passWordTF.bottom+74, 300 *adapt.scaleWidth, 44 *adapt.scaleHeight) title:@"登录"];
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
    
    if([self  __validateMobile:_accountTF.text])
    {
        [MBProgressHUD showError:@"手机号格式不对"];
        return NO;
    }
    
    if ([_passWordTF.text isEqualToString:@""]){
        _passWordTF.secureTextEntry=YES;
        [MBProgressHUD showError:@"密码不能为空"];
        return NO;
    }
    if ([_passWordTF.text length]<6) {
        [MBProgressHUD showError:@"密码不能小于6位"];
        return NO;
    }
    
    
    return YES;
}

//手机号码验证
- (BOOL) __validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

-(void)clickEvent:(UIButton *)sender
{
    [super clickEvent:sender];
    NSString *tempUserName = _accountTF.text;
    NSString *tempPassword = _passWordTF.text;
    switch (sender.tag) {
        case 1000:
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[MainTabViewController getMain] backToHomeController];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"gotoFirstPage" object:nil];
            break;
        }
        case 1001:
            [[SliderViewController sharedSliderController].navigationController pushViewController:[[RegistViewController alloc] init] animated:YES];
            break;
        case 1002:
        {
            if([self __check])
            {
                SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
                    NSString *urlString = [NSString stringWithFormat:URL,tempUserName,tempPassword];
                    [_urlParamsReq setUrlString:urlString];
                    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successRequest){
                    
                    if ([[successRequest.responseString objectFromJSONString] valueForKey:@"sessionToken"]) {
                            [MBProgressHUD showSuccess:@"登录成功"];
                            NSString *sessionToken =[[successRequest.responseString objectFromJSONString] valueForKey:@"sessionToken"];
                            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                            [userDefaults setObject:sessionToken forKey:kSessionToken];
                        
                            [userDefaults setObject:@"1" forKey:kLoginStatus];
                        
                            [self.navigationController popToRootViewControllerAnimated:YES];

                            [[NSNotificationCenter defaultCenter] postNotificationName:@"judgeLoginStatus" object:nil];

                        }
                    
                } failureBlock:^(SSLXResultRequest *failRequest){
                                        
                    NSDictionary *_failDict = [failRequest.responseString objectFromJSONString];
                    NSString *_errorMsg = [_failDict objectForKey:@"error"];
                    if (_errorMsg) {
                        
                        [MBProgressHUD showError:_errorMsg];
                        
                
                    }
                    else {
                        [MBProgressHUD showError:kMBProgressErrorTitle];
                    }
                }];
            }
            break;
        }
    }
}


@end
