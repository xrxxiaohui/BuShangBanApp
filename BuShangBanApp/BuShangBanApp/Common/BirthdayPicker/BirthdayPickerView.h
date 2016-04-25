//
//  BirthdayPickerView.h
//  BuShangBanApp
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 Zuo. All rights reserved.
//
@class BirthdayPickerView;

typedef void (^BirthdayPickerBlock)(BirthdayPickerView *view,NSString *contentText);

@interface BirthdayPickerView : UIView

@property(nonatomic,copy)BirthdayPickerBlock birthdayPickerBlock;

- (void)show;

@end
