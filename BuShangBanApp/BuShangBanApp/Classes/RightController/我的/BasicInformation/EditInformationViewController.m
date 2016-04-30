//
//  EditInformationViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "EditInformationViewController.h"

@interface EditInformationViewController ()

<<<<<<< HEAD
@property (weak, nonatomic) IBOutlet UITextField *EditInformationTextField;
=======
@property (weak, nonatomic) IBOutlet UITextField *editInformationTextField;
>>>>>>> 631fb96176c49484a20f939c338bac2508d197c6
@end

@implementation EditInformationViewController
{
    NSString *_title;
<<<<<<< HEAD
=======
    NSString *_content;
>>>>>>> 631fb96176c49484a20f939c338bac2508d197c6
}

- (void)viewDidLoad {
    [super viewDidLoad];
<<<<<<< HEAD
    self.view.backgroundColor=COLOR(249, 249, 249);
    self.EditInformationTextField.font=nomalFont;
    self.EditInformationTextField.textColor=[UIColor colorWithHexString:@"a5a5a5"];
    self.EditInformationTextField.placeholder=[NSString stringWithFormat:@"填写%@",_title];
    if ([_title isEqualToString:@"电话号码"]) {
        self.EditInformationTextField.keyboardType=UIKeyboardTypeNumberPad;
    }else if([_title isEqualToString:@"电子邮件"])
        self.EditInformationTextField.keyboardType=UIKeyboardTypeEmailAddress;
    [self customNavigationBarWithTitle:_title];
    [self defaultLeftItem];
}
-(instancetype)initWithTitle:(NSString *)title
{
    self=[super init];
    if (self)
        _title=title;
=======
    self.view.backgroundColor=bgColor;
    self.editInformationTextField.font=nomalFont;
    self.editInformationTextField.textColor=[UIColor colorWithHexString:@"a5a5a5"];
    if (_content && _content!=nil)
        self.editInformationTextField.text=_content;
    else
        self.editInformationTextField.placeholder=[NSString stringWithFormat:@"填写%@",_title];
    if ([_title isEqualToString:@"电话号码"]) {
        self.editInformationTextField.keyboardType=UIKeyboardTypeNumberPad;
    }else if([_title isEqualToString:@"电子邮件"])
        self.editInformationTextField.keyboardType=UIKeyboardTypeEmailAddress;
    [self customNavigationBarWithTitle:_title];
    [self defaultLeftItem];
}
-(instancetype)initWithContentInfor:(NSArray *)infor;
{
    self=[super init];
    if (self)
    {
        _title=infor[0];
        _content=infor[1];
    }
>>>>>>> 631fb96176c49484a20f939c338bac2508d197c6
    return self;
}

-(void)popToLeft
{
<<<<<<< HEAD
    [self.delegate EditInformationWithContentString:_EditInformationTextField.text];
=======
    [self.delegate editInformationWithContentString:_editInformationTextField.text];
>>>>>>> 631fb96176c49484a20f939c338bac2508d197c6
    [super popToLeft];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
