//
//  AccessSendSmsApi.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/4.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "AccessSendSmsApi.h"

@implementation AccessSendSmsApi {

    NSString *_userPhone;
}

-(id)initWithUserPhone:(NSString *)userPhone {

    self = [super init];
    
    if (self) {
        _userPhone = userPhone;
    }
    
    return self;
}

-(NSString *)requestUrl {
    
    return @"https://api.leancloud.cn/1.1/requestSmsCode";
}

-(id)requestArgument {
    
    
    NSDictionary *_baseParams = [super requestArgument];
    NSDictionary *_paramsDict = @{
                                  @"mobilePhoneNumber":_userPhone?_userPhone:@0
                                  };
    
    if (_baseParams) {
        
        NSMutableDictionary *_tempParams = [[NSMutableDictionary alloc] initWithDictionary:_baseParams];
        [_tempParams addEntriesFromDictionary:_paramsDict];
        
        return [_tempParams copy];
    }
    else {
        
        return _paramsDict;
    }
}

@end
