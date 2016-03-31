//
//  MineViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MineViewController.h"
#import "TableViewCell.h"
#import "TableHeaderView.h"
#import "SettingViewController.h"
#import "SliderViewController.h"
#import "UserAccountManager.h"

@interface MineViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate,UIScrollViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSMutableArray *contentArray;
@property(nonatomic, strong) TableHeaderView *headerView;


@end

@implementation MineViewController {
    TableViewCell *_cell;
    NSIndexPath *_indexPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _titleArray = @[@"所在地", @"生日", @"职业", @"兴趣"];
    _contentArray = [NSMutableArray arrayWithArray:@[@"", @"", @"", @""]];

//    if (_user.isLogin) {
//        NSDictionary *infoDic = [[UserAccountManager sharedInstance] getCurrentUserInfo];
//        if (infoDic) {
//            _contentArray=[NSMutableArray arrayWithArray:
//                       @[[infoDic objectForKey:@"address"],[infoDic objectForKey:@"birthDay"],
//                         [infoDic objectForKey:@"occupation"],[infoDic objectForKey:@"interest"]]];
//           _user.avatar =[infoDic objectForKey:@"avator"];
//            _user.nickName=[infoDic objectForKey:@"nickName"];
//            _user.UserExtend.myLabel=[infoDic objectForKey:@"myLabel"];
//            _user.UserExtend.experience=[infoDic objectForKey:@"experience"];
//        }
//    }
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)settingBtn:(UIButton *)btn {
    [[SliderViewController sharedSliderController].navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}


#pragma mark --- 懒加载 ---


- (TableHeaderView *)headerView {
    if ( !_headerView ) {
        _headerView = [[TableHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, tableHeaderViewHeight * adapt.scaleHeight)];
        UIImage *image = _user.avatar;
        if ( !image ) {
            image = [UIImage imageNamed:@"Default avatar"];
        }
        [_headerView.headImageBtn setBackgroundImage:image forState:UIControlStateNormal];

//        [_headerView  descriptionLabelWithText:_user.UserExtend.experience];
//        [_headerView nickNameLabelWithNickName:_user.nickName label:_user.UserExtend.myLabel];

        [_headerView descriptionLabelWithText:@"前36kr老编辑zuo，五年媒体经验"];
        [_headerView nickNameLabelWithNickName:@"老编辑" label:@"不上班创始人"];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if ( !_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.headerView;
        _tableView.backgroundColor = backgroundCoor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark --- delegate ---

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.userInteractionEnabled=NO;
    if ( _user.isLogin )
        return cell;
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.contentTF.text = _contentArray[indexPath.row];
    if ( indexPath.row == 0 ) {
        cell.contentTF.delegate = self;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint offset = scrollView.contentOffset;
    CGSize size=_headerView.size;
    float scale =size.height/size.width;
    if (offset.y < 0)
    {
        _headerView.bgImageView.height=tableHeaderViewHeight *adapt.scaleHeight -offset.y;
        _headerView.bgImageView.width=_headerView.bgImageView.height/scale;
        _headerView.bgImageView.top=offset.y;
        _headerView.bgImageView.centerX=self.view.centerX;
//        _headerView.blurView.height=tableHeaderViewHeight *adapt.scaleHeight -offset.y;
    }
//    else
//    {
//        [_headerView.blurView removeFromSuperview];
//        _headerView.blurView=nil;
//    }
}
@end
