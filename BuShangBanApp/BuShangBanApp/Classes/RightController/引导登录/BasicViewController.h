//
//  BasicViewController.h
//  BuShangBanApp
//
//  Created by mac on 16/4/27.
//  Copyright © 2016年 Zuo. All rights reserved.
//

@interface BasicViewController : UIViewController
{
    UIView *_contentView;
    UIButton *_closeBtn;
}
-(UITextField *)textFieldWithPlaceHolder:(NSString *)placeholder imageNamed:(NSString *)imageNamed;

-(UIButton *)buttonWithImageName:(NSString *)imageName  tag:(NSInteger)tag frame:(CGRect)frame title:(NSString *)title;

-(void)clickEvent:(UIButton *)sender;
-(CAShapeLayer *)shapeLayerWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;


-(void)showKeyBoard:(NSNotification *)noti;

-(void)hideKeyBoard:(NSNotification *)noti;
@end
