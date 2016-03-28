//
//  ScreenAdapt.m
//  Youqun
//
//  Created by mac on 16/2/18.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

#import "ScreenAdapt.h"


@implementation ScreenAdapt

- (ScreenAdapt *)adapt {
    if (iPhoneScreenHeight == iPhone6PlusHeight) {
        _scaleHeight = 1.0f;
        _scaleWidth = 1.0f;
    }
    else if (iPhoneScreenHeight == iPhone6Height) {
        _scaleHeight = iPhoneScreenHeight / iPhone6PlusHeight;
        _scaleWidth = iPhoneScreenWidth / iPhone6PlusWidth;
    }
    else if (iPhoneScreenHeight == iPhone5Height) {
        _scaleHeight = iPhoneScreenHeight / iPhone6PlusHeight;
        _scaleWidth = iPhoneScreenWidth / iPhone6PlusWidth;
    }
    return self;
}

- (CGSize)adaptWithSize:(CGSize)size {
    [self adapt];
    return CGSizeMake(size.width * _scaleWidth, size.height * _scaleHeight);
}
@end
