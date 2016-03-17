//
//  NSString+Utility.h
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/10.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

-(CGSize)sizeWithFont:(UIFont *)font;

-(BOOL)isMobilePhoneNumber;

-(BOOL)isBlankString;

- (CGFloat)heightAutoCalculateRectWithFont:(UIFont *)font withMaxSize:(CGSize)sizeValue;
- (CGFloat)heightAutoCalculateRectWithFont:(UIFont *)font withMaxWidth:(CGFloat)widthValue;
- (CGSize)sizeAutoCalculateRectWithFont:(UIFont *)font withMaxWidth:(CGFloat)widthValue;

-(NSString *)clearSpaceCharacter;
-(NSString *)clearSpaceAndNewlineCharacter;

-(NSString *)safeString;

-(NSString *)pointMoneyString;

- (NSString *)removeHeaderEndSpaceAndNewline;
- (NSString *)removeSpaceAndNewline;

@end
