//
//  NSDictionary+Utility.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/30.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "NSDictionary+Utility.h"

@implementation NSDictionary (Utility)

-(NSDictionary *)safeDictionary {

    if (self && [self isKindOfClass:[NSDictionary class]]) {
        
        return self;
    }
    else {
    
        return @{};
    }
}

@end
