//
//  AreaObject.m
//  Wujiang
//
//  Created by zhengzeqin on 15/5/28.
//  Copyright (c) 2015年 com.injoinow. All rights reserved.
//  make by 郑泽钦 分享

#import "AreaObject.h"

@implementation AreaObject

- (NSString *)description{
//    return [NSString stringWithFormat:@"%@ %@ %@ %@",self.region,self.province,self.city,self.area];
    return [NSString stringWithFormat:@"%@  %@ %@",self.provinceStr ,self.cityStr,self.districtStr];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com