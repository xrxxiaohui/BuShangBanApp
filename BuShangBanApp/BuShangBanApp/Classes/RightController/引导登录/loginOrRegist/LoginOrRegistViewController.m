//
//  LoginOrRegistViewController.m
//  Youqun
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

#import "LoginOrRegistViewController.h"
#import "LoginViewOrRegistView.h"
#import "AboutUserProtocalViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface LoginOrRegistViewController ()
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)LoginViewOrRegistView *loginViewOrRegistView;
@property(nonatomic,strong)NSTimer *cutDownTimer;

@end

@implementation LoginOrRegistViewController
{
    NSInteger _totalTime;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _totalTime=60;
    _isLogin=YES;
    [self initLoginViewOrRegistView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

-(NSTimer *)cutDownTimer
{
    if (!_cutDownTimer) {
        _cutDownTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCutDown) userInfo:nil repeats:YES];
    }
    return _cutDownTimer;
}

-(void)initLoginViewOrRegistView
{
    _loginViewOrRegistView=[[LoginViewOrRegistView alloc]initWithFrame:self.view.bounds];
    _loginViewOrRegistView.isLogin=_isLogin;
    _loginViewOrRegistView.center=self.view.center;
    [self.view addSubview:_loginViewOrRegistView];
}

-(void)setIsLogin:(BOOL)isLogin{
    _isLogin=isLogin;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL)isRegisted
{
    
    
    return YES;
}

#pragma mark ---- 点击事件  ----
-(void)clickAction:(UIButton *)btn
{
    if (btn.tag==1001)
    {
        btn.selected=!btn.selected;
    }
    else if(btn.tag==1002)
    {
        AboutUserProtocalViewController * about = [[AboutUserProtocalViewController alloc] init];
        [self.navigationController pushViewController:about animated:YES];
    }
}

-(void)loginOrRegist
{
    if (![self confirmation])
        return;
    
    [AVOSCloud verifySmsCode:self.loginViewOrRegistView.confirmationCodeTF.text mobilePhoneNumber:self.loginViewOrRegistView.phoneNumberTF.text callback:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
//            if (_user.isLogin)
//            {
//                if (![self isRegisted])
//                {
//                    [MBProgressHUD showError:@"账号已注册可以直接登录"];
//                    return;
//                }
//            [[NSUserDefaults standardUserDefaults] setObject:self.loginViewOrRegistView.phoneNumberTF.text forKey:@"phoneNumber"];
//            }
//            else
//            {
//                [del.loginManager loginWithUserAccount:self.loginViewOrRegistView.phoneNumberTF.text password:@"nopassword" type:@"nopassword"];
//            }
        }
        else
        {
            [MBProgressHUD showError:@"验证失败，请检查验证码"];
        }
    }];
}

- (void)sendCode:(UIButton *)sender {
    if ([self confirmation])
        return;
    sender.alpha=0.6;
    sender.userInteractionEnabled = NO;
    [self cutDownTimer];
    [self.loginViewOrRegistView.confirmationCodeTF becomeFirstResponder];
    [AVOSCloud requestSmsCodeWithPhoneNumber:self.loginViewOrRegistView.phoneNumberTF.text  appName:nil operation:nil
     timeToLive:10  callback:^(BOOL succeeded, NSError *error)
    {
        if (succeeded)
     {
        [MBProgressHUD showSuccess:@"发送成功,请稍等"];
         [_loginViewOrRegistView.confirmationCodeTF becomeFirstResponder];
     }
     else
     {
         [MBProgressHUD showError:@"发送失败,请检查后重新发送"];
     }
    }];
}

-(void)rightLoginOrRegist
{
    _isLogin=!_isLogin;
    [self initLoginViewOrRegistView];
}

 -(BOOL) validateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

-(BOOL)confirmation
{
    if ( [self validateMobile:self.loginViewOrRegistView.phoneNumberTF.text])
    {
        [MBProgressHUD showError:@"手机号不对"];
        return NO;
    }
    if(!_isLogin)
    {
        if (!self.loginViewOrRegistView.readedBtn.selected)
        {
            [MBProgressHUD showError:@"请先阅读并同意书单用户协议及隐私协议~"];
            return NO;
        }
    }
    return  YES;
}

-(void)timeCutDown
{
    [self.loginViewOrRegistView.getConfirmationCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒",(long)--_totalTime] forState:UIControlStateNormal];
    if (_totalTime == 0) {
        self.loginViewOrRegistView.getConfirmationCodeBtn.userInteractionEnabled=YES;
        [self.loginViewOrRegistView.getConfirmationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.loginViewOrRegistView.getConfirmationCodeBtn.alpha=1;
        _totalTime=60;
        [_cutDownTimer invalidate];
        _cutDownTimer=nil;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
