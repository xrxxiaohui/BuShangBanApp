//
//  MineViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MineViewController.h"
#import "TableViewCell.h"
//#import "AddressChoicePickerView.h"
#import "TableHeaderView.h"
#import "SettingViewController.h"
#import "SliderViewController.h"
//#import "BuShangBanCalendar.h"
#import "FileManager.h"


@interface MineViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

//@property(nonatomic,strong)UIButton *doneBtn;

//@property(nonatomic, strong) BuShangBanCalendar *calendar;
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSArray *contentArray;
@property(nonatomic, strong) TableHeaderView *headerView;

//@property(nonatomic,strong)UIView * grayMaskView;


@end

@implementation MineViewController {
    TableViewCell *_cell;
    NSIndexPath *_indexPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _titleArray = @[@"所在地", @"生日", @"职业", @"兴趣"];

//    if (_user.isLogin) {
    _contentArray = @[@"", @"", @"", @""];
//         _contentArray=@[_user.address,_user.birthDay,_user.UserExtend.occupation,_user.UserExtend.interest];
//    }
    [self.view addSubview:self.tableView];
}

- (void)settingBtn:(UIButton *)btn {
    [[SliderViewController sharedSliderController].navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}


#pragma mark --- 懒加载 ---

- (TableHeaderView *)headerView {
    if ( !_headerView ) {
        _headerView = [[TableHeaderView alloc] init];
        UIImage *image = [UIImage imageWithContentsOfFile:_user.avatar];
        if ( !image ) {
            image = [UIImage imageNamed:@"Default avatar"];
        }
        [_headerView.headImageBtn setBackgroundImage:image forState:UIControlStateNormal];

//        [_headerView  descriptionLabelWithText:_user.UserExtend.experience];
//        [_headerView nickNameLabelWithNickName:_user.nickname label:_user.UserExtend.myLabel];

        [_headerView descriptionLabelWithText:@"前36kr老编辑zuo，五年媒体经验"];
        [_headerView nickNameLabelWithNickName:@"老编辑" label:@"不上班创始人"];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if ( !_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.headerView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark --- delegate ---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.userInteractionEnabled = YES;
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.contentTF.text = _contentArray[indexPath.row];
    if ( indexPath.row == 0 ) {
        cell.contentTF.delegate = self;
    }
//    if (_user.isLogin) {
//        cell.userInteractionEnabled=NO;
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}


@end
