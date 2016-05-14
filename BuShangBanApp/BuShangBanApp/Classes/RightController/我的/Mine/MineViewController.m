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
#import "User.h"
#import "BootstrapOneViewController.h"
#import "ConstObject.h"
#import "BootstrapViewController.h"

#define adapt  [[[ScreenAdapt alloc]init] adapt]

#define userURL @"https://leancloud.cn:443/1.1/classes/_User/%@"
#define  aboutMe @"https://leancloud.cn/1.1/users/%@/followersAndFollowees?limit=0&count=1"

#define articalURL @"%7B%22author%22%3A%7B%22__type%22%3A%22Pointer%22%2C%22className%22%3A%22_User%22%2C%22objectId%22%3A%22570387b3ebcb7d005b196d24%22%7D%7D&count=1&limit=0"

#define articalURL1 @"https://leancloud.cn:443/1.1/classes/Post?where="
#define url1 @"{\"author\":{\"__type\":\"Pointer\",\"className\":\"_User\",\"objectId\":\"%@\"}}"
#define url2 @"count=1"
#define url3 @"limit=0"

@interface MineViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)User *user;

@end


@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(judgeLoginStatus) name:@"judgeLoginStatus" object:nil];
   
//    UIButton *tempButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [tempButton setFrame:CGRectMake(100, kScreenHeight-120, 60, 60)];
//    [tempButton setBackgroundColor:[UIColor blueColor]];
//    [self.view addSubview:tempButton];
//    [tempButton addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
}

-(void)logOut{

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"0" forKey:kLoginStatus];
    [MBProgressHUD showSuccess:@"退出登录！"];
}

-(void)judgeLoginStatus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *loginStatus = [userDefaults objectForKey:kLoginStatus];
    
        if([loginStatus isEqualToString:@"1"]){
        //已登录
        [self __loadData];
    }else
        [[SliderViewController sharedSliderController].navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
}

-(void)__loadData {
    self.user=[[User alloc]init];
    
    SSLXUrlParamsRequest *_urlParamsRe = [[SSLXUrlParamsRequest alloc] init];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *finalObjectID = [userDefault objectForKey:kObjectID];

    [_urlParamsRe setUrlString:[NSString stringWithFormat:aboutMe,finalObjectID]];
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsRe successBlock:^(SSLXResultRequest *successReq){
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        self.user.myFocusNumber= _successInfo[@"followees_count"];
        self.user.focusMeNumber= _successInfo[@"followers_count"];
    } failureBlock:nil];
    
    SSLXUrlParamsRequest *_urlParamsReq1 = [[SSLXUrlParamsRequest alloc] init];
    
    NSString *pinObjectid = [NSString stringWithFormat:url1,finalObjectID];
    NSString *encodeUrlString =[self encodeToPercentEscapeString:pinObjectid];
    
    NSString *finalURL = [NSString stringWithFormat:@"%@%@%@%@",articalURL1,encodeUrlString,url2,url3];
    [_urlParamsReq1 setUrlString:finalURL];
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq1 successBlock:^(SSLXResultRequest *successReq){
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        self.user.artcailCount=_successInfo[@"count"];
    } failureBlock:nil];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy,MM,dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSArray *dateArr=[dateTime componentsSeparatedByString:@","];
    NSInteger  currentYear=[[NSString stringWithString:dateArr[0]] integerValue];
    
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
//    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    [_urlParamsReq setUrlString:[NSString stringWithFormat:userURL,finalObjectID]];
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
    
        self.user.city_name=SafeForString(_successInfo[@"city_name"]);
        self.user.birthDay=SafeForString([_successInfo[@"birthday"] objectForKey:@"iso"]);
        self.user.mobilePhoneNumber=SafeForString(_successInfo[@"mobilePhoneNumber"]);
        self.user.interest=SafeForString(_successInfo[@"interest"]);
        self.user.username=SafeForString(_successInfo[@"username"]);
        self.user.profession=SafeForString(_successInfo[@"profession"]);
        
        self.user.sex = SafeForString(_successInfo[@"sex"]);
        self.user.email=SafeForString(_successInfo[@"email"]);
        self.user.label=SafeForString(_successInfo[@"title"]);
        self.user.avatar=SafeForDictionary(_successInfo[@"avatar"]);
        if(self.user.avatar.count>0)
            self.user.avatarImageURL=([NSURL URLWithString:self.user.avatar[@"url"]]);
        self.user.age = (currentYear-[[self.user.birthDay componentsSeparatedByString:@"-"][0] integerValue] +1);
        self.user.nickName =SafeForString(_successInfo[@"nickname"]);
        
        self.collectionView.backgroundColor=bgColor;
    } failureBlock:^(SSLXResultRequest *failReq){
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        _errorMsg? [MBProgressHUD showError:_errorMsg]: [MBProgressHUD showError:kMBProgressErrorTitle];
    }];
}

