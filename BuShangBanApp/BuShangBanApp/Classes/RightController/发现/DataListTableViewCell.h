//
//  DataListTableViewCell.h
//  BuShangBanApp
//
//  Created by mac on 16/5/6.
//  Copyright © 2016年 Zuo. All rights reserved.
//

@interface DataListTableViewCell :  BaseTableCell

@property (nonatomic, copy) clickBlock zanButtonActionBlock;
@property (nonatomic, copy) clickBlock commentButtonActionBlock;
@property (nonatomic, copy) clickBlock shareButtonActionBlock;

@property(nonatomic,strong)UILabel *leftUpLabel;

@property(nonatomic,strong)UIImageView *centerImageView;
@property(nonatomic,strong)UILabel *mainTitleLabel;
@property(nonatomic,strong)UILabel *mainContentLabel;

@property(nonatomic,strong)UILabel *shareNumLabel;
@property(nonatomic,strong)UILabel *commentNumLabel;
@property(nonatomic,strong)UILabel *zanNumLabel;
@property(nonatomic,strong)UIButton *rightAvarButton;


@end
