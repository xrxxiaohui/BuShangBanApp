//
//  LoginViewOrRegistView.m
//  Youqun
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

#import "LoginViewOrRegistView.h"
#import "UIView+Frame.h"
#import "iPhoneScreen.h"
#import "ScreenAdapt.h"
#import <AVOSCloud/AVOSCloud.h>
#import "LoginOrRegistViewController.h"

#define LoginOrRegistViewController [[LoginOrRegistViewController alloc]init]

@interface LoginViewOrRegistView () <UITextFieldDelegate>

@property(nonatomic, strong) ScreenAdapt *screenAdapt;
@property(nonatomic, strong) UIImageView *phoneNumberBg;
@property(nonatomic, strong) UIImageView *confirmationCodeBg;
@property(nonatomic, strong) UILabel *promptLB;
@property(nonatomic, strong) UIImageView *cutOffRuleLeftImageView;
@property(nonatomic, strong) UILabel *cutOffRulePromptLB;
@property(nonatomic, strong) UIImageView *cutOffRuleRightImageView;
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel *titltLabel;
@property(nonatomic, strong) UILabel *promptLabel;


@end

@implementation LoginViewOrRegistView {
    CGFloat _scaleWidth;
    CGFloat _scaleHeight;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.bounds=[UIScreen mainScreen].bounds;
        [self screenAdapt];
        self.backgroundColor = [UIColor colorWithHexString:@"#f3f4f5"];
        [self bgView];
        [self phoneNumberBg];
        [self confirmationCodeBg];
        [self loginOrRegistBtn];
        [self getConfirmationCodeBtn];
        [self cutOffRulePromptLB];
        [self cutOffRuleLeftImageView];
        [self cutOffRuleRightImageView];
        [self weiboLogin];
        [self weixinLogin];
    }
    return self;
}

- (void)login {
    [self titltLabel];
    [self promptLabel];
    [self rightBtn];
    [self phoneNumberTF];
    [self confirmationCodeTF];
    [self readedBtn];
    [self promptLB];
    [_loginOrRegistBtn setTitle:@"登 录" forState:UIControlStateNormal];
    self.companyProtocolBtn.hidden = YES;
}

- (void)regist {
    [self titltLabel];
    [self promptLabel];
    [self rightBtn];
    [self phoneNumberTF];
    [self confirmationCodeTF];
    [self readedBtn];
    [self promptLB];
    [self companyProtocolBtn];
    [_loginOrRegistBtn setTitle:@"注 册" forState:UIControlStateNormal];
    self.companyProtocolBtn.hidden = NO;
}

- (UITextField *)textFieldWithPlaceholder:(NSString *)placeholder {
    UITextField *textFiled = [[UITextField alloc] init];
    textFiled.font = [UIFont systemFontOfSize:16.f * _scaleHeight];
    textFiled.textColor = [UIColor colorWithHexString:@"#333333"];
    textFiled.borderStyle = UITextBorderStyleNone;
    textFiled.placeholder = placeholder;
    [textFiled sizeToFit];
    return textFiled;
}

#pragma mark  -----  懒加载  -----

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_isLogin) {
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"login_registBtn_nomal"] forState:UIControlStateNormal];
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"login_registBtn_selected"] forState:UIControlStateSelected];
        } else {
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"registion_loginBtn_nomal"] forState:UIControlStateNormal];
            [_rightBtn setBackgroundImage:[UIImage imageNamed:@"registion_loginBtn_selected"] forState:UIControlStateSelected];
        }
        _rightBtn.frame = CGRectMake(0, 20, _rightBtn.currentBackgroundImage.size.width, _rightBtn.currentBackgroundImage.size.height);
        _rightBtn.right = self.width - 15.f;
        _rightBtn.centerY = 35.f;
        [_rightBtn addTarget:LoginOrRegistViewController action:@selector(rightLoginOrRegist) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}

- (UILabel *)promptLabel {
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.text = _isLogin ? @"还未注册？" : @"已有账号？";
        _promptLabel.font = [UIFont systemFontOfSize:13.f];
        _promptLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        [_promptLabel sizeToFit];
        _promptLabel.centerY = 35.f;
        _promptLabel.right = self.rightBtn.left - 7;
        [self addSubview:_promptLabel];
    }
    return _promptLabel;
}

