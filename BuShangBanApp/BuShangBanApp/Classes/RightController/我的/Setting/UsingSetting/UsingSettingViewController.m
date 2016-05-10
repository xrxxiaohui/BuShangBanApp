//
//  UsingSettingViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/25.
//  Copyright © 2016年 Zuo. All rights reserved.
//


#import "UsingSettingViewController.h"
#import "UsingSettingCell.h"

@interface UsingSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation UsingSettingViewController
{
    NSIndexPath* _indexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor=bgColor;
    _dataSource=[[NSMutableArray alloc]initWithArray:@[@[@"声音",@"震动",@"新消息提醒"],@[@"用户协议",@"评价应用"],@[@"清空聊天记录",@"清空本地缓存"]]];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self customNavigationBarWithTitle:@"应用设置"];
    [self defaultLeftItem];
}

-(void)__openSound
{
}
-(void)__clossSound
{
}

-(void)__openVibration
{
}
-(void)__clossVibration
{
}

-(void)__acceptNotic
{
}

-(void)__rejectNotic
{
}

-(void)switchAction:(UISwitch *)switchView
{
    switch (switchView.tag) {
        case 1000:
        {
            if(switchView.on)
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__openSound) name:@"openSound" object:nil];
            else
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__clossSound) name:@"clossSound" object:nil];
            break;
        }
        case 1001:
        {
            if(switchView.on)
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__openVibration) name:@"openSound" object:nil];
            else
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__clossVibration) name:@"openSound" object:nil];
            break;
        }
        case 1002:
        {
            if(switchView.on)
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__acceptNotic) name:@"openSound" object:nil];
            else
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__rejectNotic) name:@"openSound" object:nil];
            break;
        }
    }
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=cell=[[UITableViewCell alloc]init];
    switch (indexPath.section)
    {
        case 0:
        {
            UsingSettingCell * settingCell=[[UsingSettingCell alloc]init];
            settingCell.textLabel.text=self.dataSource[indexPath.section][indexPath.row];
            settingCell.switchView.tag=1000+indexPath.row;
            return settingCell;
        }
        case 1:
        {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text=self.dataSource[indexPath.section][indexPath.row];
            cell.textLabel.font=[UIFont fontWithName:fontName size:14];
            cell.textLabel.textColor=[UIColor colorWithHexString:@"383838"];
            return cell;
        }
        default:
        {
            cell.textLabel.font=[UIFont fontWithName:fontName size:14];
            cell.textLabel.textColor=[UIColor colorWithHexString:@"383838"];
            cell.textLabel.text=self.dataSource[indexPath.section][indexPath.row];
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section == 1 && indexPath.row == 0)
    {
        UIStoryboard *UserProtocal=[UIStoryboard storyboardWithName:@"UserProtocal" bundle:nil];
        [[SliderViewController sharedSliderController].navigationController pushViewController:[UserProtocal                      instantiateViewControllerWithIdentifier:@"UserProtocal"] animated:YES];
    }
    else if(indexPath.section == 1 && indexPath.row == 1)
    {
       
    }
    else if(indexPath.section == 2 && indexPath.row == 0){
        [MBProgressHUD showError:@"聊天记录已清空"];
    }
    else if(indexPath.section == 2 && indexPath.row == 1)
    {
        [MBProgressHUD showError:@"缓存已清空"];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12.f;
}
@end
