//
//  NSString+JSON.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "NSString+JSON.h"
#import "JSONManager.h"

@implementation NSString (JSON)

-(id)objectFromJSONString {
    
    id _obj = [JSONManager objWithJsonString:self];
    
    NSLog(@"json to obj: %@",[_obj class]);
    
    return _obj;
}

@end
