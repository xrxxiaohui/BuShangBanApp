//
//  HomePageContentCell.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageContentCell : BaseTableCell


@property (nonatomic, copy) clickBlock zanButtonActionBlock;
@property (nonatomic, copy) clickBlock commentButtonActionBlock;
@property (nonatomic, copy) clickBlock shareButtonActionBlock;

@end
