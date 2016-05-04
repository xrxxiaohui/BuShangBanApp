//
//  UIImage+Utility.m
//  QunariPhone
//
//  Created by 姜琢 on 13-6-8.
//  Copyright (c) 2013年 Qunar.com. All rights reserved.
//

#import "UIImage+Utility.h"

@implementation UIImage (Utility)

+ (UIImage *)imageFromColor:(UIColor *)color
{
	CGRect rect = CGRectMake(0, 0, 1, 1);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context,[color CGColor]);
	CGContextFillRect(context, rect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

+(UIImage *)placeholderImageWithIcon:(UIImage *)iconImage withSize:(CGSize)pSize fromColor:(UIColor *)color {
    
    
    CGSize _iconSize = iconImage.size;
    
    CGRect rect = CGRectMake(0, 0, pSize.width, pSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    
    [iconImage drawInRect:CGRectMake((pSize.width - _iconSize.width)/2, (pSize.height - _iconSize.height)/2, _iconSize.width, _iconSize.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// 截取部分图像
- (UIImage *)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));

    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    CFRelease(subImageRef);
    UIGraphicsEndImageContext();
    
    return smallImage;
}

-(UIColor*)mostColorWithCGColor:(CGImageRef)imageRef
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    CGSize thumbSize=CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context =CGBitmapContextCreate(NULL, thumbSize.width,thumbSize.height,8,thumbSize.width*4,colorSpace,bitmapInfo);
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect,imageRef);
    CGColorSpaceRelease(colorSpace);
    
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) return nil;
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            
            int offset = 4*(x*y);
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:clr];
        }
    }
    CGContextRelease(context);
    
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        if ( tmpCount < MaxCount ) continue;
        MaxCount=tmpCount;
        MaxColor=curColor;
    }
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}


// 等比例缩放
- (UIImage *)scaleToSize:(CGSize)size
{
    CGFloat width  = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    float scale = [[UIScreen mainScreen] scale];
    
    float verticalRadio   = size.height*scale/height;
    float horizontalRadio = size.width*scale/width;

    float radio = 1;
    
    if (verticalRadio > 1 && horizontalRadio > 1)
    {
        radio = 1;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }
    
    width  = width * radio;
    height = height * radio;
    
    int xPos = (size.width - width/scale)/2;
    int yPos = (size.height - height/scale)/2;
    
    UIGraphicsBeginImageContextWithOptions(size, NO,scale);
    [self drawInRect:CGRectMake(xPos, yPos, width/scale, height/scale)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

+ (UIImage *)TransformtoSize:(CGSize)size image:(UIImage *)image
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *transformedImg=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return transformedImg;
}

- (UIImage *)imageWithMaxLength:(CGFloat)sideLenght
{
	CGSize size = [self fitSize:sideLenght];
    
    UIGraphicsBeginImageContext(size);
    
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationDefault);
	CGRect rect = CGRectMake(0, 0, size.width, size.height);
	[self drawInRect:rect];
	
	UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
	UIGraphicsEndImageContext();
    
	return newimg;
}

-(UIImage *)imageWithSquare {

    UIImage *ret = nil;
    
    // This calculates the crop area.
    
    float originalWidth  = self.size.width;
    float originalHeight = self.size.height;
    
    float edge = fminf(originalWidth, originalHeight);
    
    float posX = (originalWidth   - edge) / 2.0f;
    float posY = (originalHeight  - edge) / 2.0f;
    
    
    CGRect cropSquare = CGRectMake(posX, posY,
                                   edge, edge);
    // If orientation indicates a change to portrait.
    if(self.imageOrientation == UIImageOrientationLeft ||
       self.imageOrientation == UIImageOrientationRight)
    {
        cropSquare = CGRectMake(posY, posX,
                                edge, edge);
        
    }
    else
    {
        cropSquare = CGRectMake(posX, posY,
                                edge, edge);
    }
    
    
    // This performs the image cropping.
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropSquare);
    
    ret = [UIImage imageWithCGImage:imageRef
                              scale:self.scale
                        orientation:self.imageOrientation];
    
    CGImageRelease(imageRef);
    
    return ret;
}

- (CGSize)fitSize:(CGFloat)sideLenght
{
	CGFloat scale;
	CGSize newsize;
	
	if(self.size.width <= sideLenght && self.size.height <= sideLenght)
	{
		newsize = self.size;
	}
	else
	{
		if(self.size.width >= self.size.height)
		{
			scale = sideLenght/self.size.width;
			newsize.width = sideLenght;
			newsize.height = ceilf(self.size.height*scale);
		}
		else
		{
			scale = sideLenght/self.size.height;
			newsize.height = sideLenght;
			newsize.width = ceilf(self.size.width*scale);
		}
	}
    
	return newsize;
}

-(UIImage*)imageCrop:(UIImage*)original
{
    UIImage *ret = nil;
    
    // This calculates the crop area.
    
    float originalWidth  = original.size.width;
    float originalHeight = original.size.height;
    
    float edge = fminf(originalWidth, originalHeight);
    
    float posX = (originalWidth   - edge) / 2.0f;
    float posY = (originalHeight  - edge) / 2.0f;
    
    
    CGRect cropSquare = CGRectMake(posX, posY,
                                   edge, edge);
    // If orientation indicates a change to portrait.
    if(original.imageOrientation == UIImageOrientationLeft ||
       original.imageOrientation == UIImageOrientationRight)
    {
        cropSquare = CGRectMake(posY, posX,
                                edge, edge);
        
    }
    else
    {
        cropSquare = CGRectMake(posX, posY,
                                edge, edge);
    }
    
    
    // This performs the image cropping.
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([original CGImage], cropSquare);
    
    ret = [UIImage imageWithCGImage:imageRef
                              scale:original.scale
                        orientation:original.imageOrientation];
    
    CGImageRelease(imageRef);
    
    return ret;
}


@end
