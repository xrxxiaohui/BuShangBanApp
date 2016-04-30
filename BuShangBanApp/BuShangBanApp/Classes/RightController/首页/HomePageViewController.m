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

@interface HomePageViewController ()<UITableViewDataSource,UITableViewDelegate> {
    
    UITableView *_mainTableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_homeListdataArray;

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


    CGFloat height = kScreenHeight - 44;
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

-(void)fetchHomeListData {

    // 请求
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    
    NSDictionary *_tempParam = @{@"bid":@"888888"};
    
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        NSArray *_resultArray = [[_successInfo objectForKey:@"results"] safeArray];
        //        NSDictionary *_businessData = [_resultInfo objectForKey:@"businessData"];
        //        NSDictionary *_activifyData  = [_businessData objectForKey:@"get_gonglue"];
        //
        //
        //        if ([[_activifyDataa objectForKey:@"results"] isKindOfClass:[NSArray class]]) {
        //
        //            //            [self setAbroadArray:[_activifyData objectForKey:@"results"]];
        //            //            [self.tableView reloadData];
        //        }
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
    
    // 请求
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq setUrlString:@"Featured?limit=3&&order=-sort&&"];
    
//    NSDictionary *_tempParam = @{@"bid":@"888888"};
//    [_urlParamsReq setParamsDict:_tempParam];
    
    NSDictionary *_tempParam = @{@"bid":@"888888"};
    
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];
        NSArray *_resultArray = [[_successInfo objectForKey:@"results"] safeArray];
//        NSDictionary *_businessData = [_resultInfo objectForKey:@"businessData"];
//        NSDictionary *_activifyData  = [_businessData objectForKey:@"get_gonglue"];
//        
//        
//        if ([[_activifyDataa objectForKey:@"results"] isKindOfClass:[NSArray class]]) {
//            
//            //            [self setAbroadArray:[_activifyData objectForKey:@"results"]];
//            //            [self.tableView reloadData];
//        }
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
        return 0.5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 260*kScreenWidth/414;
    }else{
    
        return [HomePageContentCell getCellHeight];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIndentifier = @"HomeHeadViewCell";
        HomeHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[HomeHeadViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }

        [cell setDataArray:_dataArray];
        [cell refreshUI];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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

        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
//    else{
//        if ([_dataSourceArray[indexPath.row] isKindOfClass:[JZStepListModel class]]) {//章
//            static NSString *cellIndentifier = @"detailCell10";
//            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
//            if (cell == nil) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
//                //下划线
//                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 42.5, screen_width, 0.5)];
//                lineView.backgroundColor = separaterColor;
//                [cell addSubview:lineView];
//            }
//            JZStepListModel *jzStepM = _dataSourceArray[indexPath.row];
//            cell.textLabel.text = [NSString stringWithFormat:@"第%@章:%@",jzStepM.StepIndex,jzStepM.StepName];
//            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }else{//节
//            static NSString *cellIndentifier = @"detailCell11";
//            JZCourseClassCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
//            if (cell == nil) {
//                cell = [[JZCourseClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
//                //下划线
//                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(40, 63.5, screen_width, 0.5)];
//                lineView.tag = 10;
//                lineView.backgroundColor = separaterColor;
//                [cell addSubview:lineView];
//            }
//            
//            JZClassListModel *jzClassM = _dataSourceArray[indexPath.row];
//            if ([jzClassM.isLast isEqualToString:@"1"]) {
//                UIView *lineView = (UIView *)[cell viewWithTag:10];
//                lineView.frame = CGRectMake(0, 63.5, screen_width, 0.5);
//            }
//            [cell setJzClassM:jzClassM];
//            
//            
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            return cell;
//        }
//    }
    
    
    static NSString *cellIndentifier = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [AVAnalytics event:@"homePageList_click"];
    BaseWebViewController *baseWebView = [[BaseWebViewController alloc] init];
    baseWebView.isTestWeb = YES;
    
    [[SliderViewController sharedSliderController].navigationController pushViewController:baseWebView animated:YES ];


}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *_sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];

    if(section == 1){
        [_sectionHeaderView setBackgroundColor:COLOR(249, 249, 249)];
    
        UIImageView *normalImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Community"]];
        [normalImageView setFrame:CGRectMake(kScreenWidth/2-124, 0, 248, 20)];
        [_sectionHeaderView addSubview:normalImageView];
    
//    UIView *_redPenciLine = [[UIView alloc] initWithFrame:CGRectMake(4, 10, 2, 13)];
//    [_redPenciLine setBackgroundColor:kAppRedColor];
//    [_sectionHeaderView addSubview:_redPenciLine];
//    
//    UILabel *_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_redPenciLine.right + 2, _redPenciLine.top, 100, _redPenciLine.height)];
//    [_titleLabel setFont:[UIFont systemFontOfSize:13]];
//    [_titleLabel setTextColor:COLOR(0x38, 0x3d, 0x49)];
//    [_sectionHeaderView addSubview:_titleLabel];
//    switch (section) {
//        case 0:
//            [_titleLabel setText:@"热门活动"];
//            break;
//        case 1:
//            [_titleLabel setText:@"过往活动"];
//            break;
//            
//        default:
//            break;
//    }
        return _sectionHeaderView;

    }
    return nil;
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
 */

@end
