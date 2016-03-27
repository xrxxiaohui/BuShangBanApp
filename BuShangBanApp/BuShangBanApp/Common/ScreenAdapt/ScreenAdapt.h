//
//  ScreenAdapt.h
//  Youqun
//
//  Created by mac on 16/2/18.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

@interface ScreenAdapt : NSObject
#import "iPhoneScreen.h"

@property(nonatomic,assign)CGFloat scaleWidth;
@property(nonatomic,assign)CGFloat scaleHeight;
-(ScreenAdapt *)adapt;
-(CGSize)adaptWithSize:(CGSize)size;

@end
