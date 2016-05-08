//
//  HomeHeadViewCell.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//


@interface HomeHeadViewCell : BaseTableCell

@property (nonatomic, copy) clickBlock leftButtonActionBlock;
@property (nonatomic, copy) clickBlock rightUpButtonActionBlock;
@property (nonatomic, copy) clickBlock rightDownActionBlock;

@end
