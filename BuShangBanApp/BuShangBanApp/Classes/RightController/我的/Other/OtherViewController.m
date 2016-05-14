//
//  OtherViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "OtherViewController.h"
#import "MineCell.h"
#import "MineSectionHeaderView.h"
#import "SettingViewController.h"
#import "OtherViewController.h"

#define userURL @"https://leancloud.cn:443/1.1/classes/_User/570387b3ebcb7d005b196d24"
#define articalURL @"https://leancloud.cn:443/1.1/classes/Post?where=%7B%22author%22%3A%7B%22__type%22%3A%22Pointer%22%2C%22className%22%3A%22_User%22%2C%22objectId%22%3A%22570387b3ebcb7d005b196d24%22%7D%7D&count=1&limit=0"

#define  aboutMe @"https://leancloud.cn/1.1/users/570387b3ebcb7d005b196d24/followersAndFollowees?limit=0&count=1"

@interface OtherViewController()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)User *user;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,weak)UITableView *commandTableView;
@property(nonatomic,weak)UIView *maskView;
@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self __loadData];
    [self __createUI];
}

-(void)__loadData {
    self.user=[[User alloc]init];
    
    //    SSLXUrlParamsRequest *_urlParamsReq2 = [[SSLXUrlParamsRequest alloc] init];
    //    [_urlParamsReq2 setUrlString:aboutMe];
    //    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq2 successBlock:^(SSLXResultRequest *successReq){
    //        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
    //
    //        NSLog(@"*************aboutMe:%@",_successInfo);
    //
    //    } failureBlock:^(SSLXResultRequest *failReq){
    //        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
    //        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
    //        _errorMsg? [MBProgressHUD showError:_errorMsg]: [MBProgressHUD showError:kMBProgressErrorTitle];
    //    }];
    
    SSLXUrlParamsRequest *_urlParamsReq1 = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq1 setUrlString:articalURL];
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq1 successBlock:^(SSLXResultRequest *successReq){
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        self.user.artcailCount=_successInfo[@"count"];
    } failureBlock:^(SSLXResultRequest *failReq){
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        _errorMsg? [MBProgressHUD showError:_errorMsg]: [MBProgressHUD showError:kMBProgressErrorTitle];
    }];
    
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq setUrlString:userURL];
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        
        self.user.city_name=_successInfo[@"city_name"];
        self.user.birthDay=_successInfo[@"birthday"];
        self.user.mobilePhoneNumber=_successInfo[@"mobilePhoneNumber"];
        self.user.interest=_successInfo[@"interest"];
        self.user.username=_successInfo[@"username"];
        self.user.profession=_successInfo[@"profession"];
        self.user.sex = _successInfo[@"sex"];
        self.user.email=_successInfo[@"email"];
        self.user.label=_successInfo[@"title"];
        self.user.avatar=_successInfo[@"avatar"];
        
        self.user.avatarImageURL=[NSURL URLWithString:self.user.avatar[@"url"]];
        
        self.collectionView.backgroundColor=bgColor;
    } failureBlock:^(SSLXResultRequest *failReq){
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        _errorMsg? [MBProgressHUD showError:_errorMsg]: [MBProgressHUD showError:kMBProgressErrorTitle];
    }];
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
        
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:self.user.profession attributes:dimDic]];
        
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@,23岁",([self.user.sex integerValue] ==1?@"男":@"女")] attributes:dimDic]];
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:self.user.city_name attributes:dimDic]];
        
        NSMutableAttributedString *articalAttr=[[NSMutableAttributedString alloc]initWithString:@"文章篇" attributes:dimDic];
        NSAttributedString *articalInsertAttr=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",self.user.artcailCount] attributes:blackDic];
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
        [_imageDataSource addObject:[UIImage imageNamed:self.user.profession]];
        [_imageDataSource addObject:[UIImage imageNamed:([self.user.sex integerValue] ==1?@"men":@"female")]];
        [_imageDataSource addObject:[UIImage imageNamed:@"location_big"]];
        [_imageDataSource addObject:[UIImage imageNamed:@"article"]];
        [_imageDataSource addObject:[UIImage imageNamed:@"detailed list"]];
        [_imageDataSource addObject:[UIImage imageNamed:@"activity"]];
        [_imageDataSource addObject:[UIImage imageNamed:@"wechat"]];
        [_imageDataSource addObject:[[UIImage alloc]init]];
        [_imageDataSource addObject:[[UIImage alloc]init]];
    }
    return _imageDataSource;
}


-(void)settingBtn:(UIButton *)btn
{
    [self __showCommandTableView];
}

-(UIButton *)__btnWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(__btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=[UIFont fontWithName:fontName size:16.f];
    btn.backgroundColor=[UIColor whiteColor];
    btn.tag=tag;
    [self.view addSubview:btn];
    return btn;
}