- (UILabel *)titltLabel {
    if (!_titltLabel) {
        _titltLabel = [[UILabel alloc] init];
        _titltLabel.text = _isLogin ? @"登 录" : @"注 册";
        _titltLabel.font = [UIFont systemFontOfSize:54 / 3];
        _titltLabel.textAlignment = NSTextAlignmentCenter;
        [_titltLabel sizeToFit];
        _titltLabel.centerY = 35.f;
        _titltLabel.width = self.width;
        [self addSubview:_titltLabel];
    }
    return _titltLabel;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 64.f)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgView];
    }
    return _bgView;
}

- (void)setIsLogin:(BOOL)isLogin {
    _isLogin = isLogin;
    _isLogin ? [self login] : [self regist];
}

- (ScreenAdapt *)screenAdapt {
    if (!_screenAdapt) {
        _screenAdapt = [[ScreenAdapt alloc] init];
        [_screenAdapt adapt];
        _scaleWidth = _screenAdapt.scaleWidth;
        _scaleHeight = _screenAdapt.scaleHeight;
    }
    return _screenAdapt;
}

- (UIImageView *)phoneNumberBg {
    if (!_phoneNumberBg) {
        _phoneNumberBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registion_phone_number_bg"]];
        _phoneNumberBg.frame = CGRectMake(0, _bgView.bottom + 20, iPhoneScreenWidth - 90 / 3 * _scaleWidth, _phoneNumberBg.image.size.height);
        _phoneNumberBg.centerX = self.centerX;
        [_phoneNumberBg addGestureRecognizer:[self tapGestureWithAction:@selector(phoneNumberBgHandleGesture)]];
        [self addSubview:_phoneNumberBg];
    }
    return _phoneNumberBg;
}

- (UITextField *)phoneNumberTF {
    if (!_phoneNumberTF) {
        _phoneNumberTF = [self textFieldWithPlaceholder:@"输入手机号码"];
        _phoneNumberTF.left = self.phoneNumberBg.left + 51 / 3 * _scaleWidth;
        _phoneNumberTF.centerY = self.phoneNumberBg.centerY;
        _phoneNumberTF.width = 300.f;
        _phoneNumberTF.tag=1000;
        [_phoneNumberTF resignFirstResponder];
        _phoneNumberTF.keyboardType = UIKeyboardTypeNumberPad;
        [self addSubview:_phoneNumberTF];
    }
    return _phoneNumberTF;
}

- (UIImageView *)confirmationCodeBg {
    if (!_confirmationCodeBg) {
        _confirmationCodeBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registion_phone_number_bg"]];
        _confirmationCodeBg.frame = self.phoneNumberBg.frame;
        _confirmationCodeBg.top = self.phoneNumberBg.bottom + 21 / 3;
        [_confirmationCodeBg resignFirstResponder];
        [self addSubview:_confirmationCodeBg];
    }
    return _confirmationCodeBg;
}

- (UITextField *)confirmationCodeTF {
    if (!_confirmationCodeTF) {
        _confirmationCodeTF = [self textFieldWithPlaceholder:@"输入验证码"];
        _confirmationCodeTF.left = _confirmationCodeBg.left + 51 / 3 * _scaleWidth;
        _confirmationCodeTF.centerY = _confirmationCodeBg.centerY;
        _confirmationCodeTF.width = 300.f;
        _confirmationCodeTF.tag=1001;
        [_confirmationCodeTF resignFirstResponder];
        _confirmationCodeTF.keyboardType = UIKeyboardTypeNumberPad;
        [_confirmationCodeTF resignFirstResponder];
        [self addSubview:_confirmationCodeTF];
    }
    return _confirmationCodeTF;
}

