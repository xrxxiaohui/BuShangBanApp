//
//  MineViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.


#import "MineViewController.h"
#import "MineCell.h"
#import "MineSectionHeaderView.h"
#import "SettingViewController.h"
#import "OtherViewController.h"

#import "LoginViewController.h"


//https://leancloud.cn:443/1.1/classes/_User/570387b3ebcb7d005b196d24

@interface MineViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation MineViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SliderViewController sharedSliderController].navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
    
//    AFHTTPSessionManager  *sessionManager=[AFHTTPSessionManager manager];
//    NSDictionary *dic=@{@"bid":@"fdOqfdJ3Ypgv6iaQJXLw7CgR-gzGzoHsz"};
//    
//    [sessionManager POST:@"https://leancloud.cn:443/1.1/classes/_User/570387b3ebcb7d005b196d24" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
//        NSLog(@"*************%@",responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"*************%@",error);
//    }];
}

-(void)settingBtn:(UIButton *)btn
{
    [[SliderViewController sharedSliderController].navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}

#pragma mark -- 懒加载 --
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumLineSpacing=1.5f;
        layout.minimumInteritemSpacing=1.f;
        
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth+200-18) collectionViewLayout:layout];
        [_collectionView registerClass:[MineCell class] forCellWithReuseIdentifier:@"MineCell"];
        [_collectionView registerClass:[MineSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
        _collectionView.backgroundColor=[UIColor colorWithHexString:@"d9d9d9"];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(NSMutableArray *)titleDataSource
{
    if (!_titleDataSource) {
        _titleDataSource=[NSMutableArray arrayWithCapacity:9];
        NSDictionary *blackDic=@{NSFontAttributeName:[UIFont fontWithName:fontName size:20],
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"000000"]};
        NSDictionary *dimDic=@{NSFontAttributeName:smallerFont,
                                        NSForegroundColorAttributeName:[UIColor colorWithHexString:@"808080"]};
        
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:@"设计" attributes:dimDic]];
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:@"男,23岁" attributes:dimDic]];
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:@"浙江杭州" attributes:dimDic]];
        
        NSMutableAttributedString *articalAttr=[[NSMutableAttributedString alloc]initWithString:@"文章篇" attributes:dimDic];
        NSAttributedString *articalInsertAttr=[[NSAttributedString alloc]initWithString:@" 9 " attributes:blackDic];
        [articalAttr insertAttributedString:articalInsertAttr atIndex:2];
        [_titleDataSource addObject:articalAttr];
        
        NSMutableAttributedString *detailedListAttr=[[NSMutableAttributedString alloc]initWithString:@"清单篇" attributes:dimDic];
        NSAttributedString *detailedListInsertAttr=[[NSAttributedString alloc]initWithString:@" 0 " attributes:blackDic];
        [detailedListAttr insertAttributedString:detailedListInsertAttr atIndex:2];
        [_titleDataSource addObject:detailedListAttr];
        
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:@"活动" attributes:dimDic]];
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:@"联系方式" attributes:dimDic]];
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:@" " attributes:dimDic]];
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:@" " attributes:dimDic]];
    }
    return _titleDataSource;
}

-(NSMutableArray *)imageDataSource
{
    if (!_imageDataSource)
    {
        _imageDataSource=[NSMutableArray arrayWithCapacity:9];
        [_imageDataSource addObject:[UIImage imageNamed:@"men"]];
        [_imageDataSource addObject:[UIImage imageNamed:@"female"]];
        [_imageDataSource addObject:[UIImage imageNamed:@"location"]];
        [_imageDataSource addObject:[UIImage imageNamed:@"article"]];
        [_imageDataSource addObject:[UIImage imageNamed:@"detailed list"]];
        [_imageDataSource addObject:[UIImage imageNamed:@"activity"]];
        [_imageDataSource addObject:[UIImage imageNamed:@"wechat"]];
        [_imageDataSource addObject:[[UIImage alloc]init]];
        [_imageDataSource addObject:[[UIImage alloc]init]];
    }
    return _imageDataSource;
}


#pragma mark -- 代理 --
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageDataSource.count;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth/3-1, kScreenWidth/3-1);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MineCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MineCell" forIndexPath:indexPath];
    cell.contentImageView.image=self.imageDataSource[indexPath.row];
    CGSize size=cell.contentImageView.image.size;
    cell.contentImageView.size=CGSizeMake(size.width *adapt.scaleWidth, size.height *adapt.scaleHeight);
    cell.contentLabel.attributedText=self.titleDataSource[indexPath.row];
    if (indexPath.row == 4 || indexPath.row == 5) {
        cell.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
    }
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 200);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(-18, 0, 0, 0);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView=nil;
    if (kind == UICollectionElementKindSectionHeader) {
    MineSectionHeaderView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    [sectionHeaderView.settingBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    UIImage *  image = [UIImage imageNamed:@"Default avatar"];
    [sectionHeaderView.headImageBtn setBackgroundImage:image forState:UIControlStateNormal];
    [sectionHeaderView labelWithLable:sectionHeaderView.focusMeLabel Titlt:@"关注我" digit:100];
    [sectionHeaderView labelWithLable:sectionHeaderView.myFocusLabel Titlt:@"我关注" digit:234];
    [sectionHeaderView nickNameLabelWithNickName:@"老编辑" label:@"不上班创始人"];
    reusableView=sectionHeaderView;
    }
    return reusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3)
        [[SliderViewController sharedSliderController].navigationController pushViewController:[[OtherViewController alloc] init] animated:YES];
}

@end
