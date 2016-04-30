//
//  EditInformationViewController.m
//  BuShangBanApp
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 Zuo. All rights reserved.
//

#import "EditInformationViewController.h"

@interface EditInformationViewController ()

@property (weak, nonatomic) IBOutlet UITextField *EditInformationTextField;
@end

@implementation EditInformationViewController
{
    NSString *_title;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    return self;
}

-(void)popToLeft
{
    [self.delegate EditInformationWithContentString:_EditInformationTextField.text];
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
