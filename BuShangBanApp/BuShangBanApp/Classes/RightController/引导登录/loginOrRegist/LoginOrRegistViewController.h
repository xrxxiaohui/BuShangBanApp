//
//  LoginOrRegistViewController.h
//  Youqun
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginOrRegistViewController : UIViewController
@property(nonatomic,assign)BOOL isTologin;

-(void)clickAction:(UIButton *)btn;
-(void)rightLoginOrRegist;
- (void)sendCode:(UIButton *)sender ;

- (void)ssoLogInWechat;

- (void)ssoLogInWeibo;

- (void)defaultLogin;

- (void)login;

-(void)loginOrRegist;

-(void)loginWithUsrDefault;
@end
