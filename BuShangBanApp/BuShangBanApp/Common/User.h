//
//  User.h
//  BuShangBanApp
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 Zuo. All rights reserved.
//



@interface UserList : NSObject


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

typedef NS_ENUM(NSUInteger, BuShangBanPlatformType)
{
    /**
     *  未知
     */
    BuShangBanPlatformTypeUnknown             = 0,
    /**
     *  新浪微博
     */
    BuShangBanPlatformTypeSinaWeibo           = 1,
    /**
     *  打印
     */
    BuShangBanPlatformTypePrint               = 20,
    /**
     *  拷贝
     */
    BuShangBanPlatformTypeCopy                = 21,
    /**
     *  微信好友
     */
    BuShangBanPlatformSubTypeWechatSession    = 22,
    /**
     *  微信朋友圈
     */
    BuShangBanPlatformSubTypeWechatTimeline   = 23,
   
    /**
     *  微信收藏
     */
    BuShangBanPlatformSubTypeWechatFav        = 37,
    /**
     *  微信平台,
     */
    BuShangBanPlatformTypeWechat              = 997,
    /**
     *  任意平台
     */
    BuShangBanPlatformTypeAny                 = 999
};

typedef NS_ENUM(NSUInteger, BuShangBanGender){
    /**
     *  男
     */
    BuShangBanGenderMale      = 0,
    /**
     *  女
     */
    BuShangBanGenderFemale    = 1,
    /**
     *  未知
     */
    BuShangBanGenderUnknown   = 2,
};

@property (nonatomic, copy)NSString *loginAcount;
@property (nonatomic, assign)BuShangBanPlatformType platformType;
@property (nonatomic, copy)NSString *login;
@property (nonatomic, copy)NSString *confirmationCode;
@property(nonatomic, copy) NSString *isLogined;
@property(nonatomic, copy) NSString *isLogin;
@property(nonatomic, copy) NSString *isRigist;
@property(nonatomic, copy) NSString *isRigisted;


@property(nonatomic, copy) NSString* mid;
@property(nonatomic, assign) NSUInteger age;
@property(nonatomic, copy) NSString *address;
@property(nonatomic, copy) NSString *constellation;
@property(nonatomic, assign) BuShangBanGender gender;
@property(nonatomic, copy) NSString *groups;
@property(nonatomic, copy) NSString *leagues;
@property(nonatomic, copy) NSString *nickName;
@property(nonatomic, copy) NSString *ofusername;
@property(nonatomic, copy) NSString *pinyin;
@property(nonatomic, copy) NSString *sign;
@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *xingming;
@property(nonatomic, copy) NSString *distance;
@property(nonatomic, copy) NSString *extension;

@property(nonatomic, copy) NSDate *birthDay;

@property(nonatomic, assign) NSUInteger noteCount;
@property(nonatomic, assign) NSUInteger favCount;
@property(nonatomic, assign) CGFloat latitude;
@property(nonatomic, assign) CGFloat longitude;
@property(nonatomic, strong) UserExtension *UserExtend;
@property(nonatomic, copy) NSURL *avatarImageURL;
@property(nonatomic, strong) UIImageView *avatarImageView;

@property(nonatomic,copy)NSString *focusMeNumber;
@property(nonatomic,copy)NSString *myFocusNumber;
@property(nonatomic,copy)NSString *mobilePhoneNumber;
@property(nonatomic,copy)NSString *city_name;

@property(nonatomic,copy)NSString *email;
@property(nonatomic, copy) NSString *mobile;

@property(nonatomic,strong)NSArray *interest;
@property(nonatomic,copy)NSString *sex;
@property(nonatomic,copy)NSString *profession;
@property(nonatomic,copy)NSString *label;

@property(nonatomic, strong) NSDictionary *avatar;
@property(nonatomic, strong) UIImage *avatarImage;

@property(nonatomic,copy)NSString *artcailCount;
@end
