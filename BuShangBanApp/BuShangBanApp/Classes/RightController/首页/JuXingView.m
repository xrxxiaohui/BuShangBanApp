//
//  JuXingView.m
//  BuShangBanApp
//
//  Created by Zuo on 16/4/22.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "JuXingView.h"

@implementation JuXingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)drawRect:(CGRect )rect

{
    //设置背景颜色
//    [[UIColor clearColor]set];
    
//    UIRectFill([self bounds]);
    
    //拿到当前视图准备好的画板
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    
    CGContextMoveToPoint(context, 0, 340*kDefaultBiLi);
    
    CGContextAddLineToPoint(context, 340*kDefaultBiLi,250*kDefaultBiLi);
    CGContextAddLineToPoint(context, 340*kDefaultBiLi, 501*kDefaultBiLi);
    CGContextAddLineToPoint(context, 0, 501*kDefaultBiLi);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor whiteColor] setFill]; //设置填充色
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
    
}


@end
