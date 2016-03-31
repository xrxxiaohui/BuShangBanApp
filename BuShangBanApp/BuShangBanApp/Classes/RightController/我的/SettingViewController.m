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
//#import "UserAccountManager.h"
//#import "KVStoreManager.h"


@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,UITextViewDelegate>

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _titleArray=@[@"头像",@"基本资料",@"所在地", @"生日", @"职业", @"兴趣",@"昵称", @"身份签名", @"个人简介"];
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
    NSValue *aValue = [dic objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect=[aValue CGRectValue];
    
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.bottom=keyBoardRect.origin.y;
    }];
    [self.view addSubview:self.grayMaskView];
}

-(void)keyBoardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.5 animations:^{
        _tableView.top=64.f;
    }];
    [self hideGrayMaskView];
}

- (void)tapEvent:(UITapGestureRecognizer *)tap {
    [self hideGrayMaskView];
}

-(void)hideGrayMaskView
{
    [self.tableView endEditing:YES];
    
    switch (_indexPath.row) {
        case 0:
        {
            
            break;
        }
        case 8:
            _contentArray[_indexPath.row]=_cell.profileTextView.text;
            break;
        default:
            _contentArray[_indexPath.row]=_cell.contentTF.text;
            break;
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
        _tableView.userInteractionEnabled=YES;
    }
    else
    {
        _tableView.userInteractionEnabled=NO;
        NSMutableDictionary *infoDic=[[NSMutableDictionary alloc]init];
        NSArray *keys=@[@"address",@"birthDay",@"occupation",@"interest",@"nickname",@"IDsign",@"profile"];
        
        for (int i=2;i<[_contentArray count];i++) {
            [infoDic setObject:_contentArray[i] forKey:keys[i]];
        }
        [infoDic setObject:_user.avatar forKey:@"avatar"];
        
        [[KVStoreManager sharedInstance] saveAccountWithUserInfo:infoDic withUid:[[KVStoreManager sharedInstance ] getCurrentUid]];
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
        _saveOrEditBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_saveOrEditBtn setImage:[UIImage imageNamed:@"save_selected"] forState:UIControlStateNormal];
        [_saveOrEditBtn setImage:[UIImage imageNamed:@"save_nomal"] forState:UIControlStateSelected];
        _saveOrEditBtn.backgroundColor=[UIColor clearColor];
        [_saveOrEditBtn addTarget:self action:@selector(saveOrEditInfo:) forControlEvents:UIControlEventTouchUpInside];
        _saveOrEditBtn.selected = YES;
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
        _tableView.contentSize=CGSizeMake(kScreenWidth, 180+44*7+12);
        _tableView.userInteractionEnabled=NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(BuShangBanCalendar *)calendar
{
    if (!_calendar) {
        _calendar=[[BuShangBanCalendar alloc]initWithCurrentDate:[NSDate date]];
        [self.view addSubview:_calendar];
    }
    return _calendar;
}

#pragma mark -- delegate --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArray count];
}

- (TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = _titleArray[indexPath.row];
    switch (indexPath.row)
    {
        case 0:
        {
            UIImage *image = _user.avatar;
            if ( !image ) {
                image = [UIImage imageNamed:@"Default avatar"];
            }
            [cell.headBtn setBackgroundImage:image forState:UIControlStateNormal];
             break;
        }
        case 1:
        {
            cell.textLabel.font=[UIFont fontWithName:fontName size:12];
            cell.textLabel.textColor=placeHoldTextColor;
            cell.backgroundColor=backgroundCoor;
            break;
        }
        case 8:
        {
            [cell.profileTextView setText:_contentArray[indexPath.row]];
            break;
        }
        default:
        {
            [cell.contentTF setText:_contentArray[indexPath.row]];
            cell.contentTF.delegate=self;
            break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _cell = [tableView cellForRowAtIndexPath:indexPath];
    _indexPath=indexPath;
    switch (indexPath.row) {
        case 0:
        {
            [self setHeadImage:_cell.headBtn];
            break;
        }
        case 1:
        {
            break;
        }
        case 8:
        {
            _cell.profileTextView.userInteractionEnabled = YES;
            [_cell.profileTextView becomeFirstResponder];
            break;
        }
        default:
        {
            [self textFieldDidBeginEditing:_cell.contentTF];
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 80.f;
        case 8:
            return 100;
        default:
            return 44;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12.f;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (_indexPath.row == 2||_indexPath.row == 3) {
        [textField resignFirstResponder];
    }
    switch (_indexPath.row) {
        case 2:
        {
            AddressChoicePickerView *addressChoice=[[AddressChoicePickerView alloc]init];
            addressChoice.block=^(AddressChoicePickerView *view, UIButton *btn, AreaObject *locate){
                _contentArray[_indexPath.row]=[NSString stringWithFormat:@"%@",locate];
                textField.text= _contentArray[_indexPath.row];
            };
            [addressChoice show];
            break;
        }
        case 3:
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

@end
