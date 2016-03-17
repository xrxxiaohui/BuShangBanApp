//
//  SSLXNetworkManager.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSLXBaseRequest.h"
#import "SSLXResultRequest.h"

#define kServerKeyString @"9191db7594bff39bc8e1e883a9ae2ca1"

@interface SSLXNetworkManager : NSObject

+(instancetype)sharedInstance;

-(void)startApiWithRequest:(SSLXBaseRequest *)baseRequest successBlock:(void (^)(SSLXResultRequest *request))successResult failureBlock:(void (^)(SSLXResultRequest *request))failureResult;

@end
