//
//  LeftViewController.m
//  Mei Zhuang
//
//  Created by Apple on 13-10-29.
//  Copyright (c) 2013年 Apple. All rights reserved.
//
#import "LeftViewController.h"

#import "SliderViewController.h"
#import "LeftTableViewCell.h"
//#import "LoginViewController.h"
//#import "PersonalViewController.h"
//#import "AddressViewController.h"

//#import "AccountGetUserInfoApi.h"

//#import "SSAdviserDetailViewController.h"
//#import "SelectThemeViewController.h"

@interface LeftViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_arData;
    NSDictionary *_dicData;
    UITableView *_tableView;
    UITableView *centerTableView;
    UIButton *avatarButton;
    
    UILabel *nameLabel;
    UILabel *haveAnswerQuestionNum;
    UILabel *zanNumLabel;
    UILabel *zanTextLabel;
    UILabel *fansNumLabel;
    UILabel *fansTextLabel;
    UILabel *inviteNumLabel;
    UILabel *inviteTextLabel;
    UIImageView *lineImage;
    UIImageView *lineImage1;
    
    UIButton *loginButton;

    NSDictionary *_user;
}

@property(nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation LeftViewController
@synthesize dataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR(0x1a, 0x46, 0x7b);
    
    self.dataArray = [NSMutableArray arrayWithCapacity:1];
    [self addObserver];
    
    UIImageView *_statusBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, kScreenWidth, 0.f)];
    if (isIos7 >= 7 && __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)
    {
        _statusBarView.frame = CGRectMake(_statusBarView.frame.origin.x, _statusBarView.frame.origin.y, _statusBarView.frame.size.width, 20.f);
        _statusBarView.backgroundColor = [UIColor clearColor];
        //        ((UIImageView *)_statusBarView).backgroundColor = [UIColor clearColor];
        ((UIImageView *)_statusBarView).backgroundColor =  COLOR(0x1a, 0x46, 0x7b);
        [self.view addSubview:_statusBarView];
        //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
    }
    
    if (kSystemIsIOS7) {
        centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x,20.0f, kScreenBounds.size.width, kScreenBounds.size.height) style:UITableViewStyleGrouped];
    }
    else{
        centerTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenBounds.origin.x,0.0f, kScreenBounds.size.width, kScreenBounds.size.height) style:UITableViewStylePlain];
    }
    //    centerTableView.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"viewBackGround.png"]] autorelease];
    centerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    centerTableView.backgroundColor = COLOR(0x19, 0x46, 0x7a);
    centerTableView.backgroundColor = [UIColor whiteColor];
    centerTableView.delegate = self;
    centerTableView.dataSource = self;
    //    centerTableView.backgroundColor = [UIColor clearColor];
    centerTableView.scrollEnabled = NO;
    //设置表头部个人信息
    centerTableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 175+20)];
        view.backgroundColor = COLOR(0x1a, 0x46, 0x7b);
        // 透明大背景,点击进入个人主页
        //        UIButton *profileBackgroundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        profileBackgroundButton.frame = CGRectMake(0, 0.0f, kScreenBounds.size.width, 2*74.0f);
        //        profileBackgroundButton.backgroundColor = [UIColor clearColor];
        //        profileBackgroundButton.adjustsImageWhenHighlighted = NO;
        ////        [profileBackgroundButton addTarget:self action:@selector(toProfileViewController) forControlEvents:UIControlEventTouchUpInside];
        //        [view addSubview:profileBackgroundButton];
        
        // 头像
        avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        avatarButton.backgroundColor = [UIColor clearColor];
        avatarButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        if(iPhone5)
            avatarButton.frame = CGRectMake(140.0f-33, 45.0f, 66.0f, 66.0f);
        else if (iPhone6)
            avatarButton.frame = CGRectMake(156.0f-33, 45.0f, 66.0f, 66.0f);
        else
            avatarButton.frame = CGRectMake(180.0f-33, 45.0f, 66.0f, 66.0f);
        
        avatarButton.layer.masksToBounds = YES;
        avatarButton.layer.cornerRadius = 33.0;
        //        avatarButton.layer.borderColor = COLOR(0x19, 0x46, 0x7a).CGColor;
        //        avatarButton.layer.borderWidth = 2.0f;
        avatarButton.layer.rasterizationScale = [UIScreen mainScreen].scale;
        avatarButton.layer.shouldRasterize = YES;
        avatarButton.clipsToBounds = YES;
        [avatarButton setImage:[UIImage imageNamed:@"pinkImage"] forState:UIControlStateNormal];
       // avatarButton.backgroundColor = COLOR(231, 231, 231);
        //        [avatarButton setBackgroundImage:[UIImage imageNamed:@"avar"] forState:UIControlStateNormal];
        //        [avatarButton setImage:[UIImage imageNamed:@"avar"] forState:UIControlStateNormal];
        [avatarButton addTarget:self action:@selector(toLoginPage) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:avatarButton];
        
        nameLabel = [[UILabel alloc] init];
        [nameLabel setText:@"未登录"];
        [nameLabel setFrame:CGRectMake(0, 0, 120, 18)];
        nameLabel.textAlignment= NSTextAlignmentCenter;
        [nameLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        //        [view addSubview:nameLabel];
        
        loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [loginButton setTitle:@"未登录" forState:UIControlStateNormal];
        [loginButton setFrame:CGRectMake(avatarButton.x-26, avatarButton.bottom+15, 120, 18)];
        //        [loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
        //        [loginButton.titleLabel setTextColor:[UIColor whiteColor]];
        loginButton.titleLabel.textAlignment= NSTextAlignmentCenter;
        [loginButton addTarget:self action:@selector(toLoginPage) forControlEvents:UIControlEventTouchUpInside];
        [loginButton addSubview:nameLabel];
        [view addSubview:loginButton];
        /*
        haveAnswerQuestionNum = [[UILabel alloc] init];
        [haveAnswerQuestionNum setText:@"已回答     个问题"];
        [haveAnswerQuestionNum setFrame:CGRectMake(avatarButton.right+10, avatarButton.origin.y+40, 120, 13)];
        haveAnswerQuestionNum.textAlignment= NSTextAlignmentLeft;
        [haveAnswerQuestionNum setFont:kFontArial13];
        [haveAnswerQuestionNum setTextColor:COLOR1(0xb5, 0xca, 0xe7)];
        [view addSubview:haveAnswerQuestionNum];
        
        lineImage = [[UIImageView alloc] init];
        lineImage.backgroundColor = COLOR(0x1a, 0x46, 0x7b);
        [lineImage setFrame:CGRectMake(30, avatarButton.bottom+20, kScreenWidth-30, 0.8)];
        [view addSubview:lineImage];
        
        zanNumLabel= [[UILabel alloc] init];
        [zanNumLabel setText:@"0"];
        [zanNumLabel setFrame:CGRectMake(37, avatarButton.bottom+30, 60, 17)];
        [zanNumLabel setFont:kFontArial17];
        zanNumLabel.textAlignment= NSTextAlignmentLeft;
        [zanNumLabel setTextColor:[UIColor whiteColor]];
        [view addSubview:zanNumLabel];
        
        zanTextLabel= [[UILabel alloc] init];
        [zanTextLabel setText:@"赞"];
        [zanTextLabel setFrame:CGRectMake(35, zanNumLabel.bottom+10, 14, 12)];
        [zanTextLabel setFont:kFontArial12];
        zanTextLabel.textAlignment= NSTextAlignmentLeft;
        [zanTextLabel setTextColor:COLOR1(0xb5, 0xca, 0xe7)];
        [view addSubview:zanTextLabel];
        
        fansNumLabel= [[UILabel alloc] init];
        [fansNumLabel setText:@"0"];
        [fansNumLabel setFrame:CGRectMake(100, avatarButton.bottom+30, 60, 17)];
        [fansNumLabel setFont:kFontArial17];
        fansNumLabel.textAlignment= NSTextAlignmentLeft;
        [fansNumLabel setTextColor:[UIColor whiteColor]];
        [view addSubview:fansNumLabel];
        
        fansTextLabel= [[UILabel alloc] init];
        [fansTextLabel setText:@"粉丝"];
        [fansTextLabel setFrame:CGRectMake(94, zanNumLabel.bottom+10, 28, 12)];
        [fansTextLabel setFont:kFontArial12];
        fansTextLabel.textAlignment= NSTextAlignmentLeft;
        [fansTextLabel setTextColor:COLOR1(0xb5, 0xca, 0xe7)];
        [view addSubview:fansTextLabel];
        
        inviteNumLabel= [[UILabel alloc] init];
        [inviteNumLabel setText:@"0"];
        [inviteNumLabel setFrame:CGRectMake(167, avatarButton.bottom+30, 60, 17)];
        [inviteNumLabel setFont:kFontArial17];
        inviteNumLabel.textAlignment= NSTextAlignmentLeft;
        [inviteNumLabel setTextColor:[UIColor whiteColor]];
        [view addSubview:inviteNumLabel];
        
        inviteTextLabel= [[UILabel alloc] init];
        [inviteTextLabel setText:@"访问"];
        [inviteTextLabel setFrame:CGRectMake(162, zanNumLabel.bottom+10, 28, 12)];
        [inviteTextLabel setFont:kFontArial12];
        inviteTextLabel.textAlignment= NSTextAlignmentLeft;
        [inviteTextLabel setTextColor:COLOR1(0xb5, 0xca, 0xe7)];
        [view addSubview:inviteTextLabel];
        */
        //        lineImage1 = [[UIImageView alloc] init];
        //        lineImage1.backgroundColor = COLOR1(0x2f, 0x57, 0x86);
        //        [lineImage1 setFrame:CGRectMake(30, zanTextLabel.bottom+10, kScreenWidth-30, 0.8)];
        //        [view addSubview:lineImage1];
        view;
    });
    [self.view addSubview:centerTableView];
