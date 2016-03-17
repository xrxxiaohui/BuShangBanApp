//
//  SysDeviceManager.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface SysDeviceManager : NSObject

@property (nonatomic, strong) NSDictionary *baseSysDeviceInfo;

+(instancetype)sharedInstance;

+ (NSString *)platformString;

@end