- (UIButton *)getConfirmationCodeBtn {
    if (!_getConfirmationCodeBtn) {
        [self endEditing:YES];
        _getConfirmationCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getConfirmationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getConfirmationCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getConfirmationCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [_getConfirmationCodeBtn setBackgroundImage:[UIImage imageNamed:@"registion_confirmationCode_nomal"] forState:UIControlStateNormal];
        [_getConfirmationCodeBtn setBackgroundImage:[UIImage imageNamed:@"registion_confirmationCode_countDown"] forState:UIControlStateSelected];
        _getConfirmationCodeBtn.frame = CGRectMake(0, 0, _getConfirmationCodeBtn.currentBackgroundImage.size.width * _scaleWidth, _getConfirmationCodeBtn.currentBackgroundImage.size.height);
        _getConfirmationCodeBtn.centerY = _confirmationCodeBg.centerY;
        _getConfirmationCodeBtn.right = _confirmationCodeBg.right - 21 / 3;
        [_getConfirmationCodeBtn addTarget:LoginOrRegistViewController action:@selector(sendCode:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_getConfirmationCodeBtn];
    }
    return _getConfirmationCodeBtn;
}

- (UIButton *)loginOrRegistBtn {
    if (!_loginOrRegistBtn) {
        _loginOrRegistBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginOrRegistBtn setBackgroundImage:[UIImage imageNamed:@"login_loginOrRegistBtn_nomal"] forState:UIControlStateNormal];
        [_loginOrRegistBtn setBackgroundImage:[UIImage imageNamed:@"login_loginOrRegistBtn_selected"] forState:UIControlStateSelected];
        _loginOrRegistBtn.titleLabel.font = [UIFont systemFontOfSize:16.f];
        [_loginOrRegistBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _loginOrRegistBtn.frame = CGRectMake(0, 0, _loginOrRegistBtn.currentBackgroundImage.size.width * _scaleWidth, _loginOrRegistBtn.currentBackgroundImage.size.height);
        _loginOrRegistBtn.top = self.confirmationCodeBg.bottom + 81 / 3;
        _loginOrRegistBtn.centerX = self.centerX;
        [_loginOrRegistBtn addTarget:LoginOrRegistViewController action:@selector(loginOrRegist) forControlEvents:UIControlEventTouchUpInside];
        [_loginOrRegistBtn becomeFirstResponder];
        [self addSubview:_loginOrRegistBtn];
    }
    return _loginOrRegistBtn;
}

- (UIButton *)readedBtn {
    if (!_readedBtn) {
        _readedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (!_isLogin) {
            [_readedBtn setImage:[UIImage imageNamed:@"registion_read-no"] forState:UIControlStateNormal];
            [_readedBtn setImage:[UIImage imageNamed:@"registion_read_selelcted"] forState:UIControlStateSelected];
        } else {
            [_readedBtn setImage:[UIImage imageNamed:@"login_contentTip"] forState:UIControlStateNormal];
        }
        _readedBtn.frame = CGRectMake(15.f, self.loginOrRegistBtn.bottom + 60 / 3, 20, 20);
        _readedBtn.top = self.loginOrRegistBtn.bottom + 10.f;
        _readedBtn.tag = 1001;
        [_readedBtn addTarget:LoginOrRegistViewController action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_readedBtn];
    }
    return _readedBtn;
}

- (UILabel *)promptLB {
    if (!_promptLB) {
        _promptLB = [[UILabel alloc] init];
        _promptLB.text = _isLogin ? @"首次凭借手机号和手机验证码登录即使注册" : @"我已阅读并同意";
        _promptLB.textColor = [UIColor colorWithHexString:@"0x666666"];
        _promptLB.font = [UIFont systemFontOfSize:13.f];
        _promptLB.left = self.readedBtn.right + 21 / 3;
        [_promptLB sizeToFit];
        _promptLB.centerY = self.readedBtn.centerY;
        [self addSubview:_promptLB];
    }
    return _promptLB;
}

- (UIButton *)companyProtocolBtn {
    if (!_companyProtocolBtn) {
        _companyProtocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];

        _companyProtocolBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_companyProtocolBtn setTitle:@"我司用户协议及隐私协议" forState:UIControlStateNormal];

        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:_companyProtocolBtn.titleLabel.text];
        NSRange strRange = {0, [str length]};
        UIColor *color = [UIColor colorWithHexString:@"#2fa4f6"];
        [str addAttribute:NSForegroundColorAttributeName value:color range:strRange];
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
        [_companyProtocolBtn setAttributedTitle:str forState:UIControlStateNormal];
        _companyProtocolBtn.left = self.promptLB.right;
        _companyProtocolBtn.centerY = self.readedBtn.centerY - 14;
        [_companyProtocolBtn sizeToFit];
        _companyProtocolBtn.tag = 1002;
        [_companyProtocolBtn addTarget:LoginOrRegistViewController action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_companyProtocolBtn];
    }
    return _companyProtocolBtn;
}

