//
//  RegistViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "RegistViewController.h"
#import "LoginViewController.h"
#import "InvitedCodeViewController.h"
#import "UserProtocalViewController.h"

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
}
@end

@implementation RegistViewController
{
    CGFloat _bottom;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __initView];
}


-(void)showKeyBoard:(NSNotification *)noti
{
    CGRect frame=[[noti userInfo][UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    if (frame.origin.y>_contentView.bottom) {
        _bottom=_contentView.bottom;
        _contentView.bottom=frame.origin.y;
    }
}

-(void)hideKeyBoard:(NSNotification *)noti
{
    if (_bottom != 0)
        _contentView.bottom=_bottom;
}

-(void)__initView
{
    _loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    _loginBtn.titleLabel.font=[UIFont fontWithName:@"PingFang TC-Light" size:14];
    [_loginBtn setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    _loginBtn.frame=CGRectMake(kScreenWidth-60, 33, 44, 44);
    _loginBtn.tag=1001;
    [self.view addSubview:_loginBtn];
    
    _accountTF=[self textFieldWithPlaceHolder:@"手机号/邮箱" imageNamed:@"phone number"];
    _accountTF.top=_contentView.top;
    [self shapeLayerWithStartPoint:CGPointMake(_accountTF.left, _accountTF.bottom) endPoint:CGPointMake(_accountTF.right, _accountTF.bottom)];
    
    _verificationCodeTF=[self textFieldWithPlaceHolder:@"验证码" imageNamed:@"Verification code"];
    _verificationCodeTF.keyboardType=UIKeyboardTypeNumberPad;
    _verificationCodeTF.top=_accountTF.bottom;
    _verificationCodeTF.width=200;
    
    [self shapeLayerWithStartPoint:CGPointMake(_verificationCodeTF.left, _verificationCodeTF.bottom) endPoint:CGPointMake(_verificationCodeTF.right, _verificationCodeTF.bottom)];
    
    _getCodeBtn=[self buttonWithImageName:@"Get button" tag:1002 frame:CGRectMake(_verificationCodeTF.right+20, 0, 80, 30) title:@"获取验证码"];
    _getCodeBtn.titleLabel.font=[UIFont fontWithName:@"PingFang TC-Light" size:10];
    _getCodeBtn.bottom=_verificationCodeTF.bottom;
    [_contentView addSubview:_getCodeBtn];
    
    _passWordTF=[self textFieldWithPlaceHolder:@"密码" imageNamed:@"password"];
    _passWordTF.top=_getCodeBtn.bottom;
    
    [self shapeLayerWithStartPoint:CGPointMake(_passWordTF.left, _passWordTF.bottom) endPoint:CGPointMake(_passWordTF.right, _passWordTF.bottom)];
    
    _passWordAgainTF=[self textFieldWithPlaceHolder:@"再次输入密码" imageNamed:@"password again"];
    _passWordAgainTF.top=_passWordTF.bottom;
    
    [self shapeLayerWithStartPoint:CGPointMake(_passWordAgainTF.left, _passWordAgainTF.bottom) endPoint:CGPointMake(_passWordAgainTF.right, _passWordAgainTF.bottom)];
    
    _inivitTF=[self textFieldWithPlaceHolder:@"邀请码" imageNamed:@"Invitation code"];
    _inivitTF.top=_passWordAgainTF.bottom;
    
    _inivitBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_inivitBtn setImage:[UIImage imageNamed:@"problem"] forState:UIControlStateNormal];
    [_inivitBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    _inivitBtn.size=CGSizeMake(44, 44);
    _inivitBtn.right=_inivitTF.right;
    _inivitBtn.bottom=_inivitTF.bottom;
    _inivitBtn.tag=1006;
    [self.view addSubview:_inivitBtn];
    
    
    [self shapeLayerWithStartPoint:CGPointMake(_inivitTF.left, _inivitTF.bottom) endPoint:CGPointMake(_inivitTF.right, _inivitTF.bottom)];
    
    _registBtn=[self buttonWithImageName:@"Button" tag:1003 frame:CGRectMake(0,0, 300, 44) title:@"注册"];
    _registBtn.top=_inivitTF.bottom+64;
    _registBtn.centerX=self.view.centerX;
    [_contentView addSubview:_registBtn];
    
    _readedBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_readedBtn setImage:[UIImage imageNamed:@"方框"] forState:UIControlStateNormal];
    [_readedBtn setImage:[UIImage imageNamed:@"勾选"] forState:UIControlStateSelected];
    [_readedBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_readedBtn setTitle:@"我已阅读并同意不上班" forState:UIControlStateNormal];
    _readedBtn.titleLabel.font=[UIFont fontWithName:@"PingFang" size:10];
    _readedBtn.titleEdgeInsets=UIEdgeInsetsMake(0,10, 0, 0);
    _readedBtn.bottom=self.view.bottom-20;
    [_readedBtn sizeToFit];
    _readedBtn.tag=1004;
    [self.view addSubview:_readedBtn];
    
    _userProtocalBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    NSDictionary *dic=@{NSFontAttributeName:[UIFont fontWithName:fontName size:10],
                        NSForegroundColorAttributeName:[UIColor colorWithHexString:@"4a90e2"]};
    NSAttributedString *attr=[[NSAttributedString alloc] initWithString:@"用户协议" attributes:dic];
    [_userProtocalBtn setAttributedTitle:attr forState:UIControlStateNormal];
    _userProtocalBtn.tag=1005;
    [_userProtocalBtn sizeToFit];
    [self.view addSubview:_userProtocalBtn];
    _readedBtn.left=(kScreenWidth-_userProtocalBtn.width-_readedBtn.width)/2;
    _userProtocalBtn.left=_readedBtn.right;
}

-(void)clickEvent:(UIButton *)sender
{
    [super clickEvent:sender];
    __block BOOL success=NO;
    switch (sender.tag) {
        case 1000:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 1001:
            [self presentViewController:[[LoginViewController alloc]init] animated:YES completion:nil];
            break;
        case 1002:
            //发送验证码
            break;
        case 1003:
            if([self __check])
            {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                [manager GET:@"https://leancloud.cn:443/1.1/classes/_User/570387b3ebcb7d005b196d24" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                    if(![_verificationCodeTF.text isEqualToString:@""])
                        [MBProgressHUD showError:@"验证码不对"];
                    else if(![_inivitTF.text isEqualToString:@""])
                        [MBProgressHUD showError:@"验证码不对"];
                    else if(@"")
                        [MBProgressHUD showError:@"这个账号已经注册过"];
                    else
                        success=YES;
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [MBProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
                }];
                if (success)
                {
                    [self dismissViewControllerAnimated:YES completion:nil];
                    NSDictionary *dic=@{};
                    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"UserInfo"];
                }
            }
            break;
        case 1004:
            _readedBtn.selected=!_readedBtn.selected;
            break;
        case 1005:
        {
            UIStoryboard *UserProtocal=[UIStoryboard storyboardWithName:@"UserProtocal" bundle:nil];
            [self presentViewController:[UserProtocal                instantiateViewControllerWithIdentifier:@"UserProtocal"] animated:YES completion:nil];
            break;
        }
        case 1006:
            [self presentViewController:[[InvitedCodeViewController alloc]init] animated:YES completion:nil];
            break;
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
    if([_accountTF.text isEqualToString:@""])
    {
        [MBProgressHUD showError:@"账号格式不对"];
        return NO;
    }
    return YES;
}

@end
