//
//  MessageTableViewCell.m
//  BuShangBanApp
//
//  Created by Zuo on 16/4/18.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "NSString+Utility.h"

@interface MessageTableViewCell() {
    
    UIButton *_avarButton;//头像
    
    UILabel *_mainTitleLabel;
    UILabel *_subTitleLabel;
}

@end

@implementation MessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _avarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _avarButton.frame = CGRectMake(12, 6, 36, 36);
        [_avarButton.layer setMasksToBounds:YES];
        _avarButton.layer.cornerRadius = 18;
//        [_avarButton setBackgroundColor:[UIColor blueColor]];
        [self.contentView addSubview:_avarButton];
        
        _mainTitleLabel = [[UILabel alloc] init];
        [_mainTitleLabel setFrame:CGRectMake(60, 9, kScreenWidth-24-48, 14)];
        [_mainTitleLabel setTextAlignment:NSTextAlignmentLeft];
        _mainTitleLabel.numberOfLines = 1;
        [_mainTitleLabel setFont:[UIFont systemFontOfSize:14]];
        [_mainTitleLabel setTextColor:COLOR(37, 37, 37)];
        [self.contentView addSubview:_mainTitleLabel];
        
        //////////////////////////////////////////
        _subTitleLabel = [[UILabel alloc] init];
        [_subTitleLabel setFrame:CGRectMake(60, _mainTitleLabel.bottom+6,  kScreenWidth-24-48, 11)];
        [_subTitleLabel setTextColor:COLOR(135, 135, 135)];
        _subTitleLabel.numberOfLines = 1;
        [_subTitleLabel setTextAlignment:NSTextAlignmentLeft];
        [_subTitleLabel setFont:[UIFont systemFontOfSize:10]];
        [self.contentView addSubview:_subTitleLabel];
        
        
    }
    
    return self;
}

-(void)refreshUI {
    
    if([self.dataInfo count]>1){
        
//        NSString *avarString = [NSString stringWithFormat:@"%@",[self.dataInfo objectForKey:@"avar"]];
        [_avarButton setImage:[UIImage imageNamed:@"System"] forState:UIControlStateNormal];
//        NSString *mainTitleString = @"系统通知";
//        if([[self.dataInfo objectForKey:@"mainTitle"] isBlankString]){
//        
//            mainTitleString = @"系统消息";
//        }else{
//        
//           mainTitleString = [NSString stringWithFormat:@"%@",[self.dataInfo objectForKey:@"mainTitle"]];
//        }
        NSString *mainTitleString = [NSString stringWithFormat:@"%@",[self.dataInfo objectForKey:@"title"]];

        NSString *subTitleString = [NSString stringWithFormat:@"%@",[self.dataInfo objectForKey:@"summary"]];
        [_mainTitleLabel setText:[NSString stringWithFormat:@"%@",mainTitleString]];
        [_subTitleLabel setText:[NSString stringWithFormat:@"%@",subTitleString]];
        
        
    }
    
    
}


/*
 
 results =     (
 {
 createdAt = "2016-04-12T08:18:44.666Z";
 isread = 0;
 link = "http://bushangban.com/news/3.html";
 objectId = 570caf64c4c971005485bb04;
 summary = "\U5e45\U8f1d\U5149\U53f0\U6e96\U6709\U76ee\U8ee2\U7a3f\U7968\U4ed9\U5c4b\U518d";
 title = "\U4ea4\U5f35\U7642\U7406\U7de8\U91ce\U8077\U65c5\U5bdf\U5a5a\U6226\U5973\U8a18\U6c11\U5909\U982d\U4f5c";
 updatedAt = "2016-04-12T08:19:07.411Z";
 },
 {
 createdAt = "2016-04-12T08:18:06.326Z";
 isread = 0;
 link = "http://bushangban.com/news/2.html";
 objectId = 570caf3e1ea493006b44c2ed;
 summary = "\U7d19\U80fd\U9593\U89e3\U6696\U9000\U66f4\U5fb4\U56e3\U5eb7\U672b\U5916\U6b63\U7d42\U4e2d\U738b\U65b0\U958b\U56e3";
 title = "\U7d4c\U52df\U611b\U58f2\U984c\U5bb6\U5e2f\U610f\U6388\U5728\U66ae\U5074\U96bc\U8853\U61f8";
 updatedAt = "2016-04-12T08:18:20.692Z";
 },
 {
 createdAt = "2016-04-12T08:15:51.402Z";
 isread = 0;
 link = "http://bushangban.com/news/1.html";
 objectId = 570caeb78ac2470064238d43;
 summary = "\U5b98\U56de\U5728\U8cc7\U610f\U90ce\U65e5\U793e\U8ca0\U4e0b\U898f\U821f\U6709\U90a6\U5730\U4e0b\U60aa\U8a2d\U6574";
 title = "\U97ff\U6751\U4e21\U7d44\U6700\U7d22\U829d\U5468\U4f5c\U6d77\U4fdd\U56e3\U964d\U7b11";
 updatedAt = "2016-04-12T08:17:44.437Z";
 }
 );
 }
 
 */




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
