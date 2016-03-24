//
//  MineViewController.m
//  BuShangBanApp
//
//  Created by Zuo on 16/3/16.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "MineViewController.h"
#import "TableViewCell.h"
#import "AddressChoicePickerView.h"
#import "TableHeaderView.h"
#import "SettingViewController.h"
#import "SliderViewController.h"

#define tableHeaderViewHeight 200

@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)TableViewCell *cell;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)TableHeaderView * headerView;

@end

@implementation MineViewController
{
    NSIndexPath *_indexPath;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    _titleArray=@[@"所在地",@"生日",@"职业",@"兴趣"];
    [self.view addSubview:self.tableView];
}

-(void)settingBtn:(UIButton *)btn
{
    [[SliderViewController sharedSliderController].navigationController pushViewController:[[SettingViewController alloc]init] animated:YES];
}

-(NSMutableArray *)contentArray
{
    if (!_contentArray)
    {
        _contentArray=[NSMutableArray arrayWithArray:@[@"",@"",@"",@""]];
    }
    return _contentArray;
}

-(TableHeaderView *)headerView
{
    if (!_headerView)
    {
        _headerView  = [[TableHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width,tableHeaderViewHeight)];
//        _headerView.bgImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
//        _headerView.headImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        [_headerView  descriptionLabelWithText:@"前36kr老编辑zuo，五年媒体经验"];
        [_headerView nickNameLabelWithNickName:@"老编辑 | " label:@"不上班创始人"];
    }
    return _headerView;
}

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0,kScreenHeight, kScreenHeight) style:UITableViewStylePlain];
        _tableView.tableHeaderView=self.headerView;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.textLabel.text=_titleArray[indexPath.row];
    cell.contentTF.text=_contentArray[indexPath.row];
    if (indexPath.row==0)
    {
        [cell.contentTF endEditing:YES];
        cell.contentTF.delegate=self;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row==0)
    {
        _indexPath=indexPath;
        [self textFieldDidBeginEditing:_cell.contentTF];
    }
    else
    {
        _cell.contentTF.userInteractionEnabled=YES;
        [_cell.contentTF becomeFirstResponder];
    }
    _contentArray[indexPath.row]=_cell.contentTF.text;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.tableView endEditing:YES];
    AddressChoicePickerView *addressChoice=[[AddressChoicePickerView alloc]init];
    addressChoice.block=^(AddressChoicePickerView *view,UIButton *btn,AreaObject *locate){
        textField.text=[NSString stringWithFormat:@"%@",locate];
    };
    [addressChoice show];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tableView endEditing:YES];
}

@end
