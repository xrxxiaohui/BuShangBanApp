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
#import "AddressChoicePickerView.h"
#import "OccupationSelectorView.h"
#import "BirthdayPickerView.h"
#import "AddressChoicePickerView.h"
#import "EditInformationViewController.h"
#import "User.h"

#define userURL @"https://leancloud.cn:443/1.1/classes/_User/570387b3ebcb7d005b196d24"

#define saveInformationURL  @"https://api.leancloud.cn/1.1/users/570387b3ebcb7d005b196d24"

#define uploadImageURL @"https://api.leancloud.cn/1.1/files/570387b3ebcb7d005b196d24.jpeg"

@interface BasicInformationViewController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate,EditInformationDelegate>

@property(nonatomic,strong)User *user;

@property(strong, nonatomic) UITableView *tableView;
@property(nonatomic, strong) NSArray *titleArray;
@property(nonatomic, strong) NSMutableArray *contentArray;
@property(nonatomic, strong) UIView *grayMaskView;

@property(nonatomic, weak)OccupationSelectorView *occupationSelectorView;

@property(nonatomic, weak)BirthdayPickerView *birthdaySelectorView;

@property(nonatomic, strong)EditInformationViewController *editInformationViewController;
@end

@implementation BasicInformationViewController
{
    UIImage *_headImage;
    NSIndexPath *_indexPath;
    BasicInformationCell *_cell;
    CGPoint _point;
    NSMutableDictionary *_mutableDic;
    NSString *_objectID;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    _tableView.backgroundColor=bgColor;
    [self __initData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self customNavigationBarWithTitle:@"基本资料"];
    [self defaultLeftItem];
    UIButton *saveBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn addTarget:self action:@selector(saveInformation:) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font=[UIFont fontWithName:fontName size:15];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self customRightItemWithBtn:saveBtn];
}


-(void)__initData
{
    self.user=[[User alloc]init];
    _mutableDic =[NSMutableDictionary dictionary];
    _titleArray=[NSArray arrayWithObjects:@[@"头像"],@[@"昵称", @"身份签名",@"所在地",@"生日", @"职业", @"兴趣"], @[@"电话号码",@"电子邮件" ],nil];
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    [_urlParamsReq setUrlString:userURL];
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successReq){
        
        NSDictionary *_successInfo = [successReq.responseString objectFromJSONString];

        self.user.sex = _successInfo[@"sex"];
        self.user.avatar= SafeForDictionary(_successInfo[@"avatar"]);
        self.user.avatarImageURL=[NSURL URLWithString:SafeForString(self.user.avatar[@"url"])];
    
        NSString *birthday = [[[_successInfo[@"birthday"] objectForKey:@"iso"] substringWithRange:NSMakeRange(0, 10)] stringByReplacingOccurrencesOfString:@"-" withString:@","];
        NSMutableArray *array1=[NSMutableArray array];
        [array1 addObject:_successInfo[@"username"]];
        [array1 addObject:_successInfo[@"title"]];
        [array1 addObject:_successInfo[@"city_name"]];
        [array1 addObject:birthday];
    
        [array1 addObject:_successInfo[@"profession"]];
        [array1 addObject:[_successInfo[@"interest"] componentsJoinedByString:@","]];
        
         NSMutableArray *array2=[NSMutableArray array];
        [array2 addObject:_successInfo[@"mobilePhoneNumber"]];
        [array2 addObject:_successInfo[@"email"]];
        
        self.contentArray =[NSMutableArray array];
        [self.contentArray addObject:@[@""]];
        [self.contentArray addObject:array1];
        [self.contentArray addObject:array2];
        
        [self.tableView reloadData];
    } failureBlock:^(SSLXResultRequest *failReq){
        NSDictionary *_failDict = [failReq.responseString objectFromJSONString];
        NSString *_errorMsg = [_failDict valueForKeyPath:@"result.error.errorMessage"];
        _errorMsg? [MBProgressHUD showError:_errorMsg]: [MBProgressHUD showError:kMBProgressErrorTitle];
    }];
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
    _cell.contentTF.userInteractionEnabled=NO;
    [_grayMaskView removeFromSuperview];
    _grayMaskView = nil;
}

- (void)hideCalendar:(UIButton *)btn{
    [_birthdaySelectorView removeFromSuperview];;
    _birthdaySelectorView=nil;
}

