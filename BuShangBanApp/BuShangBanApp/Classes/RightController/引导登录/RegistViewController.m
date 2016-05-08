//
//  RegistViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "RegistViewController.h"
#import "LoginViewController.h"
#import "InviteCodeViewController.h"
#import "UserProtocalViewController.h"
#import "BootstrapViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "AccessSendSmsApi.h"

//验证邀请码接口 https://leancloud.cn:443/1.1/classes/InvitationCode?where=%7B%22key%22%3A%22bsb%22%7D&limit=1&&order=-updatedAt&&keys=-ACL%2C-createdAt%2C-updatedAt%2C-objectId%2C-count

//获取短信验证码  https://api.leancloud.cn/1.1/requestSmsCode
#define requestSmsCode @"https://api.leancloud.cn/1.1/requestSmsCode"

#define iniviteURL @"https://leancloud.cn:443/1.1/classes/InvitationCode?where=%7B%22key%22%3A%22bsb%22%7D&limit=1&&order=-updatedAt&&keys=-ACL%2C-createdAt%2C-updatedAt%2C-objectId%2C-count"



@interface RegistViewController ()
{
    UIButton *_loginBtn;
    UITextField *_accountTF;
    UITextField *_verificationCodeTF;
    UITextField *_passWordTF;
    UITextField *_passWordAgainTF;
    UIButton *_getCodeBtn;
    UITextField *_inivitTF;
    UIButton *_inivitBtn;
    UIButton *_registBtn;
    UIButton *_readedBtn;
    UIButton *_userProtocalBtn;
    NSTimer *_cutDownTimer;
}
@end

@implementation RegistViewController{
    NSInteger _totalTime;
}

    
- (void)viewDidLoad {
    [super viewDidLoad];
    _totalTime = 60;
    [self __initView];
}

