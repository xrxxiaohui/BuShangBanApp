//
//  User.h
//  BuShangBanApp
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserList : NSObject

@property(nonatomic, copy) NSString *avatar;
@property(nonatomic, assign) NSUInteger mid;
@property(nonatomic, copy) NSString *nickname;

@end

@interface UserExtension : NSObject

@property(nonatomic, copy) NSString *industry;
@property(nonatomic, copy) NSString *interest;
@property(nonatomic, copy) NSString *company;
@property(nonatomic, copy) NSString *occupation;
@property(nonatomic, copy) NSString *project;
@property(nonatomic, copy) NSString *myLabel;
@property(nonatomic, copy) NSString *experience;
@property(nonatomic, copy) NSString *profile;
@property(nonatomic, copy) NSString *IDsign;

@end

@interface User : NSObject

@property(nonatomic, copy) NSString *isLogined;
@property(nonatomic, copy) NSString *isLogin;
@property(nonatomic, copy) NSString *isRigist;
@property(nonatomic, copy) NSString *isRigisted;
@property(nonatomic, assign) NSUInteger mid;
@property(nonatomic, assign) NSUInteger age;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *avatar;
@property(nonatomic, copy) NSString *constellation;
@property(nonatomic, copy) NSString *gender;
@property(nonatomic, copy) NSString *groups;
@property(nonatomic, copy) NSString *leagues;
@property(nonatomic, copy) NSString *nickname;
@property(nonatomic, copy) NSString *ofusername;
@property(nonatomic, copy) NSString *pinyin;
@property(nonatomic, copy) NSString *sign;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *xingming;
@property(nonatomic, copy) NSString *distance;
@property(nonatomic, copy) NSString *extension;
@property(nonatomic, copy) NSString *mobile;
@property(nonatomic, copy) NSString *birthDay;
@property(nonatomic, assign) NSUInteger noteCount;
@property(nonatomic, assign) NSUInteger favCount;
@property(nonatomic, assign) CGFloat latitude;
@property(nonatomic, assign) CGFloat longitude;
@property(nonatomic, strong) UserExtension *UserExtend;
@property(nonatomic, copy) NSURL *avatarImageURL;

@end