- (void)setHeadImage:(UIButton *)btn {
    [self.tableView endEditing:YES];
    [BuShangBanImagePicker showImagePickerFromViewController:self allowsEditing:YES finishAction:^(UIImage *image) {
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.layer.cornerRadius = btn.width / 2;
        btn.clipsToBounds = YES;
        _user.avatarImage=[btn snapshotImage];
        [_mutableDic setValue:_objectID forKey:@"objectId"];
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

-(void)saveInformation:(UIButton *)sender
{
    SSLXUrlParamsRequest *_urlParamsReq = [[SSLXUrlParamsRequest alloc] init];
    _urlParamsReq.requestMethod =  YTKRequestMethodPut;
    [_urlParamsReq setParamsDict:_mutableDic];
    [_urlParamsReq setUrlString:saveInformationURL];
    
    [[SSLXNetworkManager sharedInstance] startApiWithRequest:_urlParamsReq successBlock:^(SSLXResultRequest *successRequest){
        if([successRequest.responseJSONObject objectForKey:@"updatedAt"])
            [MBProgressHUD showError:@"信息更新完成"];
    } failureBlock:^(SSLXResultRequest *failRequest){
        
        [MBProgressHUD showError:@"信息更新失败"];
        
//        NSString *_errorMsg = [[failRequest.responseString objectFromJSONString] objectForKey:@"error"];
//        _errorMsg?[MBProgressHUD showError:_errorMsg]:[MBProgressHUD showError:kMBProgressErrorTitle];
    }];
}

#pragma mark ---- 懒加载 ----

- (UITableView *)tableView {
    if ( !_tableView )
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth,kScreenHeight-64) style:UITableViewStyleGrouped];
        _tableView.contentSize=CGSizeMake(kScreenWidth, 180+44*7+12<kScreenHeight?180+44*7+12:kScreenHeight);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator=NO;
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

-(BirthdayPickerView *)birthdaySelectorView{
    if(!_birthdaySelectorView)
    {
        BirthdayPickerView * birthdaySelectorView=[[BirthdayPickerView alloc]init];
        [self.view addSubview:birthdaySelectorView];
        [birthdaySelectorView show];
        _birthdaySelectorView=birthdaySelectorView;
    }
    return _birthdaySelectorView;
}
-(OccupationSelectorView *)occupationSelectorView{
    if(!_occupationSelectorView)
    {
        OccupationSelectorView * selectorView=[[OccupationSelectorView alloc]init];
        [self.view addSubview:selectorView];
        [selectorView show];
        _occupationSelectorView=selectorView;
    }
    return _occupationSelectorView;
}


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
        UIImageView *imageView=[[UIImageView alloc]init];
        if(self.user.avatarImageURL)
            [imageView sd_setImageWithURL:self.user.avatarImageURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [cell.headBtn setBackgroundImage:image forState:UIControlStateNormal];
            }];
        else
            [cell.headBtn setBackgroundImage:[UIImage imageNamed:@"Default avatar"] forState:UIControlStateNormal];
        [cell.headBtn addTarget:self action:@selector(setHeadImage:) forControlEvents:UIControlEventTouchUpInside];
        [cell addSubview:cell.headBtn];
    }
    else
    {
        cell.contentTF.text=_contentArray[indexPath.section][indexPath.row];
        cell.contentTF.delegate=self;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0 )
    {
        [self setHeadImage:_cell.headBtn];
        if (_cell.headBtn.currentImage == nil)
            [_cell.headBtn setImage:[UIImage imageNamed:@"Default avatar"] forState:UIControlStateNormal];
        return;
    }

    else if(indexPath.section == 1  && (indexPath.row == 2 || indexPath.row ==3 || indexPath.row == 4) )
    {
        _indexPath=indexPath;
        [self textFieldDidBeginEditing:_cell.contentTF];
        return;
    }else if(indexPath.section == 2  && indexPath.row == 0)
        return;
    
    _editInformationViewController=[[EditInformationViewController alloc]initWithContentInfor:@[_cell.textLabel.text,_cell.contentTF.text]];
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
    view.backgroundColor=bgColor;
    UILabel *label=[[UILabel alloc]init];
    label.font=[UIFont fontWithName:fontName size:12];
    label.textColor=placeHoldTextColor;
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
                addressChoice.block=^(AddressChoicePickerView *view, UIButton *btn, AreaObject *locate){
                    _contentArray[1][2]=[NSString stringWithFormat:@"%@",locate];
                    textField.text= [NSString stringWithFormat:@"%@",locate];
                    [_mutableDic setValue:[NSString stringWithString:_contentArray[1][2]] forKey:@"city_name"];
                };
                [addressChoice show];
                break;
            }
            case 3:
            {
                self.birthdaySelectorView.contentString=[NSString stringWithString:textField.text];
                self.birthdaySelectorView.birthdayPickerBlock=^(BirthdayPickerView *view,NSString *contentText){
                    _contentArray[1][3]=contentText;
                    textField.text= contentText;
                    [_mutableDic setValue:[NSString stringWithString:_contentArray[1][3]] forKey:@"birthday"];
                };
                break;
            }
            case 4:
            {
                self.occupationSelectorView.contentString=[NSString stringWithString:textField.text];
                self.occupationSelectorView.occupationSelectorBlock=^(OccupationSelectorView *view,NSString *contentText){
                    _contentArray[1][4]=contentText;
                    textField.text= contentText;
                    [_mutableDic setValue:[NSString stringWithString:contentText] forKey:@"profession"];
                };
                break;
            }
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}

-(void)editInformationWithContentString:(NSString *)contentString
{
    if ([_cell.textLabel.text isEqualToString:@"昵称"])
        [_mutableDic setValue:contentString forKey:@"username"];
    else if([_cell.textLabel.text isEqualToString:@"省份签名"])
        [_mutableDic setValue:contentString forKey:@"title"];
    else if([_cell.textLabel.text isEqualToString:@"兴趣"])
        [_mutableDic setValue:contentString forKey:@"interest"];
    else if([_cell.textLabel.text isEqualToString:@"电子邮件"])
        [_mutableDic setValue:contentString forKey:@"email"];
    else if([_cell.textLabel.text isEqualToString:@"电话号码"])
        [_mutableDic setValue:contentString forKey:@"mobilePhoneNumber"];
    
    _cell.contentTF.text=contentString;
    _editInformationViewController=nil;
}

@end
