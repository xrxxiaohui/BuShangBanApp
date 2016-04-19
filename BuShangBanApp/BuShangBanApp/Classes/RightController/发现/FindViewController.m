//
//  FindViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "FindViewController.h"
#import "FindView.h"
#import "DataListViewController.h"
#import "SliderViewController.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBarWithTitle:@"发现"];
    FindView *findView = [[FindView alloc] init];
    [self.view addSubview:findView];
}

- (void)clickEvent:(UIButton *)button {
   
    DataListViewController *dataListViewController = [[DataListViewController alloc] init];
    NSDictionary *tempDic = [NSDictionary dictionaryWithObjectsAndKeys:@"技术",@"1000",@"产品",@"1001",@"设计",@"1002",@"投资",@"1003",@"管理",@"1004",@"媒体",@"1005",@"市场",@"1006",@"运营",@"1007",@"热门",@"1008", nil];
    NSString *tagString = [NSString stringWithFormat:@"%ld",button.tag];
    dataListViewController.listTitle = [tempDic objectForKey:tagString];
    [[SliderViewController sharedSliderController].navigationController pushViewController:dataListViewController animated:YES];
    
    
  /*
    switch (btn.tag) {
        case 1000:

            break;
        case 1001:

            break;
        case 1002:

            break;
        case 1003:

            break;
        case 1004:

            break;
        case 1005:

            break;
        case 1006:

            break;
        case 1007:

            break;
        case 1008:

            break;
        case 1009:

            break;
        default:
            break;
    }
   */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
