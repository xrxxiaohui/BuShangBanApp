//
//  JSONManager.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONManager : NSObject

+(instancetype)sharedInstance;

// NSDictionary or NSArray to JSON
+(NSString *)jsonStringWithObj:(id)jsonObj;
// JSON to NSDictionary or NSArray
+(id)objWithJsonString:(NSString *)jsonString;

@end
