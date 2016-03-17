//
//  BaseTableCell.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//


#import "BaseTableCell.h"

@implementation BaseTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

-(void)refreshUI {

}

+(CGFloat)getCellHeight {

    return 0;
}

+(CGFloat)getCellHeightWithDataInfo:(NSDictionary *)dataInfo {

    return 0;
}

-(void)dealloc {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
