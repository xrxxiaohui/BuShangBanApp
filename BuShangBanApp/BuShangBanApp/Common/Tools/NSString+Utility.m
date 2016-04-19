//
//  NSString+Utility.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/10.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

-(CGSize)sizeWithFont:(UIFont *)font {
    
    if (self && [self isKindOfClass:[NSString class]]) {
        
        NSDictionary *_attributes = @{NSFontAttributeName:font};
        CGSize _size = [self sizeWithAttributes:_attributes];
        
        return _size;
    }
    else {
    
        return CGSizeZero;
    }
}

-(BOOL)isMobilePhoneNumber {

    BOOL _isMatch = [self isMatch:RX((@"1\\d{10}"))];
    
    return _isMatch;
}

//根据传过来的文字内容，文字大小，和最大尺寸动态计算文字所占用的size
- (CGFloat)heightAutoCalculateRectWithFont:(UIFont *)font withMaxWidth:(CGFloat)widthValue
{
    
    if (self && [self isKindOfClass:[NSString class]]) {
        
        CGFloat result = font.pointSize + 4;
        if (self)
        {
            CGSize textSize = { widthValue, CGFLOAT_MAX };       //Width and height of text area
            CGSize size;
            //iOS 7
            CGRect frame = [self boundingRectWithSize:textSize
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName:font }
                                              context:nil];
            size = CGSizeMake(frame.size.width, frame.size.height+1);
            result = MAX(size.height, result); //At least one row
        }
        return result;
    }
    else {
    
        return 0;
    }
    
//    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    paragraphStyle.lineBreakMode=NSLineBreakByWordWrapping;
//    NSDictionary* attributes =@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
//    //如果系统为iOS7.0；
//    CGSize labelSize;
//    if (![self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
//        labelSize = [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
//    }
//    //如果是IOS6.0
//    else{
//       labelSize = [self boundingRectWithSize: maxSize
//                                           options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
//                                        attributes:attributes
//                                           context:nil].size;
//        }
//    labelSize.height=ceil(labelSize.height);
//    labelSize.width=ceil(labelSize.width);
//    return labelSize;
}

- (CGSize)sizeAutoCalculateRectWithFont:(UIFont *)font withMaxWidth:(CGFloat)widthValue
{
    
    if (self && [self isKindOfClass:[NSString class]]) {
        
        CGFloat result = font.pointSize + 4;
        CGSize size;
        
        if (self)
        {
            CGSize textSize = { widthValue, CGFLOAT_MAX };       //Width and height of text area
            //iOS 7
            CGRect frame = [self boundingRectWithSize:textSize
                                              options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                           attributes:@{ NSFontAttributeName:font }
                                              context:nil];
            size = CGSizeMake(frame.size.width, frame.size.height+1);
            result = MAX(size.height, result); //At least one row
        }
        return size;
    }
    else {
    
        return CGSizeZero;
    }
}

- (CGFloat)heightAutoCalculateRectWithFont:(UIFont *)font withMaxSize:(CGSize)sizeValue
{
    
    if (self && [self isKindOfClass:[NSString class]]) {
        
        CGFloat result = font.pointSize + 4;
        if (self)
        {
            CGSize textSize = sizeValue;       //Width and height of text area
            CGSize size;
            //iOS 7
            CGRect frame = [self boundingRectWithSize:textSize
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName:font }
                                              context:nil];
            size = CGSizeMake(frame.size.width, frame.size.height+1);
            result = MAX(size.height, result); //At least one row
        }
        return result;
    }
    else {
    
        return 0;
    }
    
}

-(BOOL)isBlankString {

    if (self == nil || self == NULL)
    {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return YES;
    }
    if([self isEqualToString:@"null"])
        return YES;
    if([self isEqualToString:@"(null)"])
        return YES;
    return NO;
}

-(NSString *)clearSpaceCharacter {

    NSString *tempString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return tempString;
}

-(NSString *)clearSpaceAndNewlineCharacter {
    
    NSString *tempString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return tempString;
}

-(NSString *)safeString {

    // 加层保护，应该为String的为String,防止字符串为 <null>，解析后类型为 Null class的情况出现
    if (self && [self isKindOfClass:[NSString class]]) {
        
        return self;
    }
    else {
        return @"";// nil
    }
}

-(NSString *)pointMoneyString {

    long long _moneyLongLongInt = [self longLongValue];
    
    NSString *_pointString = @"";
    if (_moneyLongLongInt > 100000000) {
        _pointString = [NSString stringWithFormat:@"%.1f亿",_moneyLongLongInt/100000000.0f];
    }
    else if (_moneyLongLongInt > 10000) {
        _pointString = [NSString stringWithFormat:@"%.1f万",_moneyLongLongInt/10000.0f];
    }
    else {
        _pointString = self;
    }
    
    return _pointString;
}

- (NSString *)removeHeaderEndSpaceAndNewline
{
    NSString *temp = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    
    NSString *text = [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
    return text;
}

- (NSString *)removeSpaceAndNewline
{
    NSString *temp = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}

@end
