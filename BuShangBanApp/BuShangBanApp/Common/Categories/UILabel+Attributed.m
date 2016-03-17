//
//  UILabel+Attributed.m
//  ShunShunApp
//
//  Created by Peter Lee on 16/1/20.
//  Copyright © 2016年 顺顺留学. All rights reserved.
//

#import "UILabel+Attributed.h"

@implementation UILabel (Attributed)

-(void)attributedWithLineSpace:(CGFloat)lineSpace {

    self.numberOfLines = 0;
    self.lineBreakMode = NSLineBreakByTruncatingTail;
    self.textAlignment = NSTextAlignmentLeft;
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.lineSpacing = lineSpace;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    NSDictionary *attributes4 = @{NSParagraphStyleAttributeName:[paraStyle copy]};
    NSAttributedString *attributedText4 = [[NSAttributedString alloc] initWithString:self.text attributes:attributes4];
    
    self.attributedText = attributedText4;
}

-(CGFloat)getAttributedHeightWithLineSpacing:(CGFloat)lineSpace {

    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = self.textAlignment;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.lineSpacing = lineSpace;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    NSDictionary *dict = @{NSFontAttributeName:self.font,NSParagraphStyleAttributeName:paraStyle.copy};
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(self.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size.height;
}

+(CGFloat)getAttributeHeightWithFont:(UIFont *)font content:(NSString *)content lineSpacing:(CGFloat)lineSpace maxWidth:(CGFloat)maxW {

    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.lineSpacing = lineSpace;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    NSDictionary *dict = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle.copy};
    CGSize size = [content boundingRectWithSize:CGSizeMake(maxW, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    return size.height;
}

@end
