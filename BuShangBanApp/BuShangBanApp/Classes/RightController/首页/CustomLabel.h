//
//  CustomLabel.h
//  DrawTest
//
//  Created by Polaris Tang on 12-7-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomLabel : UILabel
@property(assign,nonatomic) CGSize glowoffset;
@property(assign,nonatomic) CGFloat glowAmount;
@property(strong,nonatomic) UIColor *glowColor;

@end
