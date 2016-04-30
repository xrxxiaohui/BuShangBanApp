//
//  BasicInformationViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "BasicInformationViewController.h"
#import "BasicInformationCell.h"
#import "BuShangBanImagePicker.h"
#import "BuShangBanCalendar.h"
#import "AddressChoicePickerView.h"
//#import "OccupationSelectorView.h"
#import "EditInformationViewController.h"

@interface BasicInformationViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,EditInformationDelegate>

@property(strong, nonatomic) UITableView *tableView;
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSMutableArray *contentArray;
@property(nonatomic, strong) UIView *grayMaskView;
@property(nonatomic, strong) BuShangBanCalendar *calendar;
//@property(nonatomic, weak)OccupationSelectorView *occupationSelectorView;
@property(nonatomic, strong)EditInformationViewController *editInformationViewController;
@end

@implementation BasicInformationViewController
{
    UIImage *_headImage;
    NSIndexPath *_indexPath;
    BasicInformationCell *_cell;
    CGPoint _point;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _titleArray=[NSArray arrayWithObjects:@[@"头像"],@[@"昵称", @"身份签名",@"所在地",@"生日", @"职业", @"兴趣"], @[@"电话号码",@"电子邮件" ],nil];
    _contentArray = [NSMutableArray arrayWithArray:@[@[@""],@[@"创业先生", @"创业中的人",@"北京",@"1990.03.03", @"无业游民", @"产品,聊天,创业"], @[@"13051699286",@"m13051699286@163.com"]]];
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self customNavigationBarWithTitle:@"基本资料"];
    [self defaultLeftItem];
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
    //    if (_indexPath.row == 6)
    //    {
    //        _contentArray[_indexPath.row]=_cell.profileTextView.text;
    //        _cell.profileTextView.userInteractionEnabled=NO;
    //    }
    //    else
    {
        _contentArray[_indexPath.row]=_cell.contentTF.text;
        _cell.contentTF.userInteractionEnabled=NO;
    }
    
    [_grayMaskView removeFromSuperview];
    _grayMaskView = nil;
}

- (void)hideCalendar:(UIButton *)btn{
    [_calendar removeFromSuperview];;
    _calendar=nil;
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


- (UIView *)grayMaskView {
    if ( !_grayMaskView ) {
        
        UIView *grayMaskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        grayMaskView.layer.backgroundColor = [UIColor grayColor].CGColor;
        grayMaskView.alpha = 0.4f;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [grayMaskView addGestureRecognizer:tap];
        _grayMaskView=grayMaskView;
    }
    return _grayMaskView;
}

#pragma mark ---- 懒加载 ----

- (UITableView *)tableView {
    if ( !_tableView )
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth,kScreenHeight) style:UITableViewStyleGrouped];
        _tableView.backgroundColor=COLOR(249, 249, 249);
        _tableView.contentSize=CGSizeMake(kScreenWidth, 180+44*7+12<kScreenHeight?180+44*7+12:kScreenHeight);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(BuShangBanCalendar *)calendar{
    if (!_calendar) {
        BuShangBanCalendar *calendar=[[BuShangBanCalendar alloc]initWithCurrentDate:[NSDate date]];
        [self.view addSubview:calendar];
        _calendar=calendar;
    }
    return _calendar;
}

//-(OccupationSelectorView *)occupationSelectorView{
//    if(!_occupationSelectorView)
//    {
//        OccupationSelectorView * selectorView=[[OccupationSelectorView alloc]init];
//        [self.view addSubview:selectorView];
//        [selectorView show];
//        _occupationSelectorView=selectorView;
//    }
//    return _occupationSelectorView;
//}

#pragma mark -- delegate --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titleArray[section] count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [_titleArray count];
}

- (BasicInformationCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BasicInformationCell *cell = [[BasicInformationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0 )
    {
        UIImage * image = [UIImage imageNamed:@"Default avatar"];
        [cell.headBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    else
    {
        [cell.contentTF setText:_contentArray[indexPath.section][indexPath.row]];
        cell.contentTF.delegate=self;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self setHeadImage:_cell.headBtn];
        if (_cell.headBtn.currentImage == nil)
            [_cell.headBtn setImage:[UIImage imageNamed:@"Default avatar"] forState:UIControlStateNormal];
        return;
    }
    _cell = [tableView cellForRowAtIndexPath:indexPath];
    _editInformationViewController=[[EditInformationViewController alloc]initWithTitle:_cell.textLabel.text];
    _editInformationViewController.delegate=self;
    [[SliderViewController sharedSliderController].navigationController pushViewController:self.editInformationViewController animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return 80.f;
    else
        return 48.f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return nil;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    UILabel *label=[[UILabel alloc]init];
    label.font=[UIFont fontWithName:fontName size:12];
    label.textColor=placeHoldTextColor;
    label.backgroundColor=COLOR(249, 249, 249);
    label.text=section==1?@"基本资料":@"联系方式";
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
    if (_indexPath.section ==1)
    {
        switch (_indexPath.row)
        {
            case 2:
            {
                AddressChoicePickerView *addressChoice=[[AddressChoicePickerView alloc]init];
                addressChoice.block=^(AddressChoicePickerView *view, UIButton *btn, AreaObject *locate)
                {
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
            case 4:
            {
//                self.occupationSelectorView.occupationSelectorBlock=^(OccupationSelectorView *view,NSString *contentText){
//                    _contentArray[_indexPath.row]=contentText;
//                    textField.text= _contentArray[_indexPath.row];
//                };
//                break;
            }
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}


-(void)EditInformationWithContentString:(NSString *)contentString
{
    if ([_cell.textLabel.text isEqual:@"兴趣"] && ![_cell.contentTF.text isEqual:@""] && _cell.contentTF.text!=nil )
        _cell.contentTF.text=[NSString stringWithFormat:@"%@,%@",_cell.contentTF.text,contentString];
    else if(![contentString isEqual:@"  "] && contentString!=nil )
        _cell.contentTF.text=contentString;
    _editInformationViewController=nil;
}
@end
