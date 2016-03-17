//
//  UserAccountManager.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAccountManager : NSObject

@property (nonatomic, assign) BOOL isStayMessage;
@property (nonatomic, assign) BOOL isStayZiXunPage;

+(instancetype)sharedInstance;


// 获取当前用户信息
-(NSDictionary *)getCurrentUserInfo;

// 获取当前用户的token
-(NSString *)getCurrentToken;

//判断当前用户是不是顾问
-(BOOL)isGuWenSelf;
//根据userId判断是不是顾问
-(BOOL)isAdvisorWithUserId:(NSString *)uid;
//根据userType判断是不是顾问
-(BOOL)isGuWen:(NSString *)userType;

// 判断登陆
-(BOOL)checkLogin;

@end
