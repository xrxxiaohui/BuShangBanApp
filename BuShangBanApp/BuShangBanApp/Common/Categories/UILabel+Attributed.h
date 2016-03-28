//
//  UILabel+Attributed.h
//  ShunShunApp
//
//  Created by Peter Lee on 16/1/20.
//  Copyright © 2016年 顺顺留学. All rights reserved.
//



@interface UILabel (Attributed)

+(CGFloat)getAttributeHeightWithFont:(UIFont *)font content:(NSString *)content lineSpacing:(CGFloat)lineSpace maxWidth:(CGFloat)maxW;
-(CGFloat)getAttributedHeightWithLineSpacing:(CGFloat)lineSpace;

-(void)attributedWithLineSpace:(CGFloat)lineSpace;

@end
