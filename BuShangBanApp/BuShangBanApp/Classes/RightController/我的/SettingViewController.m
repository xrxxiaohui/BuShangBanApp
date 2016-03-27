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
#import "FileManager.h"


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>

@property(strong,nonatomic)UITableView *tableView;
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *contentArray;
@property(nonatomic,strong)UIButton *saveOrEditBtn;

@end

@implementation SettingViewController
{
    UIImage *_headImage;
    NSIndexPath *_indexPath;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _titleArray=[NSArray arrayWithObjects:@[@"头像"],@[@"昵称",@"身份签名",@"个人简介"],nil];
//    if (_user.isLogin) {
    _contentArray=@[@"",@"",@""];
//          _contentArray=@[_user.avatar,_user.nickname,_user.UserExtend.IDsign,_user.UserExtend.profile];
//    }
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self customNavigationBarWithTitle:@"基本资料"];
    [self defaultLeftItem];
    [self customRightItemWithBtn:self.saveOrEditBtn];
}

-(void)saveOrEditInfo:(UIButton *)sender
{
    [self.view endEditing:YES];
    sender.selected=!sender.selected;
    NSString *title=sender.selected?@"保 存":@"编 辑";
    [sender setTitle:title forState:UIControlStateNormal];
    
//    !sender.isSelected?[FileManager archiverObject:_user key:@"kUser" fileName:@"user.achiever"]:nil;
    
    
    //    [FileManager upLoadDataToSeverWithURL:[NSURL URLWithString:@""] post:YES dic:nil infor:^(BOOL error, NSString *info) {
    //
    //
    //    }];
    
}

-(void)setHeadImage:(UIButton *)btn
{
    [self.tableView endEditing:YES];
    [BuShangBanImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image)
    {
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.layer.cornerRadius=btn.width/2;
        btn.clipsToBounds=YES;
    }];
//    [FileManager saveFileWithFile:[btn snapshotImage] fileName:@"userHead" path:[[FileManager documentPathWithFileName:nil] stringByAppendingString:@"/userInfo"] info:^(BOOL error, NSString *info) {
//        if (error)
//        {
//            NSLog(@"%@",info);
//        }
//        else
//        {
//            _user.avatar=[info componentsSeparatedByString:@":"][1];
//        }
//    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.tableView endEditing:YES];
}

-(UIButton *)saveOrEditBtn
{
    if (!_saveOrEditBtn) {
        _saveOrEditBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_saveOrEditBtn setTitle:@"编 辑" forState:UIControlStateNormal];
        [_saveOrEditBtn setTitleColor:nomalTextColor forState:UIControlStateNormal];
        [_saveOrEditBtn addTarget:self action:@selector(saveOrEditInfo:) forControlEvents:UIControlEventTouchUpInside];
        _saveOrEditBtn.selected=YES;
        [_saveOrEditBtn sizeToFit];
    }
    return _saveOrEditBtn;
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

#pragma mark -- delegate --

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
        UIImage *image=[UIImage imageWithContentsOfFile:_user.avatar];
        if (!image) {
            image=[UIImage imageNamed:@"Default avatar"];
        }
        [cell.headBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    else if(indexPath.section == 1)
    {
        if(indexPath.row==2)
        {
            cell.profileTextView.delegate=self;
            [cell.profileTextView setText:_contentArray[indexPath.row]];
        }
        else
        {
            cell.contentTF.delegate=self;
            [cell.contentTF setText:_contentArray[indexPath.row]];
        }
    }
//    if(!_user.isLogin)
//        cell.userInteractionEnabled=NO;
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
    else
    {
        [self setHeadImage:cell.headBtn];
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

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (_indexPath.row)
    {
        case 0:
            _user.nickname=textField.text;
            break;
        case 1:
            _user.UserExtend.IDsign=textField.text;
            break;
        default:
            break;
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    _user.UserExtend.profile=textView.text;
}

@end
