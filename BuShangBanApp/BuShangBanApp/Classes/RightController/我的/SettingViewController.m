//
//  SettingViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "BasicInformationViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation SettingViewController
{
    NSString *_detailtext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=COLOR(249, 249, 249);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self customNavigationBarWithTitle:@"设置"];
    [self defaultLeftItem];
}
-(void)btnEvent
{
    [[SliderViewController sharedSliderController].navigationController pushViewController:[[BasicInformationViewController alloc] init] animated:YES];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64,kScreenWidth,kScreenHeight-64.f) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]initWithArray:@[@[@"老编辑"],@[@"应用设置",@"关于我们",@"投诉建议"]]];
        _detailtext=@"不上班创世人";
    }
    return _dataSource;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        SettingCell *settingCell=[[SettingCell alloc]init];
        settingCell.headImageView.image=[UIImage imageNamed:@"Default avatar"];
        settingCell.titleLabel.text=self.dataSource[indexPath.section][indexPath.row];
        settingCell.detailTitleLabel.text=_detailtext;
        return settingCell;
    }else{
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font=[UIFont fontWithName:fontName size:14];
        cell.textLabel.textColor=[UIColor colorWithHexString:@"383838"];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
         cell.textLabel.text=self.dataSource[indexPath.section][indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section==0?80:48;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12.f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

