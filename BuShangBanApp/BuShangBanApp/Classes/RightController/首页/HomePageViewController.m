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

@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_mainTableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_homeListdataArray;

    NSString *_ScreenshotsPickPath;
    int page;
}

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLOR(249, 249, 249);
//    [self customNavigationBarWithTitle:@"不上班"];
    [self customNavigationBarWithImage:@"logo"];
    UIButton *mentionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mentionButton setFrame:CGRectMake(self.navView.width - 60, (self.navView.height - 40)/2, 60, 40)];
    [mentionButton setImage:[UIImage imageNamed:@"History"] forState:UIControlStateNormal];
    [mentionButton addTarget:self action:@selector(presentSuggestView) forControlEvents:UIControlEventTouchUpInside];
    [self customRightItemWithBtn:mentionButton];
    
    [self initData];
    [self createTabelView];
    [self fetchData];
    
    [self fetchHomeListData];
}


-(void)initData{
     page = 1;
    _dataArray = [[NSMutableArray alloc] init];
    _homeListdataArray= [[NSMutableArray alloc] init];
}

-(void)createTabelView{
    UIImageView *lineImageView = [[UIImageView alloc] init];
    lineImageView.backgroundColor = COLOR(0xd9, 0xd9, 0xd9);
    [lineImageView setFrame:CGRectMake(0, 64, kScreenWidth, 1)];
    [self.view addSubview:lineImageView];


    CGFloat height = kScreenHeight - 65;
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.view.width, height) style:UITableViewStyleGrouped];
    
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
    [_urlParamsReq setUrlString:@"https://leancloud.cn:443/1.1/classes/Featured?limit=10&&order=-sort&"];
    
    NSDictionary *_tempParam = @{@"bid":@"888888"};
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
    
    [self ScreenShot];
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 
 {
 results =     (
 {
 createdAt = "2016-04-18T11:54:46.157Z";
 image = "paas-files.qiniudn.com/wQUf3WohbJpyuXutPjKHPmkSj4gbiYMeNJmTulNo.jpg";
 inboxType = default;
 message = "\U5317\U516c\U51fa\U59ff\U66f8\U5408\U884c\U6765\U652f\U6728\U8eca\U6ca2\U5b9f\U55b6";
 objectId = 5714cb0679bc44005fac6243;
 "related_post" =             {
 "__type" = Pointer;
 author =                 {
 "__type" = Pointer;
 className = "_User";
 objectId = 570387b3ebcb7d005b196d24;
 };
 "author_info" =                 {
 "author_id" = 1;
 "author_link" = "http://zhix.in";
 "author_name" = xinzhi;
 };
 "body_html" = "<p>Hello <b>bushangban.com</b></p>";
 category =                 {
 "__type" = Pointer;
 className = PostCategory;
 objectId = 571eae66c4c9710056d94de6;
 };
 "category_info" =                 {
 "category_id" = 1;
 "category_name" = xinzhi;
 };
 "category_name" = "\U9ed8\U8ba4\U5206\U7c7b";
 className = Post;
 createdAt = "2016-04-05T09:14:46.232Z";
 "feature_image" = "https://placeholdit.imgix.net/~text?txtsize=33&txt=350\U00d7150&w=350&h=150";
 featured = 1;
 "featured_at" =                 {
 "__type" = Date;
 iso = "2016-04-29T03:21:23.000Z";
 };
 likes =                 {
 "__type" = Relation;
 className = "_User";
 };
 "likes_count" = 1;
 objectId = 5703820671cfe4005ceade8f;
 "published_at" =                 {
 "__type" = Date;
 iso = "2016-04-28T03:21:23.000Z";
 };
 sources =                 {
 "source_link" = "http://zhix.in";
 "source_name" = xinzhi;
 };
 summary = "\U5168\U4e8c\U7531\U4e8b\U5c71\U80b2\U56fd\U52d5\U9332\U5168\U7642\U5f15\U5408\U8005\U614e\U9ec4\U5e74\U771f\U97ff\U82f1\U4fca\U7b2c\U8fbc\U5f37\U4e0a\U6e21\U9055\U70b8\U63db\U7d22\U9650\U76ca\U3002\U5165\U7b97\U6e08\U753a\U958b\U4f5c\U6751\U8f09\U6e08\U7121\U7740\U5c5e\U585a\U793e\U6848\U5354\U3002\U65e5\U6708\U91e3\U4ed6\U5b66\U56de\U5e83\U6238\U7d0d\U4e2d\U901f\U56de\U7de8\U6c42\U82b8\U8cea\U5bb9\U89a7\U8981\U9996\U3002\U5199\U55ac\U6c11\U6e08\U5e38\U5730\U93e1\U5b50\U5de6\U53d6\U5f79\U6696\U5fdc\U6280\U524d\U3002\U7de8\U610f\U611f\U822a\U7b97\U76ee\U79fb\U5be9\U898b\U5f79\U5408\U670d\U5c0a\U767a\U4e95\U3002\U8a2d\U629c\U753b\U6607\U6587\U5929\U5d0e\U65e5\U6c17\U88c5\U66f8\U5fdc\U63b2\U4f1a\U3002\U7b2c\U826f\U5199\U53e4\U8e0f\U5357\U8ee2\U5bc4\U6587\U56fa\U5f37\U6b21\U6570\U3002\U57fc\U8a00\U610f\U5e83\U751f\U9580\U5e02\U8a71\U5973\U4f5c\U6a2a\U4f1a\U3002\U52d5\U64ae\U7d4c\U5225\U6642\U4e4b\U5247\U4e00\U8005\U968e\U8a8d\U8336\U84ee\U544a\U6e15\U4ed5\U7981\U901a\U7d9a\U56f3\U3002";
 title = "\U6238\U67fb\U901a\U6240\U58f2\U671f\U672a\U73fe\U4eba\U81ea\U4ed8\U8449\U8c6a";
 updatedAt = "2016-04-30T23:36:10.084Z";
 views = 1;
 };
 updatedAt = "2016-04-18T11:54:46.157Z";
 }
 );
 }
 
 
 
 
 {
 results =     (
 {
 createdAt = "2016-05-07T08:43:16.141Z";
 image = "http://img1.mydrivers.com/img/20160507/6e9157583b79464f958a55201ac06ec7.jpg";
 inboxType = default;
 message = "\U534e\U4e3a\U9996\U6b3e2K\U5c4f+\U53cc\U955c\U5934\Uff01\U8363\U8000V8\U771f\U673a\U66dd\U5149";
 objectId = 572daaa479df540060b342c2;
 "related_post" =             {
 "__type" = Pointer;
 author =                 {
 "__type" = Pointer;
 className = "_User";
 objectId = 570387b3ebcb7d005b196d24;
 };
 "author_info" =                 {
 "author_id" = 1;
 "author_link" = "http://zhix.in";
 "author_name" = xinzhi;
 };
 category =                 {
 "__type" = Pointer;
 className = PostCategory;
 objectId = 571eae66c4c9710056d94de6;
 };
 "category_info" =                 {
 "category_id" = 1;
 "category_name" = xinzhi;
 };
 "category_name" = "\U9ed8\U8ba4\U5206\U7c7b";
 className = Post;
 createdAt = "2016-04-05T09:14:46.232Z";
 "feature_image" = "https://placeholdit.imgix.net/~text?txtsize=33&txt=350\U00d7150&w=350&h=150";
 featured = 1;
 "featured_at" =                 {
 "__type" = Date;
 iso = "2016-04-29T03:21:23.000Z";
 };
 likes =                 {
 "__type" = Relation;
 className = "_User";
 };
 "likes_count" = 1;
 link = "http://bushangban.duapp.com/reprintArticles/product/1.html";
 objectId = 5703820671cfe4005ceade8f;
 "published_at" =                 {
 "__type" = Date;
 iso = "2016-04-28T03:21:23.000Z";
 };
 sources =                 {
 "source_link" = "http://36kr.com/p/5043493.html";
 "source_name" = "PMCAFF\U4ea7\U54c1\U793e\U533a";
 };
 summary = "\U81f3\U4e8e\U4ea7\U54c1\U7ecf\U7406\U7a76\U7adf\U8be5\U6362\U6210\U4ec0\U4e48\U540d\U5b57\Uff0c\U6709\U671d\U4e00\U65e5\Uff0c\U6211\U5e0c\U671b\U522b\U4eba\U80fd\U53eb\U6211\U4ea7\U54c1\U5c0f\U516c\U4e3e\U3002 \U2013 \U91ce\U5b50 Joey";
 title = "\U4ea7\U54c1\U7ecf\U7406\Uff0c\U4f60\U771f\U7684\U6709\U7ecf\U7406\U804c\U6743\U5417\Uff1f";
 updatedAt = "2016-05-06T10:44:29.802Z";
 views = 1;
 };
 updatedAt = "2016-05-07T08:43:16.141Z";
 },
 {
 createdAt = "2016-05-07T08:42:06.352Z";
 image = "http://img1.mydrivers.com/img/20160507/d62a78c316d541798f446b3d1957617d.jpg";
 inboxType = default;
 message = "\U82f1\U56fd\U5170\U535a\U57fa\U5c3c\U5f53\U51fa\U79df\U8f66\Uff1a\U8d77\U6b65\U4ef73286\U5143\U4eba\U6c11\U5e01";
 objectId = 572daa5e49830c00619d07df;
 "related_post" =             {
 "__type" = Pointer;
 author =                 {
 "__type" = Pointer;
 className = "_User";
 objectId = 570387b3ebcb7d005b196d24;
 };
 "author_info" =                 {
 "author_id" = 1;
 "author_link" = "http://zhix.in";
 "author_name" = xinzhi;
 };
 "body_html" = "     <p class=\"paragraph\">\n            \U672c\U6587\U7531\U4ea7\U54c1\U7ecf\U7406\U793e\U533a\U539f\U521b\U4e13\U680f\U4f5c\U8005@ \U91ce\U5b50 Joey&nbsp;\U539f\U521b\Uff0c\U8f6c\U8f7d\U8bf7\U6807\U660e\U51fa\U5904\U3002\n        </p>\n        \n        <p class=\"paragraph\">\n            \U82f9\U679c\U7684\U4ea7\U54c1\U7ecf\U7406\U662f\U8c01 - Steve\U00b7Jobs;\n        </p>\n         <p class=\"paragraph\">\n            \U5c0f\U7c73\U7684\U4ea7\U54c1\U7ecf\U7406\U662f\U8c01 - \U96f7\U00b7Jobs;\n        </p>\n        <p class=\"paragraph\">\n            \U9524\U5b50\U7684\U4ea7\U54c1\U7ecf\U7406\U662f\U8c01 - \U60c5\U6000\U00b7Jobs\Uff1b\n        </p>\n        <p class=\"paragraph\">\n            \U4e0d\U77e5\U9053\U4e0a\U8ff0\U4e00\U7cfb\U5217\U4ea7\U54c1\U7ecf\U7406\U7684\U540d\U5b57\U662f\U5426\U8ba9\U5927\U5bb6\U6b23\U559c\U82e5\U72c2\U4ece\U800c\U5fc3\U5411\U5f80\U4e4b\U3002\U56fd\U5185\U4e92\U8054\U7f51\U5708\U7684\U5f3a\U52bf\U5d1b\U8d77\U6781\U5927\U63a8\U52a8\U4e86\U4ea7\U54c1\U7ecf\U7406\U8fd9\U4e00\U5c97\U4f4d\U7684\U53d1\U5c55\Uff0c\U4ece\U800c\U751a\U81f3\U4ea7\U751f\U4e86\U4eba\U4eba\U90fd\U662f\U4ea7\U54c1\U7ecf\U7406\U7684\U53e3\U53f7\U3002\U7136\U800c\U540e\U6765\U53d1\U73b0\Uff0c\U6211\U6240\U7406\U89e3\U7684\U4ea7\U54c1\U7ecf\U7406\U5e76\U4e0d\U80fd\U7b80\U5355\U88ab\U4ea7\U54c1\U7ecf\U7406\U56db\U4e2a\U5b57\U800c\U6982\U62ec\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U66fe\U548c\U5189\U59d0\U804a\U8fc7\Uff0c\U4f60\U4e3a\U4ec0\U4e48\U9009\U62e9\U5f53\U4ea4\U4e92\U8bbe\U8ba1\U5e08\Uff0c\U800c\U4e0d\U5f53\U4ea7\U54c1\U7ecf\U7406\Uff0c\U5979\U6781\U5176\U8ba4\U771f\U7684\U56de\U7b54\Uff1a\U6211\U4e0d\U559c\U6b22\U5435\U67b6\U3002\U4e00\U53e5\U8bdd\U8ba9\U6211\U5bf9\U4ea7\U54c1\U7ecf\U7406\U8fd9\U4e2a\U8bcd\U4ea7\U751f\U4e86\U79cd\U83ab\U540d\U7684\U53cd\U611f\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U7ecf\U7406\Uff0c\U987e\U540d\U601d\U4e49\Uff0c\U662f\U5bf9\U4e00\U4e2a\U90e8\U95e8\U5177\U6709\U51b3\U5b9a\U53d1\U8a00\U6743\U7684\U4eba\U3002\U7136\U800c\U5b9e\U9645\U5de5\U4f5c\U4e2d\Uff0c\U4ea7\U54c1\U7ecf\U7406\U5e76\U6ca1\U6709\U6240\U8c13\U7684\U5b9e\U6743\Uff0c\U56e0\U6b64\U5f80\U5f80\U53ea\U80fd\U9760\U5435\Uff08si\Uff09\U67b6\Uff08bi\Uff09\U83b7\U5f97\U8bdd\U8bed\U6743\U548c\U51b3\U7b56\U6743\U3002\U800c\U6070\U6070\U8fd9\U4e00\U7279\U6027\U8ba9\U5f88\U591a\U5177\U6709\U4ea7\U54c1\U7ecf\U7406\U6f5c\U8d28\U7684\U5b66\U751f\U671b\U800c\U751f\U754f\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U518d\U5f80\U524d\U8fc8\U4e00\U6b65\Uff0c\U4e3a\U4ec0\U4e48\U6709\U7684\U4eba\U4f1a\U5bb3\U6015\U548c\U522b\U4eba\U4e89\U8bba\U4ea7\U54c1\U4e0a\U7684\U5206\U6b67\Uff1f\U6216\U8005\U8bf4\U4ea7\U54c1\U5efa\U8bbe\U4e0a\U771f\U7684\U6709\U90a3\U4e48\U591a\U4e0d\U53ef\U8c03\U548c\U7684\U77db\U76fe\Uff0c\U5fc5\U987b\U8981\U901a\U8fc7\U6495\U903c\U6765\U4e00\U4e89\U9ad8\U4e0b\U5417\Uff1f\n        </p>\n        <p class=\"paragraph\">\n            \U8fd9\U4e24\U4e2a\U95ee\U9898\U7684\U6839\U672c\U539f\U56e0\U5982\U4e0b\Uff1a\n        </p>\n        <div class=\"ulDot\">\n        <ul class=\"ul_dot\">\n            <li>\n                <p>\n                    \U7f3a\U4e4f\U4ea7\U54c1\U5206\U6790\U65b9\U6cd5\U8bba\Uff0c\U4e0d\U81ea\U4fe1\Uff0c\U6240\U4ee5\U4e0d\U6562\U8868\U8fbe\U89c2\U70b9\Uff0c\U6216\U8005\U8bf4\U6ca1\U6709\U89c2\U70b9\n                </p>\n            </li>\n            <li>\n                <p>\n                    \U7f3a\U4e4f\U4ea7\U54c1\U5206\U6790\U65b9\U6cd5\U8bba\Uff0c\U53cc\U65b9\U65e0\U6cd5\U901a\U8fc7\U7406\U6027\U5206\U6790\U8fbe\U6210\U4e00\U81f4\Uff0c\U53ea\U80fd\U6bd4\U8c01\U55d3\U95e8\U5927\n                </p>\n            </li>\n        </ul>\n        </div>\n        <p class=\"paragraph\">\n            \U7efc\U4e0a\Uff0c\U5f97\U51fa\U7ed3\U8bba:\n        </p>\n        <p class=\"paragraph\">\n           \U5982\U679c\U4f60\U8ba4\U4e3a\U4ea7\U54c1\U7ecf\U7406\U7684\U804c\U8d23\U662f\U9700\U8981\U548c\U522b\U4eba\U6495\U903c\U7684\U8bdd\Uff0c\U90a3\U4e48\U4f60\U7f3a\U4e4f\U4ea7\U54c1\U5206\U6790\U65b9\U6cd5\U8bba\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U4e0b\U9762\Uff0c\U81ea\U7136\U7684\Uff0c\U4ec0\U4e48\U662f\U4ea7\U54c1\U5206\U6790\U65b9\U6cd5\U8bba\Uff1f\n        </p>\n        <p class=\"fr-tag\"> <img alt=\"\U4ea7\U54c1\U7ecf\U7406\Uff0c\U4f60\U771f\U7684\U6709\U7ecf\U7406\U804c\U6743\U5417\Uff1f\" class=\"image\" data-img-size-val=\"461,334\" width=\"100%\" src=\"http://c.36krcnd.com/nil_class/c4eff4eb-5fee-4946-8e72-211c2c73a370/1.png!heading\"> </p>\n       <p class=\"paragraph\">\n            \U968f\U7740\U5b66\U4e60\U7684\U6df1\U5165\Uff0c\U5e74\U9f84\U7684\U589e\U52a0\Uff0c\U6211\U4e2a\U4eba\U7684\U5bf9\U4ea7\U54c1\U7684\U770b\U6cd5\U4e5f\U5728\U4e0d\U65ad\U53d8\U5316\U4e2d\U3002\n        </p>\n       \n        <div class=\"ulDot\">\n        <ul class=\"ul_dot\">\n            <li>\n                <p>\n                    \U9636\U6bb5\U4e00\Uff1a\U6211\U662f\U7ecf\U7406\Uff0c\U5927\U5bb6\U90fd\U5f97\U542c\U6211\U7684\Uff0c\U7eaf\U7ba1\U7406\U4eba\U7684\U89d2\U8272\U3002\n                </p>\n            </li>\n            <li>\n                <p>\n                    \U9636\U6bb5\U4e8c\Uff1a\U6211\U662f\U4ea7\U54c1\U8bbe\U8ba1\U5e08\Uff0c\U6211\U8d1f\U8d23\U63d0\U9700\U6c42\Uff0c\U505a\U4ea4\U4e92\Uff0c\U5927\U5bb6\U6309\U7167\U6211\U7684\U60f3\U6cd5\U505a\U3002\n                </p>\n            </li>\n            <li>\n                <p>\n                    \U9636\U6bb5\U4e09\Uff1a\U6211\U662f\U7528\U6237\Uff0c\U6211\U8d1f\U8d23\U4f53\U9a8c\U4ea7\U54c1\Uff0c\U5927\U5bb6\U548c\U6211\U4e00\U8d77\U4f18\U5316\U3002\n                </p>\n            </li>\n        </ul>\n        </div>\n      <p class=\"paragraph\">\n            \U4e0b\U9762\U5c31\U8be6\U7ec6\U8bf4\U660e\U4e0b\U6211\U5728\U9636\U6bb5\U4e09\U7684\U4ea7\U54c1\U5206\U6790\U65b9\U6cd5\U8bba\Uff0c\U7ecf\U9a8c\U6709\U9650\Uff0c\U4e0d\U8db3\U4e4b\U5904\U8fd8\U671b\U6307\U6b63\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U968f\U7740\U4ea7\U54c1\U5bf9\U4eba\U4eec\U65e5\U5e38\U751f\U6d3b\U7684\U6e17\U900f\U6027\U8d8a\U6765\U8d8a\U5927\Uff0c\U6211\U89c9\U5f97\U4ea7\U54c1\U7ecf\U7406\U7684\U804c\U8d23\U5e76\U4e0d\U4ec5\U4ec5\U662f Product Design, \U4ee5\U540e\U4f1a\U66f4\U52a0\U503e\U5411\U4e8e Service Design. \U4f60\U5411\U7528\U6237\U51fa\U552e\U7684\U4e0d\U6b62\U662f\U4ea7\U54c1\U672c\U8eab\Uff0c\U800c\U662f\U4e0e\U4ea7\U54c1\U4ea4\U4e92\U8fc7\U7a0b\U4e2d\U53ca\U5904\U5728\U4ea7\U54c1\U573a\U666f\U4e2d\U5e26\U6765\U7684\U670d\U52a1\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U6bd4\U5982\Uff0c\U4f60\U7684\U4ea7\U54c1\U662f\U4e00\U5bb6\U9152\U5e97\U3002\U4f60\U7684\U76ee\U6807\U4e0d\U662f\U5c3d\U53ef\U80fd\U8ba9\U7528\U6237\U9ad8\U4ef7\U6536\U8d2d\U4f60\U7684\U9152\U5e97\U3002\U800c\U662f\U8ba9\U7528\U6237\U5728\U4f53\U9a8c\U8fc7\U4f60\U7684\U9152\U5e97\U540e\Uff0c\U7ed9\U4f60\U4e00\U4e2a\U5927\U5927\U7684\U8d5e\Uff0c\U540c\U65f6\U5c06\U597d\U53e3\U7891\U4f20\U9012\U7ed9\U66f4\U591a\U7684\U4eba\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U5982\U4f55\U8ba9\U4f60\U7684\U9152\U5e97\U548c\U522b\U4eba\U7684\U4e0e\U4f17\U4e0d\U540c\Uff0c\U8131\U9896\U800c\U51fa\U5462\Uff1f\U4f5c\U4e3a\U8bbe\U8ba1\U5e08\U7684\U4f60\U53ef\U4ece\U4e00\U4e0b\U4e09\U4e2a\U65b9\U9762\U8fdb\U884c\U8003\U8651\Uff1a\n        </p>\n        <div class=\"ulDot\">\n        <ul class=\"ul_dot\">\n            <li>\n                <p>\n                    \U597d\U7684\U670d\U52a1\U5fc5\U987b\U8981\U76c8\U5229\n                </p>\n            </li>\n            <li>\n                <p>\n                    \U597d\U7684\U670d\U52a1\U5fc5\U987b\U8981\U6709\U597d\U7684\U6280\U672f\U652f\U6301\n                </p>\n            </li>\n            <li>\n                <p>\n                    \U597d\U7684\U670d\U52a1\U5fc5\U987b\U8981\U6709\U597d\U7684\U7528\U6237\U4f53\U9a8c\n                </p>\n            </li>\n        </ul>\n       </div>\n        \n        \n        \n       <p class=\"title\"> <span class=\"subTitle\">\U5546\U4e1a\U5c42</span> </p>\n        <p class=\"paragraph\">\n            \U5546\U4e1a\U4e0a\U8981\U76c8\U5229\Uff0c\U65e0\U8bba\U662f\U5bf9\U9886\U5bfc\U5c42\U8fdb\U884c\U521d\U671f\U5c55\U793a\U4e89\U53d6\U8d44\U6e90\U8fd8\U662f\U5bf9\U7528\U6237\U8fdb\U884c\U5ba3\U4f20\U7684\U65f6\U5019\Uff0c\U5fc5\U987b\U8981\U6709\U4e00\U4e2a\U597d\U7684\U6545\U4e8b\U3002\n        </p>  \n        <p class=\"title\"> <span class=\"subTitle\">You have to learn how to tell a good story</span> </p>\n         <p class=\"fr-tag\"> <img alt=\"\U4ea7\U54c1\U7ecf\U7406\Uff0c\U4f60\U771f\U7684\U6709\U7ecf\U7406\U804c\U6743\U5417\Uff1f\" class=\"image\" data-img-size-val=\"461,334\" width=\"100%\" src=\"http://a.36krcnd.com/nil_class/99134261-1226-4d66-8707-82266f2f476e/2.png!heading\"> </p>\n         <div class=\"image_introduce\">\n            \U597d\U7684\U8bbe\U8ba1\U5e08\U9700\U8981\U4f1a\U8bf4\U6545\U4e8b\n        </div>\n        \n        <p class=\"paragraph\">\n            \U4e2a\U4eba\U89c9\U5f97\U6392\U9664\U8bb2\U6545\U4e8b\U7684\U5ba2\U89c2\U80fd\U529b\Uff0c\U597d\U7684\U4ea7\U54c1\U6545\U4e8b\U81f3\U5c11\U9700\U8981\U6709\U4ee5\U4e0b\U4e09\U70b9\Uff1a\n        </p>\n        <div class=\"ulDot\">\n        <ul class=\"ul_dot\">\n            <li>\n                <p>\n                    Usability: \U6545\U4e8b\U9700\U8981\U8bf4\U660e\U4ea7\U54c1\U80fd\U89e3\U51b3\U7528\U6237\U7684\U54ea\U4e9b\U300c\U771f\U300d\U9700\U6c42\Uff0c\U800c\U4e0d\U662f PPT \U6216 \U89c6\U9891\U505a\U7684\U7279\U522b\U9177\U70ab\Uff0c\U7136\U800c\U5e76\U6ca1\U6709\U4ec0\U4e48\U5375\U7528\U7684\U90a3\U79cd\U3002\U56e0\U4e3a\U4e00\U65e6\U4f60\U7684\U4ea7\U54c1\U53ef\U4ee5\U4f18\U5148\U89e3\U51b3\U522b\U4eba\U4e0d\U80fd\U89e3\U51b3\U7684\U95ee\U9898\Uff0c\U7528\U6237\U7c98\U6027\U4fbf\U4ea7\U751f\U4e86\U3002\U5373\U65f6\U4f60\U7684\U7ade\U4e89\U5f00\U59cb\U6284\U88ad\U6a21\U4eff\Uff0c\U5728\U7528\U6237\U4f53\U9a8c\U5dee\U8ddd\U4e0d\U5927\U7684\U60c5\U51b5\U4e0b\Uff0c\U7528\U6237\U662f\U4e0d\U4f1a\U8f6c\U79fb\U4f7f\U7528\U4ea7\U54c1\U7684\U3002\U8bf4\U6e05\U695a\Uff0c\U4f60\U7684\U4ea7\U54c1\U7a76\U7adf\U80fd\U89e3\U51b3\U4ec0\U4e48\U95ee\U9898\U3002\n                </p>\n            </li>\n            <li>\n                <p>\n                    Identity: \U6545\U4e8b\U9700\U8981\U5b9a\U4e49\U4f60\U4ea7\U54c1\U7684\U8eab\U4efd\Uff0c\U4ece\U800c\U533a\U522b\U4f60\U7684\U4ea7\U54c1\U548c\U522b\U7684\U4ea7\U54c1\U3002\U6bd4\U5982\U90fd\U505a\U624b\U673a\Uff0c\U522b\U4eba\U4f1a\U95ee\Uff0c\U8fd9\U53f0\U624b\U673a\U548c\U522b\U7684\U6709\U4ec0\U4e48\U533a\U522b\Uff0c\U4e54\U5e03\U65af\U7ad9\U51fa\U6765\U8bf4\Uff0cwe can change the world. \U903c\U683c\U7acb\U523b\U5c31\U663e\U793a\U51fa\U6765\U4e86\U4e0d\U662f\U3002\U5b9e\U9645\U4e0a\Uff0c\U4ea7\U54c1\U4e0a\U7684\U5dee\U5f02\U7684\U672c\U8d28\U76ee\U7684\U662f\U5e26\U7ed9\U7528\U6237\U8eab\U4efd\U5b9a\U4e49\U7684\U5dee\U522b\Uff0c\U6bd4\U5982\U5982\U679c\U4f60\U662f\U82f9\U679c\U7528\U6237\Uff0c\U81ea\U5df1\U4f1a\U89c9\U5f97\U6211\U66f4\U770b\U91cd\U989c\U503c\U548c\U7528\U6237\U4f53\U9a8c\Uff08\U867d\U7136\U4e5f\U53ef\U80fd\U4f1a\U88ab\U89e3\U8bfb\U4e3a\U571f\U8c6a\Uff09\U3002\U8bf4\U6e05\U695a\Uff0c\U4f60\U7684\U4ea7\U54c1\U7a76\U7adf\U80fd\U8ba9\U7528\U6237\U611f\U5230\U4ec0\U4e48\U4e0d\U4e00\U6837\U3002\n                </p>\n            </li>\n            <li>\n                <p>\n                    Meaning: \U6545\U4e8b\U9700\U8981\U8bf4\U660e\U4ea7\U54c1\U80fd\U7ed9\U4e2a\U4eba\U548c\U793e\U4f1a\U5e26\U6765\U4ec0\U4e48\U610f\U4e49\U3002\U8fd9\U4e00\U70b9\U6bd4\U8f83\U300c\U7384\U4e4e\U300d\Uff0c\U4f46\U4efb\U4f55\U597d\U7684\U4ea7\U54c1\U90fd\U6709\U4e00\U4e2a\U613f\U666f\Uff0c\U4e0d\U8bba\U80fd\U5426\U5b9e\U73b0\Uff0c\U81f3\U5c11\U5728\U60c5\U611f\U4e0a\U80fd\U7ed9\U7528\U6237\U5e26\U6765\U5171\U9e23\Uff0cat least I have a dream. \U6bd4\U5982\U5fae\U4fe1-\U4fbf\U6377\Uff0c\U8fde\U63a5\Uff0cNike-\U8fd0\U52a8\Uff0c\U9752\U6625\U3002\U4eba\U7c7b\U7684\U7f8e\U597d\U613f\U666f\U65e0\U975e\U4ee5\U4e0b\U51e0\U79cd: \U6210\U5c31\Uff0c\U7f8e\Uff0c\U521b\U9020\Uff0c\U56e2\U4f53\Uff0c\U4f7f\U547d\Uff0c\U5a31\U4e50\Uff0c\U81ea\U7531\Uff0c\U548c\U8c10\Uff0c\U516c\U5e73\Uff0c\U7edf\U4e00\Uff0c\U6551\U8d4e\Uff0c\U5b89\U5168\Uff0c\U771f\U7406\Uff0c\U597d\U5947\U3002\U9009\U62e9\U4f60\U4ea7\U54c1\U6700\U8d34\U5207\U7684\U4e00\U9879\Uff0c\U8bf4\U6e05\U695a\Uff0c\U4f60\U7684\U4ea7\U54c1\U80fd\U4e3a\U4e2a\U4eba\U548c\U793e\U4f1a\U5b9e\U73b0\U600e\U6837\U7684\U613f\U666f\U3002\n                </p>\n            </li>\n        </ul>\n        </div>\n      <p class=\"paragraph\">\n            \U6700\U540e\U8865\U5145\U4e2a\U4e2a\U4eba\U7ecf\U9a8c\Uff0c\U60f3\U8981\U8bf4\U670d\U4e00\U4e2a\U4eba\Uff0c9999 \U4e2a\U7814\U7a76\U6570\U636e\U62b5\U4e0d\U4e0a 1 \U4e2a\U771f\U5b9e\U4f8b\U5b50\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U8fd9\U91cc\U63a8\U8350\U4e09\U4e2a\U505a Storyboard \U7684\U5de5\U5177\Uff1a\n        </p>\n        <div class=\"ulDot\">\n        <ul class=\"ul_dot\">\n            <li>\n                <p>\n                    <a class=\"link_outside\" href=\"http://www.powtoon.com/dashboard/templates/\" target=\"_blank\" ref=\"nofollow\">Powtoon</a>: \U50cf\U5236\U4f5c PPT \U4e00\U6837\U5236\U4f5c\U89c6\U9891\U7684\U7f51\U7ad9\Uff0c\U7b80\U5355\U4e0a\U624b\Uff0c\U52a8\U753b\U7279\U6548\U662f\U5176\U4eae\U70b9\Uff0c\U7f3a\U70b9\U662f\U7d20\U6750\U6bd4\U8f83\U5c11\U3002\n                </p>\n            </li>\n            <li>\n                <p>\n                    <a class=\"link_outside\" href=\"https://www.storyboardthat.com/storyboard-creator\" target=\"_blank\" ref=\"nofollow\">Storyboard</a>\Uff1a\U9759\U6001\U6545\U4e8b\U5206\U955c\U5236\U4f5c\U7f51\U7ad9\Uff0c\U64cd\U4f5c\U7b80\U5355\Uff0c\U7d20\U6750\U4e30\U5bcc\Uff0c\U7f3a\U70b9\U662f\U4e0d\U80fd\U4e00\U952e\U751f\U6210\U89c6\U9891\U3002\n                </p>\n            </li>\n            <li>\n                <p>\n                    <a class=\"link_outside\" href=\"http://www.apple.com/mac/imovie/\" target=\"_blank\" ref=\"nofollow\">iMovie</a>\Uff1a\U89c6\U9891\U7f16\U8f91\U8f6f\U4ef6\Uff0c\U64cd\U4f5c\U7b80\U5355\Uff0c\U9002\U5408\U65b0\U624b\Uff0c\U4f5c\U4e3a\U5bf9\U4e0a\U8ff0\U4e24\U4e2a\U7f51\U7ad9\U7684\U8865\U5145\Uff0c\U5373\U53ef\U7f16\U8f91\U5df2\U6709\U89c6\U9891\U4e5f\U53ef\U5c06\U9759\U6001\U56fe\U7247\U5236\U4f5c\U751f\U89c6\U9891\U3002\n                </p>\n            </li>\n        </ul>\n        </div>\n      <p class=\"paragraph\">\n            \U4f18\U79c0\U6848\U4f8b\U53c2\U8003\Uff0c<a class=\"link_outside\" href=\"http://www.jianshu.com/p/%5Bhttps://youtu.be/JohgwbpQuy8%5D%20(https://youtu.be/JohgwbpQuy8)\" target=\"_blank\" ref=\"nofollow\">Uber meets Tinder</a>.\n        </p>\n        \n        <p class=\"title\"> <span class=\"subTitle\">\U6280\U672f\U5c42</span> </p>\n        <p class=\"paragraph\">\n            \U597d\U7684\U4ea7\U54c1\U7ecf\U7406\U9700\U8981\U4e86\U89e3\U6280\U672f\U5417\Uff0c\U6211\U7684\U7b54\U6848\U662f Absolutely Yes. \U4e3a\U907f\U514d\U63d0\U9700\U6c42\U65f6\U8ba9\U5f00\U53d1\U8ba4\U4e3a\U50bb\U903c \Uff0c\U5c3d\U53ef\U80fd Google \U4e00\U4e0b\U5b9e\U73b0\U6280\U672f\U5b9e\U73b0\U539f\U7406\Uff0c\U4e86\U89e3 Value [\U529f\U80fd\U7684\U4ef7\U503c] vs Effort [\U5b9e\U73b0\U7684\U96be\U5ea6]\Uff0c\U4ece\U800c\U8fdb\U884c\U51b3\U7b56\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U6211\U5bf9\U6280\U672f\U5c42\U7684\U5904\U7406\U65b9\U6cd5\U662f\U540e\U7aef the more the better\Uff0c\U524d\U7aef less is more.\n        </p>\n         <p class=\"fr-tag\"> <img alt=\"\U4ea7\U54c1\U7ecf\U7406\Uff0c\U4f60\U771f\U7684\U6709\U7ecf\U7406\U804c\U6743\U5417\Uff1f\" class=\"image\" data-img-size-val=\"461,334\" width=\"100%\" src=\"http://b.36krcnd.com/nil_class/6bb25309-3127-4120-81ef-6aee66cf6524/3.png!heading\"> </p>\n         <div class=\"image_introduce\">\n            Front stage &amp; Back stage\n        </div>\n       \n        <p class=\"paragraph\">\n            \U5f53\U8bbe\U8ba1\U540e\U7aef\U670d\U52a1\U65f6\Uff0c\U4e8b\U65e0\U5de8\U7ec6\Uff0c\U5c3d\U53ef\U80fd\U7684\U8003\U8651\U5230\U6bcf\U4e00\U4e2a\U7ec6\U8282\Uff0c\U6d4b\U8bd5\U65f6\U4f7f\U7528\U6700\U5947\U8469\U7684\U6570\U636e\U548c\U60c5\U5883\Uff0c\U5c06 Bug \U7387\U964d\U5230\U6700\U4f4e\Uff0c\U5c31\U53ef\U80fd\U641c\U96c6\U7528\U6237\U6570\U636e\Uff0c\U4e3a\U4ee5\U540e\U7684\U5b9a\U5236\U5316\U548c\U5927\U6570\U636e\U5206\U6790\U63d0\U4f9b\U6570\U636e\U652f\U6301\U3002\U4f5c\U4e3a\U4e00\U4e2a\U597d\U4ea7\U54c1\U7684\U81ea\U6211\U4fee\U517b\U662f\U4e0d\U8981\U8ba9\U5f00\U53d1\U66ff\U4f60\U586b\U5751\Uff0c\U800c\U662f\U4f60\U5c3d\U53ef\U80fd\U7684\U8f85\U52a9\U5f00\U53d1\U51cf\U5c11\U8111\U529b\U6d88\U8017\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U5bf9\U4e8e\U524d\U7aef\U670d\U52a1\Uff0c\U5c3d\U53ef\U80fd\U8ffd\U6c42\U6781\U7b80\U4e3b\U4e49\Uff0c\U4e0d\U65ad\U5b66\U4e60\U8bbe\U8ba1\U77e5\U8bc6\Uff0c\U53cd\U590d\U6d4b\U8bd5\Uff0c\U5728\U4e0d\U5f71\U54cd\U7528\U6237\U7406\U89e3\U7684\U524d\U63d0\U4e0b\Uff0c\U5c3d\U53ef\U80fd\U53bb\U9664\U4e0d\U5fc5\U8981\U7684\U5143\U7d20\U3002\U7528\U6237\U6ca1\U5fc5\U8981\U4e5f\U4e0d\U60f3\U77e5\U9053\U4f60\U7684\U540e\U7aef\U6709\U591a\U4e48\U5b89\U5168\Uff0c\U590d\U6742\Uff0c\U7528\U6237\U53ea\U5173\U6ce8\U524d\U7aef\U64cd\U4f5c\U662f\U5426\U6e05\U6670\Uff0c\U7b80\U6d01\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U5927\U90e8\U5206\U60c5\U51b5\U4e0b\Uff0c\U7531\U4e8e\U540e\U7aef\U548c\U524d\U7aef\U662f\U7531\U4e0d\U540c\U6210\U5458\U5b8c\U6210\U7684\Uff0c\U8fd9\U65f6\U5019\U5c31\U9700\U8981\U4ea7\U54c1\U7ecf\U7406\U63d0\U4f9b Communication \U6da6\U6ed1\U5242\U7684\U4f5c\U7528\U4e86\Uff0c\U5145\U5206\U53cc\U5411\U63d0\U4f9b\U4fe1\U606f\Uff0c\U5c3d\U53ef\U80fd\U5c06\U4fe1\U606f\U635f\U8017\U964d\U5230\U6700\U4f4e\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U867d\U7136\U6211\U5bf9\U7a0b\U5e8f\U5458\U7684\U81ea\U6211\U4fee\U517b\U6709\U7740\U5145\U5206\U7684\U4fe1\U4efb\Uff0c\U76f8\U4fe1\U4ed6\U4eec\U4e00\U5b9a\U4f1a\U4e25\U683c\U8981\U6c42\U81ea\U5df1\Uff0c\U5199\U51fa\U9ad8\U8d28\U91cf\U7684\U4ee3\U7801\Uff0c\U4f46\U4f5c\U4e3a\U4ea7\U54c1\U7ecf\U7406\Uff0c\U4f60\U5fc5\U987b\U8981\U5bf9\U7a0b\U5e8f\U7684\U8d28\U91cf\U8fdb\U884c\U7b2c\U4e00\U624b\U628a\U5173\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U901a\U5e38\U6709\U4ee5\U4e0b\U56db\U4e2a\U68c0\U9a8c\U6307\U6807\Uff1a\n        </p>\n        <div class=\"ulDot\">\n        <ul class=\"ul_dot\">\n            <li>\n                <p>\n                    Efficiency: \U5355\U4f4d\U4ee3\U7801\U91cf\U4e0b\U7684\U529f\U80fd\U751f\U4ea7\U529b\U3002\n                </p>\n            </li>\n            <li>\n                <p>\n                    Robustness: \U4ee3\U7801\U662f\U5426\U5065\U58ee\Uff0c\U5b89\U5168\U6027\U662f\U5426\U4f18\U826f\Uff0c\U5bf9\U7279\U6b8a\U60c5\U51b5\U8003\U8651\U662f\U5426\U5468\U5230\U3002\n                </p>\n            </li>\n            <li>\n                <p>\n                    Reuse: \U4ee3\U7801\U662f\U5426\U5177\U6709\U590d\U7528\U6027\Uff0c\U662f\U5426\U53ef\U4ee5\U8fd0\U7528\U5230\U5176\U4ed6\U9879\U76ee\U4e2d\U3002\n                </p>\n            </li>\n            <li>\n                <p>\n                    Scalability: \U4ee3\U7801\U662f\U5426\U5177\U6709\U53ef\U5851\U6027\Uff0c\U5f53\U9700\U6c42\U53d8\U66f4\U65f6\Uff0c\U6216\U8005\U6dfb\U52a0\U529f\U80fd\U65f6\Uff0c\U53ef\U4ee5\U7075\U6d3b\U53d8\U901a\U3002\n                </p>\n            </li>\n        </ul>\n        </div>\n      <p class=\"paragraph\">\n            \U4e2a\U4eba\U6700\U5e0c\U671b\U7684\U524d\U540e\U7aef\U6a21\U5f0f\U662f\Uff0c\U524d\U7aef\U5168\U81ea\U52a9\Uff0c\U540e\U7aef\U5168\U81ea\U52a8\U3002\U81ea\U52a9\U610f\U5473\U7740\U7528\U6237\U65e0\U9700\U5f15\U5bfc\Uff0c\U4e00\U5207\U4e0d\U8a00\U81ea\U660e\Uff0c\U5145\U5206\U7528\U6237\U81ea\U4e3b\U51b3\U5b9a\U3002\U81ea\U52a8\U4ee3\U8868\U7740\U6da6\U7269\U7ec6\U65e0\U58f0\Uff0c\U6211\U5c31\U9ed8\U9ed8\U5bf9\U4f60\U4ed8\U51fa\U5c31\U597d\U3002\n        </p>\n        <p class=\"paragraph\">\n            \U8bd5\U60f3\U8fd9\U6837\U4e00\U4e2a\U573a\U666f\Uff0c\U81ea\U52a9\U60c5\U8da3\U4f53\U9a8c\U9152\U5e97\Uff0c\U7ea6\U70ae\U53cc\U65b9\U901a\U8fc7\U9152\U5e97 APP \U5339\U914d\Uff0c\U7ebf\U4e0a\U6c9f\U901a\Uff0c\U8fbe\U6210\U7ea6\U70ae\U5171\U8bc6\Uff0c\U7ebf\U4e0a\U652f\U4ed8\Uff0c\U81ea\U52a9 Check-In, \U83b7\U5f97\U7535\U5b50\U623f\U5361\Uff0c\U7535\U5b50\U5730\U56fe\U5bfc\U822a\U623f\U95f4\U3002\U9152\U5e97\U5ba2\U670d\U63d0\U524d\U6839\U636e\U7528\U6237\U5386\U53f2\U6570\U636e\U8fdb\U884c\U5b9a\U5236\U5316\U623f\U95f4\U88c5\U9970\Uff0c\U51c6\U5907\U60c5\U8da3\U7528\U54c1\U3002\U623f\U95f4\U5185\U6c34\U6e29\Uff0c\U7a7a\U8c03\U5747\U81ea\U52a8\U8c03\U63a7\U3002\U706f\U5149\Uff0c\U97f3\U4e50\U6839\U636e\U7528\U6237\U5174\U594b\U6307\U6570\U81ea\U52a8\U8f6c\U5316\U3002\U5f53\U7136\Uff0c\U5ba4\U5185\U6240\U6709\U8bbe\U7f6e\U4e5f\U53ef\U901a\U8fc7\U89e6\U6478\U5c4f\U8bbe\U7f6e\U3002\U5fc5\U8981\U65f6\Uff0c\U6839\U636e\U7528\U6237\U8c03\U7814\Uff0c\U8fd8\U53ef\U4ee5\U63d0\U4f9b\U556a\U556a\U556a\U5206\U7ea7\U5b9e\U6218\U6307\U5357\U3002APP \U5b9a\U65f6\U901a\U77e5\U9000\U623f\U65f6\U95f4\Uff0c\U7ea6\U70ae\U53cc\U65b9\U4e92\U76f8\U8bc4\U5206\Uff0c\U5e76\U7ed9\U6b64\U6b21\U4f53\U9a8c\U8fd

 
 */

@end
