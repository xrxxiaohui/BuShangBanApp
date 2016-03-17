//
//  APIRequestManager.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIRequestManager : NSObject

+(instancetype)sharedInstance;

-(void)postDeviceTokenReq;

@end