//    [self refreshData];
    
    _arData = @[@[@"我的关注", @"mycare.png"],
                @[@"我的提问", @"mymention.png"],
                @[@"我的回答", @"myanswer.png"],
                @[@"我的消息", @"mymessage.png"],
                @[@"口碑推荐", @"koubei.png"],
                @[@"设置", @"mysetting.png"]];
    
    //
    //    [self.view setBackgroundColor:[UIColor clearColor]];
    //
    //    float hHeight = 90;
    //    UIImageView *imageBgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height/4 + 10)];
    //    imageBgV.tag = 18;
    //    [imageBgV setBackgroundColor:COLOR(0x19, 0x46, 0x7a)];
    //    [self.view addSubview:imageBgV];
    //
    //
    //
    //    hHeight = imageBgV.bottom - 80;
    //    UIImageView *imageBgV2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, hHeight, self.view.width, self.view.height - hHeight)];
    //    imageBgV2.tag = 19;
    //    [imageBgV2 setBackgroundColor:COLOR(0x19, 0x46, 0x7a)];
    //    [self.view addSubview:imageBgV2];
    
    //    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    //    _contentView.backgroundColor = [UIColor clearColor];
    //    [self.view addSubview:_contentView];
    //    NSLog(@"%f", _contentView.layer.anchorPoint.x);
    //
    //    UIImageView *headerIV = [[UIImageView alloc] initWithFrame:CGRectMake(25, 60, 70, 70)];
    //    headerIV.layer.cornerRadius = headerIV.width/2;
    //    headerIV.tag = 20;
    //    [_contentView addSubview:headerIV];
    //
    //    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, imageBgV.bottom + 10, self.view.width, self.view.height - imageBgV.bottom - 80) style:UITableViewStylePlain];
    //    _tableView.dataSource = self;
    //    _tableView.delegate = self;
    //    [_tableView setBackgroundColor:[UIColor clearColor]];
    //    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    [_contentView addSubview:_tableView];
    
    [self reloadImage];
}
/*
-(NSDictionary *)personData{
    
    NSString *filePath = [self fileTextPath:@"personalInfo"];
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *personInfo = [unarchiver decodeObjectForKey:@"talkData"];
    [unarchiver finishDecoding];
    if(![self  isBlankDictionary:personInfo]){
       NSDictionary *accountDic = [personInfo objectForKey:@"account"];
        return accountDic;
    }
    return nil;
}

-(void)refreshData{

    NSDictionary *personInfo = [self personData];
  
    if([personInfo count]>0){
        
        NSString *userName = [NSString stringWithFormat:@"%@",[personInfo objectForKey:@"user_name"]];
        NSString *agree_count = [NSString stringWithFormat:@"%@",[personInfo objectForKey:@"agree_count"]];
        NSString *fans_count = [NSString stringWithFormat:@"%@",[personInfo objectForKey:@"fans_count"]];
        NSString *views_count = [NSString stringWithFormat:@"%@",[personInfo objectForKey:@"views_count"]];
        NSString *answerCount =[NSString stringWithFormat:@"%@",[personInfo objectForKey:@"answer_count"]];
        NSString *avatar_file =[NSString stringWithFormat:@"%@",[personInfo objectForKey:@"avatar_file"]];
        
        NSLog(@"avatar_file:   %@",avatar_file);
        
        [nameLabel setText:userName];
        [zanNumLabel setText:agree_count];
        [fansNumLabel setText:fans_count];
        [inviteNumLabel setText:views_count];
        [haveAnswerQuestionNum setText:[NSString stringWithFormat:@"已回答%@个问题",answerCount]];
        if(![self isBlankString:avatar_file]){
        
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *_avatarImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatar_file]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [avatarButton setImage:_avatarImg forState:UIControlStateNormal];
                    [[KVStoreManager sharedInstance] saveObj:_avatarImg forKey:avatar_file];
                });
            });
        }
        
//        [avatarButton sd_setImageWithURL: [NSURL URLWithString:avatar_file] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageRefreshCached ];
        [centerTableView reloadData];
    }else{
    
            [nameLabel setText:@"未登录"];
            [zanNumLabel setText:@"0"];
            [fansNumLabel setText:@"0"];
            [inviteNumLabel setText:@"0"];
            [haveAnswerQuestionNum setText:[NSString stringWithFormat:@"已回答   个问题"]];
            [avatarButton setImage:[UIImage imageNamed:@"pinkImage"] forState:UIControlStateNormal];
    }
    
}

-(void)logout{

    [nameLabel setText:@"未登录"];
    [zanNumLabel setText:@"0"];
    [fansNumLabel setText:@"0"];
    [inviteNumLabel setText:@"0"];
    [haveAnswerQuestionNum setText:[NSString stringWithFormat:@"已回答   个问题"]];
    [avatarButton setImage:[UIImage imageNamed:@"pinkImage"] forState:UIControlStateNormal];
    
//    if ([[UserAccountManager sharedInstance] isGuWenSelf]) {
//        _arData = @[@[@"我的关注", @"mycare.png"],
//                    @[@"我的提问", @"mymention.png"],
//                    @[@"我的回答", @"myanswer.png"],
//                    @[@"我的消息", @"mymessage.png"],
//                    @[@"口碑推荐", @"koubei.png"],
//                    @[@"设置", @"mysetting.png"]];
//        
//        [self refreshData];
//    }
}

-(void)loadNewDatas{
    
    if ([[UserAccountManager sharedInstance] isGuWenSelf]) {
        _arData = @[@[@"我的关注", @"mycare.png"],
                    @[@"我的回答", @"myanswer.png"],
                    @[@"我的消息", @"mymessage.png"],
                    @[@"口碑推荐", @"koubei.png"],
                    @[@"设置", @"mysetting.png"]];
    }
    else {
        _arData = @[@[@"我的关注", @"mycare.png"],
                    @[@"我的提问", @"mymention.png"],
                    @[@"我的回答", @"myanswer.png"],
                    @[@"我的消息", @"mymessage.png"],
                    @[@"口碑推荐", @"koubei.png"],
                    @[@"设置", @"mysetting.png"]];
    }
    
    [self refreshData];
    
    [self fetchPersonalList];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [self fetchPersonalList];
//    });
}


-(void)fetchPersonalList{

    NSString *userID = [self userIDs];
//    if([userID length]>0){
//        NSDictionary *tempDic = [NSDictionary dictionaryWithObject:userID forKey:@"uid"];
//    
//        [commonModel requestUserInfo:tempDic httpRequestSucceed:@selector(requestUserInfoSuccess:) httpRequestFailed:@selector(requestUserInfoFailed:)];
//    }else
//        [commonModel requestUserInfo:nil httpRequestSucceed:@selector(requestUserInfoSuccess:) httpRequestFailed:@selector(requestUserInfoFailed:)];
    
    if ([[self userToken] length] > 10) {
        
        AccountGetUserInfoApi *_accountGetUserInfoApi = [[AccountGetUserInfoApi alloc] initWithUserId:[self userToken]];
        
        [[SSLXNetworkManager sharedInstance] startApiWithRequest:_accountGetUserInfoApi successBlock:^(SSLXResultRequest *successRequest){
            
            NSDictionary *nsDic = [successRequest.responseString objectFromJSONString];//[super parseJsonRequest:request];
            NSDictionary *resultDic = [nsDic objectForKey:@"result"];
            NSDictionary *businessDataDic = [resultDic objectForKey:@"businessData"];
            if(![self isBlankDictionary:[businessDataDic objectForKey:@"user_info"]]){
                
                [[ConstObject instance] setUserInfoDics:[businessDataDic objectForKey:@"user_info"]];
                //        NSDictionary *userinfoDic = [NSDictionary dictionaryWithDictionary:[businessDataDic objectForKey:@"user_info"]];
                //        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                //        [userDefault setObject:userinfoDic forKey:kUserInfoDic];
                //        [userDefault synchronize];
            }else{
                
                [[ConstObject instance] setUserInfoDics:nil];
            }
            [self refreshData];
            
        } failureBlock:^(SSLXResultRequest *failRequest){
            [super hideMBProgressHUD];
            
            NSDictionary *_failDict = [failRequest.responseString objectFromJSONString];
            NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
            if (_errorMsg) {
                
                [MBProgressHUD showError:_errorMsg];
                
                //            UIAlertView *_alertView = [[UIAlertView alloc] initWithTitle:nil message:_errorMsg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                //            [_alertView show];
            }
            else {
                [MBProgressHUD showError:kMBProgressErrorTitle];
            }
        }];
    }
}

//-(void)requestUserInfoSuccess:(ASIHTTPRequest *)request{
//    
//    NSDictionary *nsDic = [super parseJsonRequest:request];
//    NSDictionary *resultDic = [nsDic objectForKey:@"result"];
//    NSDictionary *businessDataDic = [resultDic objectForKey:@"businessData"];
//    if(![self isBlankDictionary:[businessDataDic objectForKey:@"user_info"]]){
//        
//        [[ConstObject instance] setUserInfoDics:[businessDataDic objectForKey:@"user_info"]];
////        NSDictionary *userinfoDic = [NSDictionary dictionaryWithDictionary:[businessDataDic objectForKey:@"user_info"]];
////        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
////        [userDefault setObject:userinfoDic forKey:kUserInfoDic];
////        [userDefault synchronize];
//    }else{
//    
//        [[ConstObject instance] setUserInfoDics:nil];
//    }
//    [self refreshData];
//
//    
//}
*/
//-(void)requestUserInfoFailed:(ASIHTTPRequest *)request{
//    
////    NSDictionary *nsDic = [super parseJsonRequest:request];
////    NSDictionary *resultDic = [nsDic objectForKey:@"result"];
////    NSDictionary *businessDataDic = [resultDic objectForKey:@"businessData"];
//}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //设置状态栏字颜色为黑色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)viewDidAppear:(BOOL)animated {

