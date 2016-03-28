//
//  BaseTableCell.h
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//



typedef void (^clickBlock)(void);

@interface BaseTableCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataInfo;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *stringInfo;

-(void)refreshUI;

+(CGFloat)getCellHeight;
+(CGFloat)getCellHeightWithDataInfo:(NSDictionary *)dataInfo;

@end
