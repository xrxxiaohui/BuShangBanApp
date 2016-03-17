//
//  MoreCell.m
//  hersForum
//
//  Created by hers on 12-12-12.
//  Copyright (c) 2012年 hers. All rights reserved.
//
#import "Define.h"
#import "MoreCell.h"

@implementation MoreCell
@synthesize tipLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        tipLabel  = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-60, 5,120 , 40)];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.backgroundColor = [UIColor clearColor];
//        tipLabel.textColor = kContentColor;
        tipLabel.font = kFontArial14;
        [tipLabel setTextColor:COLOR(0xb3, 0xb3, 0xb3)];
        [self.contentView addSubview:tipLabel];
        [tipLabel release];
        
        
//        actView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        actView.frame = CGRectMake(80.0f, 4.0f, 32.0f, 32.0f);
//        [self.contentView addSubview:actView];
//        [actView release];
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)startAction{
    [GMDCircleLoader setOnView:self withTitle:@"" animated:YES];
//    [actView startAnimating];
}

- (void)stopAction {
    [GMDCircleLoader hideFromView:self animated:YES];
}
//- (void)stopAction{
//    
////    [actView stopAnimating];
//}

- (void)setTips:(NSString *)aTip{
    
    tipLabel.text = aTip;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end




