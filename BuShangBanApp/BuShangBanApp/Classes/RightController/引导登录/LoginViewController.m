//
//  LoginViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"

@interface LoginViewController ()
{
    UIButton *_registBtn;
    UITextField *_accountTF;
    UITextField *_passWordTF;
    UIButton *_loginBtn;
}
@end

@implementation LoginViewController
{
    CGFloat _bottom;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _bottom=0;
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

    _registBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    _registBtn.titleLabel.font=[UIFont fontWithName:@"PingFang TC-Light" size:14];
    [_registBtn setTitleColor:[UIColor colorWithHexString:@"383838"] forState:UIControlStateNormal];
    _registBtn.frame=CGRectMake(kScreenWidth-60, 33, 44, 44);
    _registBtn.tag=1001;
    [self.view addSubview:_registBtn];
    
    _accountTF=[self textFieldWithPlaceHolder:@"手机号/邮箱" imageNamed:@"phone number"];
    _accountTF.top=_contentView.top;
    
    [self shapeLayerWithStartPoint:CGPointMake(_accountTF.left, _accountTF.bottom) endPoint:CGPointMake(_accountTF.right, _accountTF.bottom)];
    
    _passWordTF=[self textFieldWithPlaceHolder:@"密码" imageNamed:@"password"];
    _passWordTF.top=_accountTF.bottom;
    
    [self shapeLayerWithStartPoint:CGPointMake(_passWordTF.left, _passWordTF.bottom) endPoint:CGPointMake(_passWordTF.right, _passWordTF.bottom)];
    
    _loginBtn=[self buttonWithImageName:@"Button" tag:1002 frame:CGRectMake(0, _passWordTF.bottom+74, 300, 44) title:@"登录"];
    _loginBtn.centerX=self.view.centerX;
    
    [_contentView addSubview:_loginBtn];
    
    _contentView.top=_accountTF.top;
    _contentView.height=_loginBtn.bottom-_accountTF.top ;
}


-(BOOL)__check
{
    if ([_accountTF.text isEqualToString:@""]){
        [MBProgressHUD showError:@"账号不能为空"];
        return NO;
    }
    if ([_passWordTF.text isEqualToString:@""]){
        [MBProgressHUD showError:@"账号不能为空"];
        return NO;
    }
    return YES;
}

-(void)clickEvent:(UIButton *)sender
{
    [super clickEvent:sender];
    switch (sender.tag) {
        case 1000:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        case 1001:
            [self presentViewController:[[RegistViewController alloc]init] animated:YES completion:nil];
            break;
        case 1002:
        {
            if ([self __check])
            {
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                [manager GET:@"https://leancloud.cn:443/1.1/classes/_User/570387b3ebcb7d005b196d24" parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    
                    if([_accountTF.text isEqualToString:@" " ] &&  [_passWordTF.text  isEqualToString: @" "] )
                    {
                        
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    else
                        [MBProgressHUD showError:@"账号或密码不对"];
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    [MBProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
                }]; 
            }
            break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