-(void)__initView
{
    _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.titleLabel.font=[UIFont fontWithName:@"PingFang TC-Light" size:14];
    [_loginBtn setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    _loginBtn.frame=CGRectMake(kScreenWidth-60, 20, 44,44);
    _loginBtn.tag=1001;
    [self.view addSubview:_loginBtn];
    
    _accountTF=[self textFieldWithPlaceHolder:@"手机号/邮箱" imageNamed:@"phone number"];
    
    _verificationCodeTF=[self textFieldWithPlaceHolder:@"验证码" imageNamed:@"Verification code"];
    _verificationCodeTF.keyboardType=UIKeyboardTypeNumberPad;
    _verificationCodeTF.top=_accountTF.bottom;
    _verificationCodeTF.width=180;
    
    _getCodeBtn=[self buttonWithImageName:@"Get button" tag:1002 frame:CGRectMake(_verificationCodeTF.right+20, 0, 100, 30) title:@"获取验证码"];
    _getCodeBtn.titleLabel.font=[UIFont fontWithName:fontName size:12];
    _getCodeBtn.bottom=_verificationCodeTF.bottom-8;
    [_contentView addSubview:_getCodeBtn];
    
    _passWordTF=[self textFieldWithPlaceHolder:@"密码" imageNamed:@"password"];
    _passWordTF.top=_getCodeBtn.bottom;
    
    _passWordAgainTF=[self textFieldWithPlaceHolder:@"再次输入密码" imageNamed:@"password again"];
    _passWordAgainTF.top=_passWordTF.bottom;
    
    [self shapeLayerWithStartPoint:CGPointMake(_passWordAgainTF.left, _passWordAgainTF.bottom-8) endPoint:CGPointMake(_passWordAgainTF.right, _passWordAgainTF.bottom-8)];
    
    _inivitTF=[self textFieldWithPlaceHolder:@"邀请码" imageNamed:@"Invitation code"];
    _inivitTF.top=_passWordAgainTF.bottom;
    
    _inivitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_inivitBtn setImage:[UIImage imageNamed:@"problem"] forState:UIControlStateNormal];
    [_inivitBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    _inivitBtn.size=CGSizeMake(44, 44);
    _inivitBtn.right=_inivitTF.right+13;
    _inivitBtn.bottom=_inivitTF.bottom;
    _inivitBtn.tag=1006;
    [_contentView addSubview:_inivitBtn];
    
    [self shapeLayerWithStartPoint:CGPointMake(_accountTF.left, _accountTF.bottom-8) endPoint:CGPointMake(_accountTF.right, _accountTF.bottom-8)];
    [self shapeLayerWithStartPoint:CGPointMake(_verificationCodeTF.left, _verificationCodeTF.bottom-8) endPoint:CGPointMake(_verificationCodeTF.right, _verificationCodeTF.bottom-8)];
    [self shapeLayerWithStartPoint:CGPointMake(_passWordTF.left, _passWordTF.bottom-8) endPoint:CGPointMake(_passWordTF.right, _passWordTF.bottom-8)];
    [self shapeLayerWithStartPoint:CGPointMake(_inivitTF.left, _inivitTF.bottom-8) endPoint:CGPointMake(_inivitTF.right, _inivitTF.bottom-8)];
    
    _registBtn=[self buttonWithImageName:@"Button" tag:1003 frame:CGRectMake(0,0, 300, 44) title:@"注册"];
    _registBtn.top=_inivitTF.bottom+64;
    _registBtn.centerX=self.view.centerX;
    [_contentView addSubview:_registBtn];
    
    _contentView.height=_registBtn.bottom;
    
    _readedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_readedBtn setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    [_readedBtn setImage:[UIImage imageNamed:@"方框"] forState:UIControlStateNormal];
    [_readedBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
    [_readedBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary *dic1=@{NSFontAttributeName:[UIFont fontWithName:fontName size:10],
                        NSForegroundColorAttributeName:[UIColor colorWithHexString:@"383838"]};
    NSAttributedString *attr1=[[NSAttributedString alloc] initWithString:@"我已阅读并同意不上班" attributes:dic1];
    [_readedBtn setAttributedTitle:attr1 forState:UIControlStateNormal];
    _readedBtn.titleEdgeInsets=UIEdgeInsetsMake(0,3,0,0);
    _readedBtn.size=CGSizeMake(120, [UIImage imageNamed:@"方框"].size.height);
    _readedBtn.bottom=kScreenHeight-20;
    _readedBtn.tag=1004;
    [self.view addSubview:_readedBtn];
    
    _userProtocalBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_userProtocalBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *dic=@{NSFontAttributeName:[UIFont fontWithName:fontName size:10],
                        NSForegroundColorAttributeName:[UIColor colorWithHexString:@"4a90e2"]};
    NSAttributedString *attr=[[NSAttributedString alloc] initWithString:@"用户协议" attributes:dic];
    [_userProtocalBtn setAttributedTitle:attr forState:UIControlStateNormal];
    _userProtocalBtn.tag=1005;
    [_userProtocalBtn sizeToFit];
    [self.view addSubview:_userProtocalBtn];
    _readedBtn.left=(kScreenWidth-_userProtocalBtn.width-_readedBtn.width)/2;
    _userProtocalBtn.left=_readedBtn.right;
    _userProtocalBtn.bottom=kScreenHeight-12;
}

-(void)clickEvent:(UIButton *)sender
{
    [super clickEvent:sender];
//    __block BOOL success=NO;
    switch (sender.tag) {
        case 1000:
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        case 1001:
             [[SliderViewController sharedSliderController].navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
            break;
        case 1002:
        {
            NSString *tempString = _accountTF.text;

            if ([tempString isEqualToString:@""]){
                [MBProgressHUD showError:@"号码不能为空"];
                return;
            }
            [self cutDownTimer];
            
            
//            AccessSendSmsApi *_accessSendSmsApi = [[AccessSendSmsApi alloc] initWithUserPhone:tempString];
            SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
            [_urlParamsReq setUrlString:@"https://api.leancloud.cn/1.1/requestSmsCode"];
            NSDictionary *_paramsDict = @{
                                          @"mobilePhoneNumber":tempString?tempString:@0,
                                          @"X-LC-Id":@"fdOqfdJ3Ypgv6iaQJXLw7CgR-gzGzoHsz",
                                          @"X-LC-Key":@"MDOagSCTlLw9A6fkrcaphlB8",
                                          @"Content-Type":@"application/json"
                                          };
             [_urlParamsReq setParamsDict:_paramsDict];

            [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successRequest){
                
                if ([[successRequest.responseString objectFromJSONString] valueForKey:@"err"]) {
                    
                    [MBProgressHUD bwm_showTitle:[[successRequest.responseString objectFromJSONString] valueForKey:@"err"] toView:self.view hideAfter:2.0f];
                }
                else {
                    [MBProgressHUD bwm_showTitle:@"验证码发送成功" toView:self.view hideAfter:2.0f];
                }
                
                NSLog(@"access send sms success, successRequest: %@",[successRequest.responseString objectFromJSONString]);
                
            } failureBlock:^(SSLXResultRequest *failRequest){
                
                NSLog(@"access send sms fail");
                
                NSDictionary *_failDict = [failRequest.responseString objectFromJSONString];
                NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
                if (_errorMsg) {
                    
                    [MBProgressHUD showError:_errorMsg];
                    
                    //            UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:nil message:_errorMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    //            [_alertView show];
                }
                else {
                    [MBProgressHUD showError:kMBProgressErrorTitle];
                }
            }];
            
//        }else{
//            
//            [MBProgressHUD showError:@"请输入正确手机号"];
//            return;
//        }
            
//            if ([_accountTF.text containsString:@"."]) {
////                邮箱验证
//                
//                
//            }else
//            {

//            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
//            request.HTTPMethod = @"POST";
//            [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//            [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//            NSDictionary *dic=@{@"username":_accountTF.text};
//            [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil]];
//            [request addValue: @"fdOqfdJ3Ypgv6iaQJXLw7CgR-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
//            [request addValue: @"MDOagSCTlLw9A6fkrcaphlB8" forHTTPHeaderField:@"X-LC-Key"];
//            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull        responseObject) {
//                  [MBProgressHUD showError:@"已经发送"];
//            } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//                if(error.code ==201)
//                    [MBProgressHUD showError:@"号码有误"];
//            }];
//            }
            break;
        }
        case 1003:
        {
            if([self __check])
            {
                //                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                //                [manager GET:@"https://leancloud.cn:443/1.1/classes/_User/570387b3ebcb7d005b196d24" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                //
                ////                    if(![_verificationCodeTF.text isEqualToString:@""])
                ////                        [MBProgressHUD showError:@"验证码不对"];
                ////                    else if(![_inivitTF.text isEqualToString:@""])
                ////                        [MBProgressHUD showError:@"验证码不对"];
                ////                    else if(@"")
                ////                        [MBProgressHUD showError:@"这个账号已经注册过"];
                ////                    else
                //                        success=YES;
                //                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                //                    [MBProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
                //                }];
                //                if (success)
                {
                    [[SliderViewController sharedSliderController].navigationController pushViewController:[[BootstrapViewController alloc] init] animated:YES];
                    
                    //                    NSDictionary *dic=@{};
                    //                    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"UserInfo"];
                }
            }
            
        }
            break;
        case 1004:
            _readedBtn.selected=!_readedBtn.selected;
            break;
        case 1005:
        {
            UIStoryboard *UserProtocal=[UIStoryboard storyboardWithName:@"UserProtocal" bundle:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:[UserProtocal                instantiateViewControllerWithIdentifier:@"UserProtocal"]  animated:YES];
            break;
        }
        case 1006:
        {
            UIStoryboard *UserProtocal=[UIStoryboard storyboardWithName:@"InviteCode" bundle:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:[UserProtocal                      instantiateViewControllerWithIdentifier:@"InviteCode"] animated:YES];
            break;
        }
    }
}
-(BOOL)__check
{
    NSArray *textFieldArray=[NSArray arrayWithObjects:_accountTF, _verificationCodeTF,_passWordTF,_passWordAgainTF,_inivitTF,nil];
    for (UITextField *textField in textFieldArray) {
        if ([textField.text isEqualToString:@""]) {
            [MBProgressHUD showError:[NSString stringWithFormat:@"%@不能为空",textField.placeholder]];
            return NO;
        }
    }
    if(![_passWordTF.text isEqualToString:_passWordAgainTF.text])
    {
        [MBProgressHUD showError:@"两次密码不一致"];
        return NO;
    }
    
    if(_passWordTF.text.length<10)
    {
        [MBProgressHUD showError:@"密码长度不能小于10"];
        return NO;
    }
    
    if ([_accountTF.text containsString:@"."])
        if(![self __validateEmail:_accountTF.text])
        {
            [MBProgressHUD showError:@"邮箱格式不对"];
            return NO;
        }
    else
        if(![self __validateMobile:_accountTF.text])
        {
            [MBProgressHUD showError:@"号码格式不对"];
            return NO;
        }
    
    return YES;
}

//邮箱
-(BOOL) __validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
- (BOOL) __validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


-(void)showKeyBoard:(NSNotification *)noti
{
    [super showKeyBoard:noti];
    _loginBtn.hidden=YES;
    _closeBtn.hidden=YES;
}

-(void)hideKeyBoard:(NSNotification *)noti
{
    [super hideKeyBoard:noti];
    _loginBtn.hidden=NO;
    _closeBtn.hidden=NO;
}


- (NSTimer *)cutDownTimer {
    if (!_cutDownTimer) {
        _cutDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCutDown) userInfo:nil repeats:YES];
    }
    return _cutDownTimer;
}

- (void)timeCutDown {
    [_getCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒", (long) --_totalTime] forState:UIControlStateNormal];
    _getCodeBtn.alpha = 0.2;
    _getCodeBtn.userInteractionEnabled=NO;
    if (_totalTime == 0) {
        _getCodeBtn.userInteractionEnabled = YES;
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _getCodeBtn.alpha = 1;
        _totalTime = 60;
        [_cutDownTimer invalidate];
        _cutDownTimer = nil;
    }
}
@end
