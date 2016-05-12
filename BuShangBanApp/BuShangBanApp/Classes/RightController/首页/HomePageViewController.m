//
//  HomePageViewController.m
//  ShunShunLiuXue
//
//  Created by Peter Lee on 15/8/10.
//  Copyright (c) 2015年 顺顺留学. All rights reserved.
//

#import "HomePageViewController.h"
#import "SliderViewController.h"
#import "MJRefresh.h"
#import <AVOSCloud/AVOSCloud.h>
#import "SuggestPageViewController.h"
#import "FMViewController.h"

@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_mainTableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_homeListdataArray;

    NSString *_ScreenshotsPickPath;
    FMViewController *_fmVC;
    int page;
}

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(249, 249, 249);

//    UIButton *fmBtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *image=[UIImage imageNamed:@"FM"];
//    [fmBtn setBackgroundImage:image forState:UIControlStateNormal];
//    [fmBtn addTarget:self action:@selector(showFM) forControlEvents:UIControlEventTouchUpInside];
//    [self customLeftItemWithBtn:fmBtn];
//    fmBtn.frame=CGRectMake(0, 0, image.size.width, image.size.height);
    
    [self customNavigationBarWithImage:@"logo"];
    UIButton *mentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mentionButton setFrame:CGRectMake(self.navView.width - 60, (self.navView.height - 40)/2, 60, 40)];
    [mentionButton setImage:[UIImage imageNamed:@"FrontCovers"] forState:UIControlStateNormal];
    [mentionButton addTarget:self action:@selector(presentSuggestView) forControlEvents:UIControlEventTouchUpInside];
    [self customRightItemWithBtn:mentionButton];
    
    [self initData];
    [self createTabelView];
    [self fetchData];
    
    [self fetchHomeListData];
}

-(void)showFM
{
    [UIView animateWithDuration:0.3 animations:^{
        if (!_fmVC) {
            _fmVC=[[FMViewController alloc]init];
            [self addChildViewController:_fmVC];
            _fmVC.view.frame=CGRectMake(0,64, kScreenWidth, 40);
            [self.view addSubview:_fmVC.view];
            _fmVC.view.alpha=0;
        }
        _fmVC.view.height=40.f;
        _fmVC.view.alpha=1;
    }];
}

-(void)initData{
     page = 1;
    _dataArray = [[NSMutableArray alloc] init];
    _homeListdataArray= [[NSMutableArray alloc] init];
}

-(void)createTabelView{
    CGFloat height = kScreenHeight - 64;
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, height) style:UITableViewStyleGrouped];
    
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.backgroundColor = COLOR(249, 249, 249);
    //设置下拉刷新回调
    [_mainTableView addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    [_mainTableView addGifFooterWithRefreshingTarget:self refreshingAction:@selector(requestDataMore)];
    
    [self.view addSubview:_mainTableView];

    UIImageView *lineImageView1 = [[UIImageView alloc] init];
    lineImageView1.backgroundColor = COLOR(0xd9, 0xd9, 0xd9);
    [lineImageView1 setFrame:CGRectMake(0, kScreenHeight-50, kScreenWidth, 1)];
    [self.view addSubview:lineImageView1];
    
}

-(void)loadNewData{
    
    page = 1;
    [self fetchData];
}

-(void)requestDataMore{
    
    page++;
    [self fetchData];
}


//https://leancloud.cn:443/1.1/classes/_Status?limit=10&&order=-createdAt&include=related_post&keys=-related_post.body

//https://leancloud.cn:443/1.1/classes/_Status?limit=10&&order=-createdAt&include=related_post,related_post.author&keys=-related_post.body

-(void)fetchHomeListData {

    // 请求
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    
    NSDictionary *_tempParam = @{@"bid":@"888888"};
    [_urlParamsReq setUrlString:@"https://leancloud.cn:443/1.1/classes/_Status?limit=100&&order=-createdAt&include=related_post,related_post.author,related_post.category&keys=-related_post.body"];
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        NSArray *_resultArray = [[_successInfo objectForKey:@"results"] safeArray];
        _homeListdataArray =[NSMutableArray arrayWithArray:_resultArray];
        
        [_mainTableView.header endRefreshing];
        [_mainTableView reloadData];
        
    } failureBlock:^(SSLXResultRequest *failReq){
        
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        if (_errorMsg) {
            [_mainTableView.header endRefreshing];
            [MBProgressHUD showError:_errorMsg];
            
        }
        else {
            [MBProgressHUD showError:kMBProgressErrorTitle];
            [_mainTableView.header endRefreshing];
        }
    }];

}

