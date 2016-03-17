//
//  WechatShareView.h
//  ShunShunApp
//
//  Created by Peter Lee on 15/11/13.
//  Copyright © 2015年 顺顺留学. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WechatShareView : UIView

@property (nonatomic, strong) NSDictionary *shareInfo;

@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareDesc;
@property (nonatomic, copy) NSString *shareUrl;

-(id)initWechatShareView;
-(void)showUI;
-(void)refreshUI;

- (void)dismissShareView;

@end
