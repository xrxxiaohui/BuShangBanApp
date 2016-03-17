//
//  NSNumber+Utility.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/30.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "NSNumber+Utility.h"

@implementation NSNumber (Utility)

-(NSNumber *)safeNumber {

    if (self && [self isKindOfClass:[NSNumber class]]) {
        return self;
    }
    else {
        return @0;
    }
}

@end
