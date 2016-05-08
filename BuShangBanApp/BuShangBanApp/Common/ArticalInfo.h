//
//  ArticalInfo.h
//  BuShangBanApp
//
//  Created by mac on 16/4/30.
//  Copyright © 2016年 Zuo. All rights reserved.
//

@interface ArticalInfo : NSObject


@property(nonatomic,strong)NSDictionary *author;
@property(nonatomic,strong)NSDictionary *author_info;
@property(nonatomic,strong)NSDictionary *category;
@property(nonatomic,strong)NSDictionary *category_info;
@property(nonatomic,copy)NSString* category_name;
@property(nonatomic,strong)NSData *createdAt;
@property(nonatomic,copy)NSString *feature_image;
@property(nonatomic,strong)NSDictionary *featured_at;
@property(nonatomic,strong)NSDictionary *likes;
@property(nonatomic,assign)NSInteger likes_count;
@property(nonatomic,copy)NSString *objectId;
@property(nonatomic,strong)NSDictionary *published_at;
@property(nonatomic,strong)NSDictionary *sources;
@property(nonatomic,copy)NSString *summary;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *updatedAt;
@property(nonatomic,copy)NSString *views;


@end
