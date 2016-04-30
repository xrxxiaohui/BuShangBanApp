//
//  EditInformationViewController.h
//  BuShangBanApp
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "QHBasicViewController.h"


@protocol EditInformationDelegate <NSObject>

<<<<<<< HEAD
-(void)EditInformationWithContentString:(NSString *)contentString;
=======
-(void)editInformationWithContentString:contentString;
>>>>>>> 631fb96176c49484a20f939c338bac2508d197c6

@end

@interface EditInformationViewController : QHBasicViewController

@property(nonatomic,weak)id <EditInformationDelegate>  delegate;

<<<<<<< HEAD
-(instancetype)initWithTitle:(NSString *)title;
=======
-(instancetype)initWithContentInfor:(NSArray *)infor;

>>>>>>> 631fb96176c49484a20f939c338bac2508d197c6
@end