-(void)settingBtn:(UIButton *)btn
{
    SettingViewController *setVC=[[SettingViewController alloc] init];
    NSDictionary *avatarDic = SafeForDictionary(self.user.avatar);
    NSURL *avarImageUrl = [NSURL URLWithString:SafeForString([avatarDic objectForKey:@"url"])];
    [setVC initWithImageURL:avarImageUrl];
//                                  WithImageURL:self.user.avatarImageURL];
    setVC.userNames = SafeForString(self.user.nickName);
    setVC.detailtext = SafeForString(self.user.profession);
    [[SliderViewController sharedSliderController].navigationController pushViewController:setVC  animated:YES];
}

- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString* outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, /* allocator */(__bridge CFStringRef)input,NULL, /* charactersToLeaveUnescaped */ (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
    return outputStr;
}
#pragma mark -- 懒加载 --
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        layout.minimumLineSpacing=1.5f;
        layout.minimumInteritemSpacing=1.f;
        
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth+200 *adapt.scaleHeight) collectionViewLayout:layout];
        [_collectionView registerClass:[MineCell class] forCellWithReuseIdentifier:@"MineCell"];
        [_collectionView registerClass:[MineSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
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
        NSDictionary *blackDic=@{NSFontAttributeName:[UIFont fontWithName:fontName size:20 * adapt.scaleWidth],
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"000000"]};
        NSDictionary *dimDic=@{NSFontAttributeName:smallerFont,
                               NSForegroundColorAttributeName:[UIColor colorWithHexString:@"808080"]};

        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:SafeForString(self.user.profession) attributes:dimDic]];
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%lu岁,%@",(unsigned long)self.user.age ,([self.user.sex integerValue] ==1?@"男":@"女")] attributes:dimDic]];
        [_titleDataSource addObject:[[NSAttributedString alloc]initWithString:SafeForString(self.user.city_name) attributes:dimDic]];
        NSMutableAttributedString *articalAttr=[[NSMutableAttributedString alloc]initWithString:@"文章篇" attributes:dimDic];
        NSAttributedString *articalInsertAttr=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",self.user.artcailCount?self.user.artcailCount:@"0"] attributes:blackDic];
        [articalAttr insertAttributedString:articalInsertAttr atIndex:2];
        [_titleDataSource addObject:articalAttr];
        
        NSMutableAttributedString *detailedListAttr=[[NSMutableAttributedString alloc]initWithString:@"清单篇" attributes:dimDic];
        NSAttributedString *detailedListInsertAttr=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:SafeForString(@" 0 ")] attributes:blackDic];
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
        [_imageDataSource addObject:[UIImage imageNamed:self.user.profession?self.user.profession:@"技术"]];
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
    
    [cell setImage:self.imageDataSource[indexPath.row] title:self.titleDataSource[indexPath.row]];
    cell.contentImageView.image=self.imageDataSource[indexPath.row];
    if (indexPath.row == 4 || indexPath.row == 5)
        cell.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 200 *adapt.scaleHeight);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView=nil;
    if (kind == UICollectionElementKindSectionHeader) {
        MineSectionHeaderView *sectionHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
         [sectionHeaderView.settingBtn addTarget:self action:@selector(settingBtn:) forControlEvents:UIControlEventTouchUpInside];
        [sectionHeaderView.settingBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        if(self.user.avatarImageURL)
            [sectionHeaderView.headImageView sd_setImageWithURL:self.user.avatarImageURL];
        else
            sectionHeaderView.headImageView.image = [UIImage imageNamed:@"Default avatar"];
        [sectionHeaderView labelWithLable:sectionHeaderView.focusMeLabel Titlt:@"关注我" digit:(int32_t)[ SafeForString(self.user.focusMeNumber) integerValue]];
        [sectionHeaderView labelWithLable:sectionHeaderView.myFocusLabel Titlt:@"我关注" digit:(int32_t)[SafeForString(self.user.focusMeNumber) integerValue]];
        [sectionHeaderView.focusMeLabel sizeToFit];
        sectionHeaderView.focusMeLabel.right=kScreenWidth/2-ceilf(14*adapt.scaleWidth);
        [sectionHeaderView nickNameLabelWithNickName:SafeForString(self.user.username) label:self.self.user.profession];
        reusableView=sectionHeaderView;
    }
    return reusableView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
