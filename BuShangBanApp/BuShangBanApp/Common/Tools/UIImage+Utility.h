//
//  UIImage+Utility.h
//  QunariPhone
//
//  Created by 姜琢 on 13-6-8.
//  Copyright (c) 2013年 Qunar.com. All rights reserved.
//



@interface UIImage (Utility)

+ (UIImage *)imageFromColor:(UIColor *)color;
+(UIImage *)placeholderImageWithIcon:(UIImage *)iconImage withSize:(CGSize)pSize fromColor:(UIColor *)color;

-(UIImage *) getSubImage:(CGRect)rect;
-(UIImage *)scaleToSize:(CGSize)size;
+ (UIImage *)TransformtoSize:(CGSize)size image:(UIImage *)image;

- (UIImage *)imageWithMaxLength:(CGFloat)sideLenght;

-(UIImage *)imageWithSquare;
-(UIImage*)imageCrop:(UIImage*)original;

-(UIColor*)mostColorWithCGColor:(CGImageRef)imageRef;

@end
