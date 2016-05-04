//
//  JSONManager.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "JSONManager.h"

static id _jsonInstance;

@implementation JSONManager

// 单例
+(instancetype)sharedInstance {
    
    static dispatch_once_t onceDispatch;
    
    dispatch_once(&onceDispatch, ^{
        _jsonInstance = [[JSONManager alloc] init];
    });
    
    return _jsonInstance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //onceToken是GCD用来记录是否执行过 ，如果已经执行过就不再执行(保证执行一次）
        _jsonInstance = [super allocWithZone:zone];
    });
    return _jsonInstance;
}

-(id)copyWithZone:(NSZone *)zone {
    
    return _jsonInstance;
}

#pragma mark - Method

// NSDictionary or NSArray to JSON
+(NSString *)jsonStringWithObj:(id)jsonObj {

    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObj
                        
                                                       options:NSJSONWritingPrettyPrinted
 //
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        
        NSLog(@"obj To json sucess");
    }else{
        
        NSLog(@"obj To json fail");
        
        jsonData = nil;
        
    }
    
    NSString *_jsonString = [[NSString alloc] initWithData:jsonData
                            
                                                 encoding:NSUTF8StringEncoding];
    
    return _jsonString;
    
//    if ([jsonObj isKindOfClass:[NSString class]]) {
//        return (NSString *)self;
//    } else if ([self isKindOfClass:[NSData class]]) {
//        return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
//    }
//    
//    return [[NSString alloc] initWithData:[jsonObj JSONData] encoding:NSUTF8StringEncoding];
}
// JSON to NSDictionary or NSArray
+(id)objWithJsonString:(NSString *)jsonString {

    NSData *jsonData= [jsonString dataUsingEncoding:NSASCIIStringEncoding];
    
    NSError *error = nil;
    
    if (!jsonData) {
        return nil;
    }
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                     
                                                    options:NSJSONReadingAllowFragments
                     
                                                      error:&error];
    
    if (jsonObject != nil && error == nil) {
        
        NSLog(@"json to obj success");
        
        return jsonObject;
        
    } else {
        
        NSLog(@"json to obj fail");
        // 解析错误
        return nil;
        
    }
}

@end
