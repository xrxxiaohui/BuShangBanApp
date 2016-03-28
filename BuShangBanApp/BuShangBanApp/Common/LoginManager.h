//
//  LoginManager.h
//  BuShangBanApp
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Zuo. All rights reserved.
//

@interface LoginManager : NSObject

- (void)ssoLogInWechat;

- (void)ssoLogInWeibo;

- (void)defaultLogin;

- (void)login;
@end