-(void)fetchData {
    
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq setUrlString:@"https://leancloud.cn:443/1.1/classes/Featured?limit=3&&order=-sort&"];
    
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        NSArray *_resultArray = [[_successInfo objectForKey:@"results"] safeArray];
        _dataArray =[NSMutableArray arrayWithArray:_resultArray];
        
        [_mainTableView.header endRefreshing];
        [_mainTableView reloadData];

    } failureBlock:^(SSLXResultRequest *failReq){
        
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        if (_errorMsg) {
            [_mainTableView.header endRefreshing];
            [MBProgressHUD showError:_errorMsg];
        }
        else {
            [MBProgressHUD showError:kMBProgressErrorTitle];
            [_mainTableView.header endRefreshing];
        }
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    else
        return [_homeListdataArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 40;
    }else{
        return 0.01;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 276*kScreenWidth/414;
    }else{
    
        return  [HomePageContentCell getCellHeight]-40;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        static NSString *cellIndentifier = @"HomeHeadViewCell";
        HomeHeadViewCell *cell = (HomeHeadViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HomeHeadViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }

        [cell setDataArray:_dataArray];
        [cell refreshUI];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.leftButtonActionBlock = ^{
            
            [self leftButtonAction];
        };
        
        cell.rightUpButtonActionBlock = ^{
            
            [self rightUpButtonAction];
        };
        
        cell.rightDownActionBlock = ^{
            
            [self rightDownAction];
        };

        return cell;
    }else{
    
        static NSString *cellIndentifier = @"HomePageContentCell";
        HomePageContentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HomePageContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        
        NSDictionary *tempDic = [[_homeListdataArray objectAtIndex:indexPath.row] safeDictionary];
        [cell setDataInfo:tempDic];
        [cell refreshUI];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
    
}

-(void)leftButtonAction{

    if(_dataArray.count>0){
    NSDictionary *dataDic = [[_dataArray objectAtIndex:0] safeDictionary];
    NSString *urlStr = [dataDic objectForKey:@"link"];
    BaseWebViewController *baseWebView = [[BaseWebViewController alloc] init];
    baseWebView.isTestWeb = NO;
    baseWebView.webUrl = urlStr;
    [[SliderViewController sharedSliderController].navigationController pushViewController:baseWebView animated:YES ];
    }
}

-(void)rightUpButtonAction{
    
    if(_dataArray.count>1){
        NSDictionary *dataDic = [[_dataArray objectAtIndex:1] safeDictionary];
        NSString *urlStr = [dataDic objectForKey:@"link"];
        BaseWebViewController *baseWebView = [[BaseWebViewController alloc] init];
        baseWebView.isTestWeb = NO;
        baseWebView.webUrl = urlStr;
        [[SliderViewController sharedSliderController].navigationController pushViewController:baseWebView animated:YES ];
    }
}

-(void)rightDownAction{
    
    if(_dataArray.count>2){
        NSDictionary *dataDic = [[_dataArray objectAtIndex:2] safeDictionary];
        NSString *urlStr = [dataDic objectForKey:@"link"];
        BaseWebViewController *baseWebView = [[BaseWebViewController alloc] init];
        baseWebView.isTestWeb = NO;
        baseWebView.webUrl = urlStr;
        [[SliderViewController sharedSliderController].navigationController pushViewController:baseWebView animated:YES ];
    }
}



#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [AVAnalytics event:@"homePageList_click"];
    NSDictionary *dataDic = [[_homeListdataArray objectAtIndex:indexPath.row] safeDictionary];
    NSString *urlStr = [[dataDic objectForKey:@"related_post"] objectForKey:@"link"];
    BaseWebViewController *baseWebView = [[BaseWebViewController alloc] init];
    baseWebView.isTestWeb = NO;
    baseWebView.webUrl = urlStr;
    baseWebView.dataDics = dataDic;
    baseWebView.objectID = [dataDic objectForKey:@"objectId"];
    [[SliderViewController sharedSliderController].navigationController pushViewController:baseWebView animated:YES ];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if(section == 1){
        UIView *_sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        [_sectionHeaderView setBackgroundColor:COLOR(249, 249, 249)];
        UIImageView *normalImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reading"]];

        [normalImageView setFrame:CGRectMake(kScreenWidth/2-124, 0, 248, 20)];
        [_sectionHeaderView addSubview:normalImageView];
        return _sectionHeaderView;

    }
    return nil;
}


-(void)presentSuggestView{
    
//    [self ScreenShot];
    SuggestPageViewController *suggestPageViewController = [[SuggestPageViewController alloc] init];
    [[SliderViewController sharedSliderController].navigationController presentViewController:suggestPageViewController animated:YES completion:nil];
}

-(void)ScreenShot{
    //这里因为我需要全屏接图所以直接改了，宏定义iPadWithd为1024，iPadHeight为768，
    //    UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), YES, 0);     //设置截屏大小
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(kScreenWidth, kScreenHeight), YES, 0);     //设置截屏大小
    [[self.view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    //    CGRect rect = CGRectMake(166, 211, 426, 320);//这里可以设置想要截图的区域
    CGRect rect = CGRectMake(0, 0, kScreenWidth, kScreenHeight);//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    UIImageWriteToSavedPhotosAlbum(sendImage, nil, nil, nil);//保存图片到照片库
    NSData *imageViewData = UIImagePNGRepresentation(sendImage);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pictureName= [NSString stringWithFormat:@"screenShow.png"];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    NSLog(@"截屏路径打印: %@", savedImagePath);

    NSFileManager *defaultManager;
    defaultManager = [NSFileManager defaultManager];
    
    [defaultManager removeItemAtPath:savedImagePath error:nil];
    
       //这里我将路径设置为一个全局String，这里做的不好，我自己是为了用而已，希望大家别这么写
    [self SetPickPath:savedImagePath];
    
    [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
    CGImageRelease(imageRefRect);
}

//设置路径
- (void)SetPickPath:(NSString *)PickImage {
    _ScreenshotsPickPath = PickImage;
}
//获取路径<这里我就直接用于邮件推送的代码中去了，能达到效果，但肯定有更好的写法>
- (NSString *)GetPickPath {
    return _ScreenshotsPickPath;
}


- (void)didReceiveMemoryWarning {
    // Dispose of any resources that can be recreated.
}
 
@end
