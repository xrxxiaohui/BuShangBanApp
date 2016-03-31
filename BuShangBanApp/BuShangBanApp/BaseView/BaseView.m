//
//  BaseView.m
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/16.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=backgroundCoor;
    }
    return self;
}

-(void)refreshUI {
    
}

@end