//    [self loadNewDatas];
    
    [super viewDidAppear:animated];
}

- (void)backAction:(UIButton *)btn
{
    [[SliderViewController sharedSliderController] closeSideBar];
}

- (void)toNewViewbtn:(UIButton *)btn
{
    [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
     {
     }];
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex{
    return 14.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kScreenBounds.size.width, 14.0f)];
    sectionView.backgroundColor = [UIColor clearColor];
    return sectionView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdetify = @"left";
    
    LeftTableViewCell *leftTableViewCell = (LeftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    
    if (leftTableViewCell == nil)
    {
        leftTableViewCell = [[LeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        [leftTableViewCell setBackgroundColor:[UIColor whiteColor]];
        [leftTableViewCell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    NSArray *ar = [_arData safe_objectAtIndex:indexPath.row];
    //    leftTableViewCell.backgroundColor =COLOR(0x19, 0x46, 0x7a);
    leftTableViewCell.backgroundColor = [UIColor whiteColor];
    [leftTableViewCell.categoryImageView setImage:[UIImage imageNamed:[ar safe_objectAtIndex:1]]];
    [leftTableViewCell.myTitleLabel setText:[ar safe_objectAtIndex:0]];
    //    cell.imageView.image = [QHCommonUtil imageNamed:[ar objectAtIndex:1]];
    //    cell.textLabel.text = [ar objectAtIndex:0];
    //    cell.textLabel.textColor = COLOR(0xcd, 0xd3, 0xdd);
    return leftTableViewCell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row!=4){
    NSString *userToken = [self userToken];
    if(!([userToken length]>10)){
        //未登录
        [self deleteToken];
        [self toLoginPage];
        return;
    }
    }
    
    NSInteger _indexPathInt = indexPath.row;
    
    if ([[UserAccountManager sharedInstance] isGuWenSelf]) {
        
        if (_indexPathInt > 0) {
            _indexPathInt += 1;
        }
    }
    
    switch (_indexPathInt)
    {
        case 0:
        {
            [MobClick event:@"click_myattention"];
            MyCareViewController *myCareVC = [[MyCareViewController alloc] init];
            //            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
            //             {
//            [self backAction:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:myCareVC animated:YES];
            //             }];
            break;
        }
        case 1:
        {
            [MobClick event:@"click_myquestion"];
            MyMentionViewController *mentionVC = [[MyMentionViewController alloc] init];
            //            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
            //             {
//            [self backAction:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:mentionVC animated:YES];
            //             }];
            break;
        }
        case 2:
        {
            [MobClick event:@"click_myanswer"];
            MyAnswerViewController *myAnswerVC = [[MyAnswerViewController alloc] init];
            //            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
            //             {
//            [self backAction:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:myAnswerVC animated:YES];
            //             }];
            break;
        }
        case 3:
        {
            MyMessageViewController *messageVC = [[MyMessageViewController alloc] init];
            //            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
            //             {
//            [self backAction:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:messageVC animated:YES];
            //             }];
            break;
        }
        case 4:
        {
            AddressViewController *addressVc = [[AddressViewController alloc] init];
                [addressVc initWithUrl:kKeHuBao andTitle:@"口碑推荐"];
                [self.navigationController pushViewController:addressVc animated:YES];
//            KouBeiSuggestViewController *messageVC = [[KouBeiSuggestViewController alloc] init];
//            //            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
//            //             {
//            [self backAction:nil];
//            [[SliderViewController sharedSliderController].navigationController pushViewController:messageVC animated:YES];
            //             }];
            break;
        } case 5:
        {
            SettingViewController *messageVC = [[SettingViewController alloc] init];
            //            [[SliderViewController sharedSliderController] closeSideBarWithAnimate:YES complete:^(BOOL finished)
            //             {
//            [self backAction:nil];
            [[SliderViewController sharedSliderController].navigationController pushViewController:messageVC animated:YES];
            //             }];
            break;
        }
            
        default:
            [self backAction:nil];
            break;
    }
}

#pragma mark - super

- (void)reloadImage
{
    //    [super reloadImage];
    
    //    UIImageView *imageBgV = (UIImageView *)[self.view viewWithTag:18];
    //    UIImage *image = [QHCommonUtil imageNamed:@"sidebar_bg.jpg"];
    //    [imageBgV setImage:image];
    //
    //    UIImageView *imageBgV2 = (UIImageView *)[self.view viewWithTag:19];
    //    UIImage *image2 = [QHCommonUtil imageNamed:@"sidebar_bg_mask.png"];
    //    [imageBgV2 setImage:[image2 resizableImageWithCapInsets:UIEdgeInsetsMake(image2.size.height - 1, 0, 1, 0)]];
    //
    //    UIImageView *headerIV = (UIImageView *)[self.view viewWithTag:20];
    //    UIImage *headerI = [QHCommonUtil imageNamed:@"chat_bottom_smile_nor.png"];
    //    [headerIV setImage:headerI];
    //    [_tableView reloadData];
}

-(void)addObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadNewDatas) name:kRefreshLeftView object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toLoginPage) name:kPushLoginViewNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logout) name:kLogoutAccoutNotification object:nil];

}
//登录
-(void)toLoginPage{
    
    NSString *userToken = [self userToken];
    if(!([userToken length]>10)){
        LoginViewController *loginViewController = [[LoginViewController alloc] init];
        //    [self.navigationController pushViewController:loginViewController animated:YES];
//        [self.navigationController presentViewController:loginViewController animated:YES completion:nil];
        [[SliderViewController sharedSliderController].navigationController pushViewController:loginViewController animated:YES];
        
        return;
    }else{

        if ([self isGuWenSelf]) {
            SSAdviserDetailViewController *detailVc = [[SSAdviserDetailViewController alloc] init];
            detailVc.username = _user[@"user_name"];
            detailVc.userId = _user[@"uid"];
            [self.navigationController pushViewController:detailVc animated:YES];
        } else {
            PersonalViewController *personalViewController = [[PersonalViewController alloc] init];
            personalViewController.isMineOrHis = YES;
            [self.navigationController pushViewController:personalViewController animated:YES];
        }

    }
    //    [loginViewController release];
}

-(BOOL)isGuWenSelf{

    NSString *filePath = [self fileTextPath:@"personalInfo"];
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:filePath];

    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    NSDictionary *personInfo = [unarchiver decodeObjectForKey:@"talkData"];
    [unarchiver finishDecoding];
    if(![self  isBlankDictionary:personInfo]){
        NSDictionary *accountDic = [personInfo objectForKey:@"account"];
        _user = accountDic;
        NSString *user_type = [NSString stringWithFormat:@"%@",[accountDic objectForKey:@"user_type"]];
        if([self isBlankString:user_type]){

            return NO;
        }else {

            if([user_type isEqualToString:@"顾问"])
                return YES;
            return NO;

        }
    }
    return NO;
}


- (void)reloadImage:(NSNotificationCenter *)notif
{
    [self reloadImage];
}
 
 */

@end
