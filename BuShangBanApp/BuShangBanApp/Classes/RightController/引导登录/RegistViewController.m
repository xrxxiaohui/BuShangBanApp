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
#import "ConstObject.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]

#define requestSmsCode @"https://api.leancloud.cn/1.1/requestSmsCode"
#define iniviteURL @"https://leancloud.cn:443/1.1/classes/InvitationCode?where=%7B%22key%22%3A%22bsb%22%7D&limit=1&&order=-updatedAt&&keys=-ACL%2C-createdAt%2C-updatedAt%2C-objectId%2C-count"
#define completeRegister @"https://api.leancloud.cn/1.1/batch"

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
    CGFloat _bottom;
    CGFloat _duration;
    CGFloat _count;
}
@end

@implementation RegistViewController{
    NSInteger _totalTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _totalTime = 60;
    _count=0;
    [self __initView];
}

-(void)__initView
{
    _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.titleLabel.font=[UIFont fontWithName:fontName size:14];
    [_loginBtn setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    _loginBtn.frame=CGRectMake(kScreenWidth-50, 20, 44,44);
    _loginBtn.tag=1001;
    [self.view addSubview:_loginBtn];
    
    _accountTF=[self textFieldWithPlaceHolder:@"手机号" imageNamed:@"phone number"];
    _accountTF.keyboardType=UIKeyboardTypeNumberPad;
    _accountTF.clearButtonMode=UITextFieldViewModeAlways;

    _verificationCodeTF=[self textFieldWithPlaceHolder:@"验证码" imageNamed:@"Verification code"];
    _verificationCodeTF.keyboardType=UIKeyboardTypeNumberPad;
    _verificationCodeTF.top=_accountTF.bottom;
    _verificationCodeTF.width=180 *adapt.scaleWidth;
    
    _getCodeBtn=[self buttonWithImageName:@"Get button" tag:1002 frame:CGRectMake(_verificationCodeTF.right+20, 0, 100 *adapt.scaleWidth, 30 *adapt.scaleHeight) title:@"获取验证码"];
    _getCodeBtn.titleLabel.font =[UIFont systemFontOfSize:ceilf(12*adapt.scaleWidth)];
    _getCodeBtn.bottom=_verificationCodeTF.bottom-8;
    [_contentView addSubview:_getCodeBtn];
    
    _passWordTF=[self textFieldWithPlaceHolder:@"密码" imageNamed:@"password"];
    _passWordTF.secureTextEntry=YES;
    _passWordTF.top=_verificationCodeTF.bottom;
    _passWordTF.clearButtonMode=UITextFieldViewModeAlways;
    
    _passWordAgainTF=[self textFieldWithPlaceHolder:@"再次输入密码" imageNamed:@"password again"];
    _passWordAgainTF.secureTextEntry=YES;
    _passWordAgainTF.top=_passWordTF.bottom;
    _passWordAgainTF.clearButtonMode=UITextFieldViewModeAlways;
    
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
    
    [self shapeLayerWithStartPoint:CGPointMake(_accountTF.left, _accountTF.bottom-8)
                          endPoint:CGPointMake(_accountTF.right, _accountTF.bottom-8)];
    [self shapeLayerWithStartPoint:CGPointMake(_verificationCodeTF.left, _verificationCodeTF.bottom-8)
                          endPoint:CGPointMake(_verificationCodeTF.right, _verificationCodeTF.bottom-8)];
    [self shapeLayerWithStartPoint:CGPointMake(_passWordTF.left, _passWordTF.bottom-8)
                          endPoint:CGPointMake(_passWordTF.right, _passWordTF.bottom-8)];
    [self shapeLayerWithStartPoint:CGPointMake(_passWordAgainTF.left, _passWordAgainTF.bottom-8)
                          endPoint:CGPointMake(_passWordAgainTF.right, _passWordAgainTF.bottom-8)];
    [self shapeLayerWithStartPoint:CGPointMake(_inivitTF.left, _inivitTF.bottom-8)
                          endPoint:CGPointMake(_inivitTF.right, _inivitTF.bottom-8)];
    
    _registBtn=[self buttonWithImageName:@"Button" tag:1003 frame:CGRectMake(0,0, 300*adapt.scaleWidth, 44*adapt.scaleHeight ) title:@"注册"];
    _registBtn.top=_inivitTF.bottom+64;
    _registBtn.centerX=self.view.centerX;
    [_contentView addSubview:_registBtn];
    _registBtn.selected=YES;
    
    _contentView.height=_registBtn.bottom;
    _bottom=_contentView.bottom;
    
    _readedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_readedBtn setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    [_readedBtn setImage:[UIImage imageNamed:@"方框"] forState:UIControlStateNormal];
    [_readedBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
    [_readedBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [_readedBtn  setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    [_readedBtn setTitle:@"我已阅读并同意不上班" forState:UIControlStateNormal];
    _readedBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    _readedBtn.titleEdgeInsets=UIEdgeInsetsMake(0,3,0,0);
    _readedBtn.size=CGSizeMake(120, [UIImage imageNamed:@"方框"].size.height);
    _readedBtn.bottom=kScreenHeight-20;
    _readedBtn.selected=YES;
    _readedBtn.tag=1004;
    [self.view addSubview:_readedBtn];
    
    _userProtocalBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_userProtocalBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    _userProtocalBtn.titleLabel.font=[UIFont systemFontOfSize:10];
    [_userProtocalBtn setTitle:@"用户协议" forState:UIControlStateNormal];
    [_userProtocalBtn setTitleColor:[UIColor colorWithHexString:@"4a90e2"] forState:UIControlStateNormal];
    _userProtocalBtn.tag=1005;
    [_userProtocalBtn sizeToFit];
    [self.view addSubview:_userProtocalBtn];
    _readedBtn.left=(kScreenWidth-_userProtocalBtn.width-_readedBtn.width)/2;
    _userProtocalBtn.left=_readedBtn.right;
    _userProtocalBtn.bottom=kScreenHeight-13;
    [self.view addSubview:_closeBtn];
}

- (NSTimer *)cutDownTimer {
    if (!_cutDownTimer)
        _cutDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCutDown) userInfo:nil repeats:YES];
    return _cutDownTimer;
}

-(void)clickEvent:(UIButton *)sender
{
    [super clickEvent:sender];
    [self.view endEditing:YES];
    switch (sender.tag) {
        case 1000:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1001:
             [[SliderViewController sharedSliderController].navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
            break;
        case 1002:
        {
//            if (_count>=2) {
//                [MBProgressHUD showSuccess:@"发送验证码次数用尽"];
//                break;
//            }
            if([self __checkMobileWithPhone:_accountTF.text]  )
            {
                _count++;
                NSString *tempString = [NSString stringWithFormat:@"%@",_accountTF.text];
                [self cutDownTimer];
                
                SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
                [_urlParamsReq setUrlString:@"https://api.leancloud.cn/1.1/requestSmsCode"];
                NSDictionary *_paramsDict = @{  @"mobilePhoneNumber":tempString?tempString:@0   };
                [_urlParamsReq setParamsDict:_paramsDict];
                _urlParamsReq.requestMethod = YTKRequestMethodPost;
                
                [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successRequest){
                    if ([[successRequest.responseString objectFromJSONString] valueForKey:@"error"]){
//                        [MBProgressHUD showError:[[successRequest.responseString objectFromJSONString] valueForKey:@"error"]];
                        [MBProgressHUD showError:@"验证码发送成功!"];
                    }else
                        [MBProgressHUD showSuccess:@"验证码发送成功"];
                    
                    NSLog(@"access send sms success, successRequest: %@",[successRequest.responseString objectFromJSONString]);
                    
                } failureBlock:^(SSLXResultRequest *failRequest){
                    
                    NSLog(@"access send sms fail");
                    [MBProgressHUD showError:@"验证码发送失败!"];
//                    NSDictionary *_failDict = [failRequest.responseString objectFromJSONString];
//                    NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
//                    if (_errorMsg)
//                        [MBProgressHUD showError:_errorMsg];
//                    else
//                        [MBProgressHUD showError:kMBProgressErrorTitle];
                }];
            }
            break;
        }
        case 1003:
        {
            if([self __check])
            {
                NSString *tempString = [NSString stringWithFormat:@"%@",_accountTF.text];
                [self __checkMobileWithPhone:_accountTF.text];
                [self cutDownTimer];
                
                SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
                [_urlParamsReq setUrlString:@"https://api.leancloud.cn/1.1/batch"];
                
                //拼接post数据
                NSDictionary *whereDic = @{@"key": _inivitTF.text
                                          };
                
                NSDictionary *bodyDic = @{@"class": @"InvitationCode",
                                           @"where": whereDic
                                           };
                NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:1];
                
                
                NSDictionary *tempDic1 = @{@"method": @"GET",
                                           @"path": @"/1.1/classes/InvitationCode",
                                           @"body":bodyDic
                                          };
                [tempArray addObject:tempDic1];
                
                
                NSDictionary *bodyDic1 = @{  @"mobilePhoneNumber":tempString?tempString:@0,
                                             @"smsCode":_verificationCodeTF.text,
                                             @"invitation_code":_inivitTF.text,
                                             @"password":_passWordTF.text
                                             };
                                                
                NSDictionary *tempDic2 = @{@"method": @"POST",
                                           @"path": @"/1.1/usersByMobilePhone",
                                           @"body":bodyDic1
                                           };
                [tempArray addObject:tempDic2];

                NSDictionary *_paramsDict = @{@"requests":tempArray};
                
                
//                NSDictionary *_paramsDict = @{  @"mobilePhoneNumber":tempString?tempString:@0,
//                                                @"smsCode":_verificationCodeTF.text,@"invitation_code":_inivitTF.text};
                [_urlParamsReq setParamsDict:_paramsDict];
                _urlParamsReq.requestMethod = YTKRequestMethodPost;
                
                [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successRequest){
                    
                    NSArray *finalArray = [NSArray arrayWithArray:[successRequest.responseString objectFromJSONString]];
                    if([finalArray count]>1){
                    
                        NSDictionary *tempDic = [finalArray objectAtIndex:0];
                        NSDictionary *tempDic1 = [finalArray objectAtIndex:1];
                        
                        NSDictionary *successCode = [tempDic objectForKey:@"success"];
                        NSDictionary *successCode1 = [tempDic1 objectForKey:@"success"];

                        if(![self isBlankDictionary:successCode1]&&![self isBlankDictionary:successCode]){
                        
                            //成功
                            NSString *sessionToken1 = [NSString stringWithFormat:@"%@",[successCode1 objectForKey:@"sessionToken"]];
                            NSString *sessionToken = SafeForString(sessionToken1);
                            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                            [userDefaults setObject:sessionToken forKey:kSessionToken];
                            
                            NSString *objectID = [NSString stringWithFormat:@"%@",[successCode1 objectForKey:@"objectId"]];
                            [[ConstObject instance] setObjectIDss:SafeForString(objectID)];
                            
                           
//                            [[NSNotificationCenter defaultCenter] postNotificationName:@"judgeLoginStatus" object:nil];
                            NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
                            [userDefault setValue:_accountTF.text forKey:@"userAccout"];
                            [userDefault setValue:_passWordTF.text forKey:@"userPassWord"];
                            [userDefault setBool:YES forKey:@"isLogin"];
                            
//                            [[ConstObject instance] setObjectIDss:SafeForString(objectID)];
                            [userDefault setObject:objectID forKey:kObjectID];
                            [userDefault synchronize];
                            [[SliderViewController sharedSliderController].navigationController pushViewController:[[BootstrapViewController alloc] init] animated:YES];

                        }else{
                        
                            if([self isBlankDictionary:successCode]){
                            
//                                NSString *_errorMsg = [[tempDic objectForKey:@"error"] objectForKey:@"error"];
//                                [MBProgressHUD showError:_errorMsg];
                                [MBProgressHUD showError:@"邀请码错误!"];
                                return;
                            }else if([self isBlankDictionary:successCode1]){
                            
                                [MBProgressHUD showError:@"验证码错误!"];

//                                NSString *_errorMsg = [[tempDic1 objectForKey:@"error"] objectForKey:@"error"];
//                                [MBProgressHUD showError:_errorMsg];
                                return;
                            }
                        }

                    }
                    
                    
                } failureBlock:^(SSLXResultRequest *failRequest){
                    
                    NSLog(@"access send sms fail");
                    
                    NSDictionary *_failDict = [failRequest.responseString objectFromJSONString];
                    NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
                    if (_errorMsg)
                        [MBProgressHUD showError:_errorMsg];
                    else
                        [MBProgressHUD showError:kMBProgressErrorTitle];
                }];
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

-(BOOL)__checkMobileWithPhone:(NSString *)phoneNumber
{
    if ([phoneNumber isEqualToString:@""]){
        [MBProgressHUD showError:@"号码不能为空"];
        return NO;
    }
    if ([phoneNumber length]!=11 ){
        [MBProgressHUD showError:@"号码长度不为11"];
        return NO;
    }
    if(![self __validateMobile:phoneNumber])
    {
        [MBProgressHUD showError:@"请输入正确的手机号"];
        return NO;
    }
    return YES;
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
    
    if(_passWordTF.text.length<6)
    {
        [MBProgressHUD showError:@"密码长度不能小于6"];
        return NO;
    }
    if(![_passWordTF.text isEqualToString:_passWordAgainTF.text])
    {
        [MBProgressHUD showError:@"两次密码不一致"];
        return NO;
    }
    
    
    if ([_accountTF.text containsString:@"."])
    {
        if(![self __validateEmail:_accountTF.text])
        {
            [MBProgressHUD showError:@"邮箱格式错误"];
            return NO;
        }
    }
    else
        if (![self __checkMobileWithPhone:_accountTF.text])
            return NO;
    
    
    if([_verificationCodeTF.text length]!=6)
    {
        [MBProgressHUD showError:@"验证码应该为6位"];
        return NO;
    }
//    if (![self  __verificationCode:_verificationCodeTF.text])
//    {
//        [MBProgressHUD showError:@"验证码格式不对"];
//        return NO;
//    }
    
    if(!_readedBtn.selected)
    {
        [MBProgressHUD showError:@"用户协议没有选中"];
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
    //    NSString *phoneRegex = @"/^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/";
    //    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [mobile isMobilePhoneNumber];
}

//验证码
- (BOOL) __verificationCode:(NSString *)verificationCode
{
    NSString *codeRegex = @"/d/d/d/d/d/d";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    return [codeTest evaluateWithObject:verificationCode];
}

-(void)showKeyBoard:(NSNotification *)noti
{
    CGRect frame=[[noti userInfo][UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    _duration=[[noti userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
    if (frame.origin.y<_contentView.bottom) {
        [UIView animateWithDuration:_duration animations:^{
            _contentView.bottom=frame.origin.y;
        }];
    }
    _loginBtn.hidden=YES;
    _closeBtn.hidden=YES;
}

-(void)hideKeyBoard:(NSNotification *)noti
{
    _duration=[[noti userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:_duration animations:^{
        _contentView.bottom=_bottom;
    }];
    _loginBtn.hidden=NO;
    _closeBtn.hidden=NO;
}

//倒计时
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

#pragma mark - 空字典判断
- (BOOL) isBlankDictionary:(NSDictionary *)dictionary
{
    if (dictionary == nil || dictionary == NULL) { return YES; }
    if ([dictionary isKindOfClass:[NSNull class]]) { return YES; }
    if ([dictionary allKeys].count == 0)  { return YES; }
    return NO;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end
