//
//  FindView.h
//  BuShangBanApp
//
//  Created by mac on 16/3/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "BaseView.h"
#import "ScreenAdapt.h"
#import "UIView+Extension.h"
#import "iPhoneScreen.h"

@interface FindView : BaseView

typedef void(^evnetBlock)(NSInteger tag);
@property(nonatomic,copy)evnetBlock clickEvent;
@end