-(void)__showCommandTableView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha=0.4f;
        self.commandTableView.top=kScreenHeight-49*3;
    }];
}

-(void)__hideCommandtableView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.maskView.alpha=0.4f;
        self.commandTableView.top=kScreenHeight;
    }completion:^(BOOL finished) {
        [_commandTableView removeFromSuperview];
        [_maskView removeFromSuperview];
    }];
}

-(void)__btnEvent:(UIButton *)sender
{
    if (sender.tag == 1000) {
        sender.selected=!sender.selected;
    }else if(sender.tag == 1001)
    {
        NSLog(@"1001");
    }
}

-(void)__createUI
{
    UIButton *focusBtn=[self __btnWithTitle:@"关注" tag:1000];
    focusBtn.frame=CGRectMake(0, kScreenHeight-49, kScreenWidth/2, 49);
    [focusBtn setTitle:@"已关注" forState:UIControlStateSelected];
    [focusBtn setTitleColor:[UIColor colorWithHexString:@"f5a623"] forState:UIControlStateNormal];
    [focusBtn setTitleColor:[UIColor colorWithHexString:@"373737"] forState:UIControlStateSelected];
    [focusBtn setImage:[UIImage imageNamed:@"follow"] forState:UIControlStateNormal];
    [focusBtn setImage:[[UIImage alloc]init] forState:UIControlStateSelected];
    focusBtn.titleEdgeInsets=UIEdgeInsetsMake(0, 24, 0, 0);
    
    UIButton *chatBtn=[self __btnWithTitle:@"私聊" tag:1001];
    [chatBtn setTitleColor:[UIColor colorWithHexString:@"373737"] forState:UIControlStateNormal];
    chatBtn.frame=CGRectMake(focusBtn.right, kScreenHeight-49, kScreenWidth/2, 49);
    
    [self __shapeLayerWithStartPoint:CGPointMake(0, kScreenHeight-49) endPoint:CGPointMake(kScreenWidth, kScreenHeight-49)];
    [self __shapeLayerWithStartPoint:CGPointMake(self.view.width/2,  kScreenHeight-45) endPoint:CGPointMake(self.view.width/2,kScreenHeight-4 )];
    [self __shapeLayerWithStartPoint:CGPointMake(0, kScreenHeight-1) endPoint:CGPointMake(kScreenWidth, kScreenHeight-1)];
}


- (CAShapeLayer *)__shapeLayerWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.strokeColor=[UIColor colorWithHexString:@"d9d9d9"].CGColor;
    shapeLayer.lineCap   = kCALineCapRound;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    shapeLayer.path = path.CGPath;
    [self.view.layer addSublayer:shapeLayer];
    return shapeLayer;
}

-(UITableView *)commandTableView
{
    if (!_commandTableView) {
        UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 49*3) style:UITableViewStyleGrouped];
        tableView.contentSize=CGSizeMake(self.view.width, 49*3);
        tableView.delegate=self;
        tableView.dataSource=self;
        [self.view addSubview:tableView];
        _commandTableView=tableView;
    }
    return _commandTableView;
}

-(UIView *)maskView
{
    if (!_maskView) {
        UIView *view=[[UIView alloc]initWithFrame:self.view.bounds];
        view.backgroundColor=[UIColor grayColor];
        view.alpha=1;
        _maskView=view;
        [self.view addSubview:_maskView];
    }
    return _maskView;
}



#pragma mark -- 代理 --


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 49)];
    label.font=[UIFont fontWithName:fontName size:16];
    label.textColor=[UIColor colorWithHexString:@"616161"];
    label.textAlignment=NSTextAlignmentCenter;
    [cell addSubview:label];
    switch (indexPath.row) {
        case 0:
            label.text=@"分 享";
            break;
        case 1:
            label.text=@"屏 蔽";
            break;
        case 2:
            label.text=@"取 消";
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            [UIView animateWithDuration:0.5 animations:^{
                self.commandTableView.height=kScreenHeight;
            }completion:^(BOOL finished) {
                [self.commandTableView removeFromSuperview];
            }];
            break;
    }
    [self __hideCommandtableView];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 49;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

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
        if(self.user.avatarImageURL)
            [sectionHeaderView.headImageView sd_setImageWithURL:self.user.avatarImageURL];
        else
            sectionHeaderView.headImageView.image = [UIImage imageNamed:@"Default avatar"];
        [sectionHeaderView labelWithLable:sectionHeaderView.focusMeLabel Titlt:@"关注我" digit:100];
        [sectionHeaderView labelWithLable:sectionHeaderView.myFocusLabel Titlt:@"我关注" digit:234];
        [sectionHeaderView nickNameLabelWithNickName:self.user.username label:self.self.user.label];
        reusableView=sectionHeaderView;
    }
    return reusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        //        [[SliderViewController sharedSliderController].navigationController pushViewController:[[OtherViewController alloc] init] animated:YES];
    }
}

@end
