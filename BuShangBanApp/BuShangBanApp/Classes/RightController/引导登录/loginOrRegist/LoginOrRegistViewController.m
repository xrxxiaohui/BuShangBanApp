//
//  LoginOrRegistViewController.m
//  Youqun
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

#import "LoginOrRegistViewController.h"
#import "LoginViewOrRegistView.h"
//#import "AboutUserProtocalViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"


@interface LoginOrRegistViewController ()<UITextFieldDelegate>
@property(nonatomic, strong) LoginViewOrRegistView *loginViewOrRegistView;
@property(nonatomic, strong) NSTimer *cutDownTimer;

@end

@implementation LoginOrRegistViewController {
    NSInteger _totalTime;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _totalTime = 60;
    _isTologin = YES;
    [self initLoginViewOrRegistView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)initLoginViewOrRegistView {
    _loginViewOrRegistView = [[LoginViewOrRegistView alloc] initWithFrame:self.view.bounds];
    _loginViewOrRegistView.center=self.view.center;
    _loginViewOrRegistView.isLogin = _isTologin;
    _loginViewOrRegistView.phoneNumberTF.delegate=self;
    _loginViewOrRegistView.confirmationCodeTF.delegate=self;
    
    [self.view addSubview:_loginViewOrRegistView];
}



-(void)getUserInfoWithUser:(SSDKUser *)user
{
    _user.platformType=(BuShangBanPlatformType)user.platformType ;
    _user.mid=user.uid;
    _user.nickName=user.nickname;
    _user.UserExtend.profile=user.aboutMe;
    _user.birthDay=user.birthday;
//    _user.avatar=user.icon;
    _user.gender=(BuShangBanGender)user.gender;
}

- (BOOL)isRegisted {
    return YES;
}


#pragma mark ---- 懒加载  ----





- (BOOL)validateMobile:(NSString *)mobile {
    NSString *phoneRegex = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark ---  delegate  ---



-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.tag==1000)
    {
        if (![self validateMobile:textField.text]) {
            [MBProgressHUD showError:@"手机号不对"];
            return ;
        }
    }
    else
    {
        if (!_isTologin)
        {
            if (!self.loginViewOrRegistView.readedBtn.selected) {
                [MBProgressHUD showError:@"请先阅读并同意书单用户协议及隐私协议~"];
            }
        }
    }
    [textField endEditing:YES];
}





- (void)loginOrRegist {
     [AVOSCloud verifySmsCode:_loginViewOrRegistView.confirmationCodeTF.text mobilePhoneNumber:_loginViewOrRegistView.phoneNumberTF.text callback:^(BOOL succeeded, NSError *error) {
     if (succeeded) {
     [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"LoginSuccess" object:nil]];
     
     //            if (_user.isToLogin)
     //            {
     //                if (![self isRegisted])
     //                {
     //                    [MBProgressHUD showError:@"账号已注册可以直接登录"];
     //                    return;
     //                }
     //            else
     //            {
     //                [del.loginManager loginWithUserAccount:self.loginViewOrRegistView.phoneNumberTF.text password:@"nopassword" type:@"nopassword"
     //            }
     }
     else {
     [MBProgressHUD showError:@"验证失败，请检查验证码"];
     }
     }];
}

- (void)defaultLogin {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"LoginSuccess" object:nil]];
}

- (void)login {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"LoginSuccess" object:nil]];
}


#pragma mark ---- 点击事件  ----

- (void)ssoLogInWechat {
    if ([WXApi isWXAppInstalled]) {
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            if (state == SSDKResponseStateSuccess) {
                [MBProgressHUD showSuccess:@"登录成功"];
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"LoginSuccess" object:nil]];
                
                [self getUserInfoWithUser:user];
                
            } else if (state == SSDKResponseStateFail) {
                [MBProgressHUD showError:@"登录失败"];
            }
        }];
    } else {
        [MBProgressHUD showError:@"没有安装维修客户端"];
    }
}

- (void)ssoLogInWeibo {
   
    
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            
            NSLog(@"****************SSDKResponseStateSuccess");
//            [MBProgressHUD showSuccess:@"登录成功"];
//            [self getUserInfoWithUser:user];
//            
//            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"LoginSuccess" object:nil]];
            //            _user.username;
        }
        else if (state == SSDKResponseStateFail) {
//            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"LoginSuccess" object:nil]];
            NSLog(@"************************SSDKResponseStateFail");
//            [MBProgressHUD showError:@"登录失败"];
        }
    }];
}



-(void)loginWithUsrDefault
{
    NSDictionary * loginInfo=[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginInfo"];
    _user.loginAcount=[loginInfo objectForKey:@"LoginAcount"];
    _user.login=[loginInfo objectForKey:@"LoginType"];
}


- (void)clickAction:(UIButton *)btn {
    if (btn.tag == 1001) {
        btn.selected = !btn.selected;
    }
    else if (btn.tag == 1002) {
//        AboutUserProtocalViewController *about = [[AboutUserProtocalViewController alloc] init];
//        [self.navigationController pushViewController:about animated:YES];
    }
}

- (void)sendCode:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.userInteractionEnabled = NO;
    [AVOSCloud requestSmsCodeWithPhoneNumber:_loginViewOrRegistView.phoneNumberTF.text appName:nil operation:nil timeToLive:10 callback:^(BOOL succeeded, NSError *error) {
        if (succeeded)
        {
            [_loginViewOrRegistView.confirmationCodeTF becomeFirstResponder];
            [MBProgressHUD showSuccess:@"发送成功,请稍等"];
        }
        else
        {
            [MBProgressHUD showError:@"发送失败,请检查后重新发送"];
        }
    }];
    sender.alpha = 0.6;
    [self cutDownTimer];
}

- (void)rightLoginOrRegist {
    _isTologin = !_isTologin;
    [self initLoginViewOrRegistView];
}


@end
