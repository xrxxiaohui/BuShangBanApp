//
//  SettingViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SettingViewController.h"
#import "TableViewCell.h"
#import "BuShangBanImagePicker.h"



@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *tableView;
@property(nonatomic,strong)NSArray *titleArray;

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleArray=[NSArray arrayWithObjects:@[@"头像"],@[@"昵称",@"身份签名",@"个人简介"],nil];
    [self.view addSubview:self.tableView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self customNavigationBarWithTitle:@"基本资料"];
    [self defaultLeftItem];
}

-(void)setHeadImage:(UIButton *)btn
{
    [BuShangBanImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image)
    {
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.layer.cornerRadius=btn.width/2;
        btn.clipsToBounds=YES;
        

        
        
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tableView endEditing:YES];
}



-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth,kScreenHeight- 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_titleArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray[section] count];
}

-(TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.textLabel.text=_titleArray[indexPath.section][indexPath.row];
    [cell becomeFirstResponder];
    if (indexPath.section == 0)
    {
         [cell.headBtn addTarget:self action:@selector(setHeadImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(indexPath.section == 1)
    {
        indexPath.row == 2 ? [cell.profileTextView setText:@""]:[cell.contentTF setText:@""];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TableViewCell *cell= [tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.section == 1  )
    {
        if (indexPath.row != 2)
        {
            cell.contentTF.userInteractionEnabled=YES;
            [cell.contentTF becomeFirstResponder];
        }
        else
        {
            [cell.profileTextView becomeFirstResponder];
        }
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 80.f;
    }
    else
    {
        if (indexPath.row ==2)
        {
            return 100;
        }
        else
        {
            return 44;
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section == 0? @" ":@"基本资料";
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section == 0 ? 12 :36;
}



@end
