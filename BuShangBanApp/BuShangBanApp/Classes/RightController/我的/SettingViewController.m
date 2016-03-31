//
//  SettingViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/3/23.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "SettingViewController.h"
#import "TableViewCell.h"
#import "FileManager.h"
#import "BuShangBanImagePicker.h"
#import "BuShangBanCalendar.h"
#import "AddressChoicePickerView.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property(strong, nonatomic) UITableView *tableView;
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSMutableArray *contentArray;
@property(nonatomic, strong) UIButton *saveOrEditBtn;
@property(nonatomic, strong) UIView *grayMaskView;
@property(nonatomic, strong) BuShangBanCalendar *calendar;

@end

@implementation SettingViewController {
    UIImage *_headImage;
    NSIndexPath *_indexPath;
    TableViewCell *_cell;
    CGPoint _point;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _titleArray=[NSArray arrayWithObjects:@[@"头像"], @[@"所在地", @"生日", @"职业", @"兴趣",@"昵称", @"身份签名", @"个人简介"],nil];
     _contentArray = [NSMutableArray arrayWithArray:@[@"", @"", @"",@"",@"",@"",@"", @"",@""]];
//    if (_user.isLogin) {
//        NSDictionary *infoDic = [[UserAccountManager sharedInstance] getCurrentUserInfo];
//
//        if (infoDic) {
//            _contentArray=[NSMutableArray arrayWithArray:
//            @[[infoDic objectForKey:@"address"],[infoDic objectForKey:@"birthDay"],
//              [infoDic objectForKey:@"occupation"],[infoDic objectForKey:@"interest"],
//              [infoDic objectForKey:@"nickname"],[infoDic objectForKey:@"IDsign"],
//              [infoDic objectForKey:@"profile"]]];
//            _user.avatar=[infoDic objectForKey:@"avatar"];
//        }
//    }
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self customNavigationBarWithTitle:@"基本资料"];
    [self defaultLeftItem];
    [self customRightItemWithBtn:self.saveOrEditBtn];
}

#pragma mark  ---- event ----

-(void)keyBoardWillShow:(NSNotification *)notification
{
    NSDictionary *dic=[notification userInfo];
    CGFloat duration=[[dic objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyBoardRect=[[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (keyBoardRect.origin.y<_cell.bottom+64.f)
        [UIView animateWithDuration:duration animations:^{_tableView.top=keyBoardRect.origin.y-_cell.bottom;}];
    [self.view addSubview:self.grayMaskView];
}

-(void)keyBoardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.5 animations:^{_tableView.top=64.f;}];
    [self hideGrayMaskView];
}

- (void)tapEvent:(UITapGestureRecognizer *)tap {
    [self hideGrayMaskView];
}

-(void)hideGrayMaskView
{
    [self.tableView endEditing:YES];
    
    if (_indexPath.row == 6)
    {
        _contentArray[_indexPath.row]=_cell.profileTextView.text;
        _cell.profileTextView.userInteractionEnabled=NO;
    }
    else
    {
        _contentArray[_indexPath.row]=_cell.contentTF.text;
        _cell.contentTF.userInteractionEnabled=NO;
    }
    
    [_grayMaskView removeFromSuperview];
    _grayMaskView = nil;
}

- (void)hideCalendar:(UIButton *)btn
{
    [_calendar removeFromSuperview];;
    _calendar=nil;
}

- (void)saveOrEditInfo:(UIButton *)sender {
    [self.view endEditing:YES];
    if (sender.selected) {
        _tableView.userInteractionEnabled=NO;
    }
    else
    {
        _tableView.userInteractionEnabled=YES;
//        NSMutableDictionary *infoDic=[[NSMutableDictionary alloc]init];
//        NSArray *keys=@[@"address",@"birthDay",@"occupation",@"interest",@"nickname",@"IDsign",@"profile"];
//        
//        for (int i=2;i<[_contentArray count];i++) {
//            [infoDic setObject:_contentArray[i] forKey:keys[i]];
//        }
//        [infoDic setObject:_user.avatar forKey:@"avatar"];
//        
//        [[KVStoreManager sharedInstance] saveAccountWithUserInfo:infoDic withUid:[[KVStoreManager sharedInstance ] getCurrentUid]];
    }
    sender.selected = !sender.selected;
}


- (void)setHeadImage:(UIButton *)btn {
    [self.tableView endEditing:YES];
    [BuShangBanImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.layer.cornerRadius = btn.width / 2;
        btn.clipsToBounds = YES;
        _user.avatar=[btn snapshotImage];
    }];
}

- (UIButton *)saveOrEditBtn {
    if ( !_saveOrEditBtn ) {
        _saveOrEditBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveOrEditBtn setImage:[UIImage imageNamed:@"save_nomal"] forState:UIControlStateNormal];
        [_saveOrEditBtn setImage:[UIImage imageNamed:@"save_selected"] forState:UIControlStateSelected];
        _saveOrEditBtn.backgroundColor=[UIColor clearColor];
        [_saveOrEditBtn addTarget:self action:@selector(saveOrEditInfo:) forControlEvents:UIControlEventTouchUpInside];
        [_saveOrEditBtn sizeToFit];
    }
    return _saveOrEditBtn;
}