- (UIImageView *)cutOffRuleLeftImageView {
    if (!_cutOffRuleLeftImageView) {
        _cutOffRuleLeftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registion_cutOffRule"]];
        _cutOffRuleLeftImageView.frame = CGRectMake(0, 0, _cutOffRuleLeftImageView.image.size.width * _scaleWidth, _cutOffRuleLeftImageView.image.size.height * _scaleHeight);
        _cutOffRuleLeftImageView.centerY = self.cutOffRulePromptLB.centerY;
        _cutOffRuleLeftImageView.right = self.cutOffRulePromptLB.left - 20.f;
        [self addSubview:_cutOffRuleLeftImageView];
    }
    return _cutOffRuleLeftImageView;
}

- (UILabel *)cutOffRulePromptLB {
    if (!_cutOffRulePromptLB) {
        _cutOffRulePromptLB = [[UILabel alloc] init];
        _cutOffRulePromptLB.text = @"选择其他登录方式";
        _cutOffRulePromptLB.top = self.loginOrRegistBtn.bottom + 459 / 3 * _scaleHeight;
        [_cutOffRulePromptLB sizeToFit];
        _cutOffRulePromptLB.centerX = self.centerX;
        _cutOffRulePromptLB.font = [UIFont systemFontOfSize:16];
        _cutOffRulePromptLB.textColor = [UIColor colorWithHexString:@"0x666666"];
        _cutOffRulePromptLB.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_cutOffRulePromptLB];
    }
    return _cutOffRulePromptLB;
}

- (UIImageView *)cutOffRuleRightImageView {
    if (!_cutOffRuleRightImageView) {
        _cutOffRuleRightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"registion_cutOffRule"]];
        _cutOffRuleRightImageView.frame = CGRectMake(0, 0, _cutOffRuleRightImageView.image.size.width, _cutOffRuleRightImageView.image.size.height);
        _cutOffRuleRightImageView.left = self.cutOffRulePromptLB.right + 20.f;
        _cutOffRuleRightImageView.centerY = self.cutOffRulePromptLB.centerY;
        [self addSubview:_cutOffRuleRightImageView];
    }
    return _cutOffRuleRightImageView;

}

#pragma mark ----- 点击事件 -----

- (UIButton *)weiboLogin {
    if (!_weiboLogin) {
        _weiboLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weiboLogin setBackgroundImage:[UIImage imageNamed:@"registion_weibo_login"] forState:UIControlStateNormal];
        _weiboLogin.frame = CGRectMake(0, 0, _weiboLogin.currentBackgroundImage.size.width * _scaleWidth, _weiboLogin.currentBackgroundImage.size.height * _scaleHeight);
        _weiboLogin.top = self.cutOffRulePromptLB.bottom + 125 / 3 * _scaleHeight;
        _weiboLogin.left = iPhoneScreenWidth / 2 + 105 / 3 / 2;
        [_weiboLogin addTarget:LoginOrRegistViewController action:@selector(ssoLogInWeibo) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_weiboLogin];
    }
    return _weiboLogin;
}

- (UIButton *)weixinLogin {
    if (!_weixinLogin) {
        _weixinLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weixinLogin setBackgroundImage:[UIImage imageNamed:@"registion_weixin_login"] forState:UIControlStateNormal];
        _weixinLogin.frame = CGRectMake(0, 0, _weixinLogin.currentBackgroundImage.size.width * _scaleWidth, _weixinLogin.currentBackgroundImage.size.height * _scaleHeight);
        _weixinLogin.top = self.cutOffRulePromptLB.bottom + 125 / 3 * _scaleHeight;
        _weixinLogin.right = self.weiboLogin.left - 105 / 3;
        [_weixinLogin addTarget:LoginOrRegistViewController action:@selector(ssoLogInWechat) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_weixinLogin];
    }
    return _weixinLogin;
}


#pragma mark ----- 处 理 -----

- (UITapGestureRecognizer *)tapGestureWithAction:(SEL)action {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:action];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    return tap;
}

- (void)phoneNumberBgHandleGesture {
    [self.phoneNumberTF becomeFirstResponder];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
}
@end
