//
//  OccupationSelectorView.h
//  OccupationSelectot
//
//  Created by mac on 16/4/2.
//  Copyright © 2016年 mac. All rights reserved.
//

@class OccupationSelectorView;

typedef void (^OccupationSelectorBlock)(OccupationSelectorView *view,NSString *contentText);

@interface OccupationSelectorView : UIView

@property(nonatomic,copy)OccupationSelectorBlock occupationSelectorBlock;

@property(nonatomic,strong)NSString *contentString;
@property(nonatomic,copy)NSString *contentText;

- (void)show;

@end
