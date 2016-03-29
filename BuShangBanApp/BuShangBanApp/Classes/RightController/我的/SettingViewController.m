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


@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate>

@property(strong, nonatomic) UITableView *tableView;
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSArray *contentArray;
@property(nonatomic, strong) UIButton *saveOrEditBtn;
@property(nonatomic, strong) UIView *grayMaskView;
@end

@implementation SettingViewController {
    UIImage *_headImage;
    NSIndexPath *_indexPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray=@[@"头像",@"基本资料",@"昵称", @"身份签名", @"个人简介"];
//    if (_user.isLogin) {
    _contentArray = @[@"", @"", @"",@"",@"",@""];
//          _contentArray=@[_user.avatar,_user.nickname,_user.UserExtend.IDsign,_user.UserExtend.profile];
//    }
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self customNavigationBarWithTitle:@"基本资料"];
    [self defaultLeftItem];
    [self customRightItemWithBtn:self.saveOrEditBtn];
}

- (void)tapEvent:(UITapGestureRecognizer *)tap {
    [self.tableView endEditing:YES];
    _grayMaskView.alpha = 0.0;
    [_grayMaskView removeFromSuperview];
    _grayMaskView = nil;
}

- (void)saveOrEditInfo:(UIButton *)sender {
    [self.view endEditing:YES];
    sender.selected = !sender.selected;
    NSString *title = sender.selected ? @"保 存" : @"编 辑";
    [sender setTitle:title forState:UIControlStateNormal];

//    !sender.isSelected?[FileManager archiverObject:_user key:@"kUser" fileName:@"user.achiever"]:nil;


    //    [FileManager upLoadDataToSeverWithURL:[NSURL URLWithString:@""] post:YES dic:nil infor:^(BOOL error, NSString *info) {
    //
    //
    //    }];

}

- (void)setHeadImage:(UIButton *)btn {
    [self.tableView endEditing:YES];
    [BuShangBanImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.layer.cornerRadius = btn.width / 2;
        btn.clipsToBounds = YES;
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


- (UIButton *)saveOrEditBtn {
    if ( !_saveOrEditBtn ) {
        _saveOrEditBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_saveOrEditBtn setTitle:@"编 辑" forState:UIControlStateNormal];
        [_saveOrEditBtn setTitleColor:nomalTextColor forState:UIControlStateNormal];
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

- (UITableView *)tableView {
    if ( !_tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark -- delegate --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArray count];
}

- (TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = _titleArray[indexPath.row];
//        if(!_user.isLogin)
//            return  cell;
    switch (indexPath.row)
    {
        case 0:
        {
            UIImage *image = [UIImage imageWithContentsOfFile:_user.avatar];
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
            cell.backgroundColor=[UIColor colorWithHexString:@"#cccccc"];
            break;
        }
        case 4:
        {
            cell.profileTextView.delegate = self;
            [cell.profileTextView setText:_contentArray[indexPath.row]];
            break;
        }
        default:
        {
            cell.contentTF.delegate = self;
            [cell.contentTF setText:_contentArray[indexPath.row]];
            break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view addSubview:self.grayMaskView];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view addSubview:self.grayMaskView];
    TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            [self setHeadImage:cell.headBtn];
            break;
        }
        case 4:
        {
            cell.profileTextView.userInteractionEnabled = YES;
            [cell.profileTextView becomeFirstResponder];
            break;
        }
        default:
        {
            cell.contentTF.userInteractionEnabled = YES;
            [cell.contentTF becomeFirstResponder];
            break;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ( indexPath.row == 0 ) {
        return 80.f;
    }
    else {
        return (indexPath.row==4? 100:44);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 12.f;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch ( _indexPath.row ) {
        case 2:
            _user.nickname = textField.text;
            break;
        case 3:
            _user.UserExtend.IDsign = textField.text;
            break;
        default:
            break;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    _user.UserExtend.profile = textView.text;
}

@end
