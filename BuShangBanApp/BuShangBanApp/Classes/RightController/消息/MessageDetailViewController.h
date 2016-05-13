//
//  MessageDetailViewController.h
//  BuShangBanApp
//
//  Created by Zuo on 16/5/12.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrowBackViewController.h"

@interface MessageDetailViewController : ArrowBackViewController

@property (nonatomic, copy)    NSString *titles;
@property (nonatomic, copy)    NSString *messageString;

@end
