//
//  UIImage+Extension.h
//  ShunShunLiuXue
//
//  Created by AndyJerry on 15/9/23.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  返回一张拉伸的图片
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)resizeWithImageName:(NSString *)name;
@end
