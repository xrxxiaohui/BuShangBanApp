//
//  LoginViewOrRegistView.h
//  Youqun
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

@interface LoginViewOrRegistView : UIView

@property(nonatomic, strong) UIButton *rightBtn;
@property(nonatomic, strong) UITextField *phoneNumberTF;
@property(nonatomic, strong) UITextField *confirmationCodeTF;
@property(nonatomic, strong) UIButton *loginOrRegistBtn;
@property(nonatomic, strong) UIButton *readedBtn;
@property(nonatomic, strong) UIButton *companyProtocolBtn;
@property(nonatomic, strong) UIButton *getConfirmationCodeBtn;
@property(nonatomic, strong) UIButton *weixinLogin;
@property(nonatomic, strong) UIButton *weiboLogin;
@property(nonatomic, assign) BOOL isLogin;

@end
