//
//  EditInformationViewController.h
//  BuShangBanApp
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "QHBasicViewController.h"


@protocol EditInformationDelegate <NSObject>

-(void)EditInformationWithContentString:(NSString *)contentString;

@end

@interface EditInformationViewController : QHBasicViewController

@property(nonatomic,weak)id <EditInformationDelegate>  delegate;

-(instancetype)initWithTitle:(NSString *)title;
@end
