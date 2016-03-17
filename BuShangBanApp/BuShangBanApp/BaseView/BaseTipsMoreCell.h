//
//  BaseTipsMoreCell.h
//  ShunShunApp
//
//  Created by Peter Lee on 16/1/14.
//  Copyright © 2016年 顺顺留学. All rights reserved.
//

#import "BaseTableCell.h"

@interface BaseTipsMoreCell : BaseTableCell

@property (nonatomic, assign) BOOL isNeedMoreResult;
@property (nonatomic, assign) BOOL isNeedGrayGap;

@property (nonatomic, assign) NSString *tipsTitle;
@property (nonatomic, copy) clickBlock moreActionBlock;

-(void)resetGrayGapTopWithCellHeight:(CGFloat)cellHeight;

@end
