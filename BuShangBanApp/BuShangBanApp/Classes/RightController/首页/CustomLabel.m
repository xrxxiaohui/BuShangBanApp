//
//  CustomLabel.m
//  DrawTest
//
//  Created by Polaris Tang on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel
@synthesize glowColor,glowAmount,glowoffset;
-(void)drawTextInRect:(CGRect)rect{
    //此处就是一个绘图的过程
    /**
     CGContextSetShadowWithColor过程
     接受四个参数
     1.需要应用阴影的图形上下文
     2.偏移量,由CGSize类型的值指定。偏移量相对于将要应用阴影的形状的右边和底部。X的偏移量越大，阴影越向形状的右边延伸。Y偏移量越大，阴影越向形状的底部延伸
     3.要应用到的阴影的模糊值，它被指定为一个浮点值。指定为0.0f将获得平整的阴影。这个值越高获得阴影越模糊，此例中主要改变的就是此值
     4.此参数为ColorRef类型，用于设置阴影的颜色
     **/
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, glowoffset, glowAmount, [glowColor CGColor]);
    [super drawTextInRect:rect];
    CGContextRestoreGState(context);
}

@end
