//
//  LoginManager.m
//  BuShangBanApp
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "LoginManager.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "MainTabViewController.h"

#define mainTC [[MainTabViewController alloc]init]
@interface LoginManager ()

@end


@implementation LoginManager



#pragma mark - 第三方登录
-(void)ssoLogInWechat
{
    [mainTC removeLoginOrRigistView];
    if([WXApi isWXAppInstalled])
    {
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
            if (state  == SSDKResponseStateSuccess)
            {
                [MBProgressHUD showSuccess:@"登录成功"];
//                _user.username;
            }else if (state == SSDKResponseStateFail)
            {
                [MBProgressHUD showError:@"登录失败"];
            }
        }];
    }else
    {
        [MBProgressHUD showError:@"没有安装维修客户端"];
    }
}

-(void)ssoLogInWeibo
{
    [mainTC removeLoginOrRigistView];
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state  == SSDKResponseStateSuccess)
        {
            [MBProgressHUD showSuccess:@"登录成功"];
//            _user.username;
        }
        else if (state == SSDKResponseStateFail)
        {
            [MBProgressHUD showError:@"登录失败"];
        }
    }];
}

-(void)defaultLogin
{
    [mainTC removeLoginOrRigistView];
}

-(void)login
{
    [mainTC removeLoginOrRigistView];
}
@end