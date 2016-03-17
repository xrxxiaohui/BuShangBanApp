//
//  BaseView.h
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/16.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^clickBlock)(void);

@interface BaseView : UIView

@property (nonatomic, strong) NSDictionary *dataInfo;

-(void)refreshUI;

@end