- (UIView *)grayMaskView {
    if ( !_grayMaskView ) {
        _grayMaskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _grayMaskView.layer.backgroundColor = [UIColor grayColor].CGColor;
        _grayMaskView.alpha = 0.4f;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [_grayMaskView addGestureRecognizer:tap];
    }
    return _grayMaskView;
}

#pragma mark ---- 懒加载 ----

- (UITableView *)tableView {
    if ( !_tableView )
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 180+44*7+12) style:UITableViewStyleGrouped];
        _tableView.backgroundColor=backgroundCoor;
        _tableView.contentSize=CGSizeMake(kScreenWidth, 180+44*7+12<kScreenHeight?180+44*7+12:kScreenHeight);
        _tableView.userInteractionEnabled=NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(BuShangBanCalendar *)calendar{
    if (!_calendar) {
        _calendar=[[BuShangBanCalendar alloc]initWithCurrentDate:[NSDate date]];
        [self.view addSubview:_calendar];
    }
    return _calendar;
}

#pragma mark -- delegate --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArray[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_titleArray count];
}

- (TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = _titleArray[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0)
    {
        UIImage *image = _user.avatar;
        if ( !image ) {
            image = [UIImage imageNamed:@"Default avatar"];
        }
        [cell.headBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    else if(indexPath.row == 6)
    {
        [cell.profileTextView setText:_contentArray[indexPath.row]];
    }
    else
    {
        [cell.contentTF setText:_contentArray[indexPath.row]];
        cell.contentTF.delegate=self;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self setHeadImage:_cell.headBtn];
        return;
    }
    
    _cell = [tableView cellForRowAtIndexPath:indexPath];
    _indexPath=indexPath;
    
    if(indexPath.row  != 6 )
        [self textFieldDidBeginEditing:_cell.contentTF];
    else
    {
        _cell.profileTextView.userInteractionEnabled = YES;
        [_cell.profileTextView becomeFirstResponder];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 80.f;
    else if(indexPath.row == 6) return 100.f;
    else return 44.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return nil;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UILabel *label=[[UILabel alloc]init];
    label.font=[UIFont fontWithName:fontName size:12];
    label.textColor=placeHoldTextColor;
    label.backgroundColor=backgroundCoor;
    label.text=@"基本资料";
    [label sizeToFit];
    label.centerY=view.centerY;
    label.left=12.f;
    [view addSubview:label];
    return view;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section == 0 ? 12.f:44.f);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_indexPath.row == 1||_indexPath.row == 0) 
        [textField resignFirstResponder];
    switch (_indexPath.row)
    {
        case 0:
        {
            AddressChoicePickerView *addressChoice=[[AddressChoicePickerView alloc]init];
            addressChoice.block=^(AddressChoicePickerView *view, UIButton *btn, AreaObject *locate){
                _contentArray[_indexPath.row]=[NSString stringWithFormat:@"%@",locate];
                textField.text= _contentArray[_indexPath.row];
            };
            [addressChoice show];
            break;
        }
        case 1:
        {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            _contentArray[_indexPath.row]=[NSString stringWithFormat:@"%@",[formatter stringFromDate:self.calendar.date]];
            textField.text= _contentArray[_indexPath.row];
            break;
        }
        default:
        {
            textField.userInteractionEnabled = YES;
            [textField becomeFirstResponder];
            break;
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}

@end
