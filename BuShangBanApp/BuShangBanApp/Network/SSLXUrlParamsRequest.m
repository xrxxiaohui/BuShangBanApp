//
//  SSLXUrlParamsRequest.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SSLXUrlParamsRequest.h"
#import "SysDeviceManager.h"
#import "KVStoreManager.h"
#import "UserActionRequest.pb.h"
#import "HelloWorldReq.pb.h"


#define kBaseStatUrl @"http://123.57.64.181:8086/"

@implementation SSLXUrlParamsRequest

-(NSString *)requestUrl {
    
//    [self postStatReqWithUrl:self.urlString];
    
    return self.urlString;
}

+(void)postStatReqWithUrl:(NSString *)url {
    
//    HelloWorld_Builder *_hwBuilder = [HelloWorld builder];
//    [_hwBuilder setId:111111];
//    [_hwBuilder setStr:@"Test"];
//    [_hwBuilder setOpt:1024];
//    
//    HelloWorld *_helloWorld = [_hwBuilder build];
//    
//    NSData *_hwData = [_helloWorld data];
//    NSString *_base64hw = SafeForString([_hwData base64EncodedString]);
//    
//    NSLog(@"base64String: %@",_base64hw);
//    
//    return;
    
    NSString *_uidString = SafeForString([[KVStoreManager sharedInstance] getCurrentUid]);
    NSString *_channelString = APP_CHANNEL;
    NSString *_deviceType = SafeForString([SysDeviceManager platformString]);
    NSString *_deviceId = SafeForString([CommonHelper deviceIdentifier]);
    NSString *_sysVersion = SafeForString([UIDevice currentDevice].systemVersion);
    
    NSString *_appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    UserAction_Builder *_builder = [UserAction builder];
    [_builder setUserAction:SafeForString(url)];
    [_builder setUid:[_uidString intValue]];
    [_builder setChannel:_channelString];
    [_builder setDeviceId:_deviceId];
    [_builder setVersion:_appVersion];
    [_builder setDeviceType:_deviceType];
    [_builder setSysVersion:_sysVersion];
    [_builder setLanguage:@"zh-hans"];
    [_builder setTimeZone:@"Asia/Shanghai"];
    [_builder setResolution:@""];
    
    UserAction *_userAction = [_builder build];
    
//    UserAction *_userAction = [[[[[[[[[[[UserAction builder] setUserAction:SafeForString(url)] setUid:[_uidString intValue]] setChannel:_channelString] setDeviceType:_deviceType] setDeviceId:_deviceId] setSysVersion:_sysVersion] setLanguage:@"zh-hans"] setTimeZone:@"Asia/Shanghai"] setResolution:@""] build];
    
    NSData *_userData = [_userAction data];
    NSString *_base64String = SafeForString([_userData base64EncodedString]);
    
    NSLog(@"base64String: %@",_base64String);
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseStatUrl,_base64String]];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    request.HTTPMethod = @"POST";
    
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [request addValue: myEmail forHTTPHeaderField:@"user-email"];
//        [request addValue: mySessionToken forHTTPHeaderField:@"user-token"];
    [request addValue: @"fdOqfdJ3Ypgv6iaQJXLw7CgR-gzGzoHsz" forHTTPHeaderField:@"X-LC-Id"];
    [request addValue: @"MDOagSCTlLw9A6fkrcaphlB8" forHTTPHeaderField:@"X-LC-Key"];
    
    NSError *error = nil;
    
    
    if (!error) {
        
        NSURLSessionDataTask *downloadTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!error) {
                NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                if (httpResp.statusCode == 200) {
                    
                    
                    NSDictionary *json = [NSJSONSerialization
                                          JSONObjectWithData:data
                                          options:kNilOptions
                                          error:&error];
                    NSLog(@"json: %@",json);
                }
            }
            
        }];
        
        
        [downloadTask resume];
        
    }
        
//        NSMutableURLRequest *request =
//        [NSMutableURLRequest requestWithURL:[NSURL
//                                             URLWithString:[NSString stringWithFormat:@"%@%@",kBaseStatUrl,_base64String]]
//                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
//                            timeoutInterval:10
//         ];
//        
//        [request setHTTPMethod: @"GET"];
//        
//        NSError *requestError = nil;
//        NSURLResponse *urlResponse = nil;
//        
//        
//        NSData *response1 =
//        [NSURLConnection sendSynchronousRequest:request
//                              returningResponse:&urlResponse error:&requestError];
//        NSLog(@"response1: %@",response1);
}

- (id)requestArgument {
    
    NSDictionary *_baseParams = [super requestArgument];
    
    NSString *_skeyString = kServerKeyString;
    // 参数排序
    NSArray *keyArray = [[self.paramsDict allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *_tempString = [NSMutableString new];
    for (NSString *_tempKey in keyArray) {
        [_tempString appendString:[_tempKey description]];
        [_tempString appendString:@"="];
        [_tempString appendString:[[self.paramsDict objectForKey:_tempKey] description]];
        [_tempString appendString:@"&"];
    }
    [_tempString appendString:@"key"];
    [_tempString appendString:@"="];
    [_tempString appendString:_skeyString];
    
    NSString *_tempSignKey = [[_tempString copy] md5String];
    
    NSMutableDictionary *_paramDic = [[NSMutableDictionary alloc] initWithDictionary:self.paramsDict];
    [_paramDic addEntriesFromDictionary:@{@"sign":_tempSignKey}];
//  @{@"c":@"1111",@"b":@"222",@"a":@"3333",@"sign":_tempSignKey};
    
    if (_baseParams) {

        NSMutableDictionary *_tempParams = [[NSMutableDictionary alloc] initWithDictionary:_baseParams];
        [_tempParams addEntriesFromDictionary:[_paramDic copy]];
        
        return [_tempParams copy];
    }
    else {
        
        return [_paramDic copy];
    }
}

@end
