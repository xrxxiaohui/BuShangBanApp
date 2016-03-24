//
//  SUNSlideSwitchView.m
//  SUNCommonComponent
//
//
//
//

#import "SUNSlideSwitchView1.h"
#import "Define.h"
//#import "MobClick.h"
#import "ConstObject.h"

static const CGFloat kWidthOfButtonMargin = 1.0f;
static const NSUInteger kTagOfRightSideButton = 999;

@implementation SUNSlideSwitchView1
@synthesize rootScrollView;
@synthesize topScrollView;
@synthesize userContentOffsetX;
@synthesize userSelectedChannelID;
@synthesize scrollViewSelectedChannelID;
@synthesize slideSwitchViewDelegate;
@synthesize tabItemNormalColor;
@synthesize tabItemSelectedColor;
@synthesize tabItemNormalBackgroundImage;
@synthesize tabItemSelectedBackgroundImage;
@synthesize shadowImage = _shadowImage;
@synthesize viewArray = _viewArray;
@synthesize rigthSideButton = _rigthSideButton;

#pragma mark - 初始化参数

- (void)initValues
{
    kSystemIsIOS7 ? (kHeightOfTopScrollView = 44) : (kHeightOfTopScrollView = 44);
    
    //创建顶部可滑动的tab
    self.topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 44)];
    topScrollView.delegate = self;
    topScrollView.backgroundColor = kAppRedColor;
    topScrollView.scrollEnabled = YES;
    topScrollView.pagingEnabled = YES;
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.showsVerticalScrollIndicator = NO;
    //    self.topScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //    UIView *backgroundView = nil;
    //    UIImageView *imgs = nil;
    //
    //    if (kSystemIsIOS7) {
    //        backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 32)];
    //        imgs = [[UIImageView alloc]init];
    //        imgs.frame = CGRectMake(0,0, kScreenBounds.size.width+8,32);
    //    }
    //    else{
    //        backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenBounds.size.width, 32)];
    //        imgs = [[UIImageView alloc]init];
    //        imgs.frame = CGRectMake(0,0, kScreenBounds.size.width+8,32);
    //    }
    ////    [imgs setBackgroundColor:[UIColor yellowColor]];
    //    [backgroundView addSubview:imgs];
    //    [imgs release];
    
    //    [self.topScrollView addSubview:backgroundView];
    //    [backgroundView release];
    
    
    [self addSubview:self.topScrollView];
    //    [self.topScrollView release];
    
    _userSelectedChannelID = 100;
    
    //创建主滚动视图
    if(kSystemIsIOS7)
        self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView+20)];
    else
        self.rootScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kHeightOfTopScrollView, self.bounds.size.width, self.bounds.size.height - kHeightOfTopScrollView+20)];
    
    //    [[ConstObject instance] setRootScrollView:self.rootScrollView];
    self.rootScrollView.delegate = self;
    self.rootScrollView.pagingEnabled = YES;
    self.rootScrollView.userInteractionEnabled = YES;
    self.rootScrollView.bounces = NO;
    self.rootScrollView.showsHorizontalScrollIndicator = NO;
    self.rootScrollView.showsVerticalScrollIndicator = NO;
    self.rootScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    _userContentOffsetX = 0;
    [self.rootScrollView.panGestureRecognizer addTarget:self action:@selector(scrollHandlePan:)];
    [self addSubview:self.rootScrollView];
    //    [self.rootScrollView release];
    
    _viewArray = [[NSMutableArray alloc] init];
    _isBuildUI = NO;
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initValues];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initValues];
    }
    return self;
}

#pragma mark getter/setter

- (void)setRigthSideButton:(UIButton *)rigthSideButton
{
    
    UIButton *button = (UIButton *)[self viewWithTag:kTagOfRightSideButton];
    [button removeFromSuperview];
    rigthSideButton.tag = kTagOfRightSideButton;
    _rigthSideButton = rigthSideButton;
    [self addSubview:_rigthSideButton];
}

#pragma mark - 创建控件

//当横竖屏切换时可通过此方法调整布局
- (void)layoutSubviews
{
    //创建完子视图UI才需要调整布局
    if (_isBuildUI) {
        //如果有设置右侧视图，缩小顶部滚动视图的宽度以适应按钮
        if (self.rigthSideButton.bounds.size.width > 0) {
            _rigthSideButton.frame = CGRectMake(self.bounds.size.width - self.rigthSideButton.bounds.size.width, 0,
                                                
                                                _rigthSideButton.bounds.size.width, self.topScrollView.bounds.size.height);
            
            //            self.topScrollView.frame = CGRectMake(0, 0,
            //                                              self.bounds.size.width - self.rigthSideButton.bounds.size.width, kHeightOfTopScrollView);
            self.topScrollView.frame = CGRectMake(0, 0,
                                                  kScreenBounds.size.width , kHeightOfTopScrollView);
        }
        
        //更新主视图的总宽度
        [self.rootScrollView setFrame:CGRectMake(0, kHeightOfTopScrollView, kScreenBounds.size.width, kScreenBounds.size.height)];
        self.rootScrollView.contentSize = CGSizeMake(kScreenBounds.size.width * [_viewArray count], 0);
        
        //更新主视图各个子视图的宽度
        for (int i = 0; i < [_viewArray count]; i++) {
            UIViewController *listVC = _viewArray[i];
            listVC.view.frame = CGRectMake(0+self.rootScrollView.bounds.size.width*i, 0,
                                           self.rootScrollView.bounds.size.width, self.rootScrollView.bounds.size.height);
        }
        
        //滚动到选中的视图
        [self.rootScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.bounds.size.width, 0) animated:NO];
        [self.topScrollView setContentOffset:CGPointMake((_userSelectedChannelID - 100)*self.bounds.size.width/4, 0) animated:NO];
        //调整顶部滚动视图选中按钮位置
        UIButton *button = (UIButton *)[self.topScrollView viewWithTag:_userSelectedChannelID];
        [self adjustScrollViewContentX:button];
    }
}

/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */

- (void)buildUI
{
    
    _shadowImageView = [[UIImageView alloc] init];
    [_shadowImageView setImage:_shadowImage];
    [topScrollView addSubview:_shadowImageView];
    
    NSUInteger number = [self.slideSwitchViewDelegate numberOfTab:self];
    for (int i=0; i<number; i++) {
        UIViewController *vc = [self.slideSwitchViewDelegate slideSwitchView:self viewOfTab:i];
        [_viewArray addObject:vc];
        [self.rootScrollView addSubview:vc.view];
    }
    [self createNameButtons];
    
    //选中第一个view
    if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
        [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
    }
    _isBuildUI = YES;
    
    //创建完子视图UI才需要调整布局
    [self setNeedsLayout];
    
    UIButton *lastButton = (UIButton *)[self.topScrollView viewWithTag:_userSelectedChannelID];
    [self selectNameButton:lastButton];
}

/*!
 * @method 初始化顶部tab的各个按钮
 * @abstract
 * @discussion
 * @param
 * @result
 */

- (void)createNameButtons{
    CGFloat xOffset = 30;
    
    //    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [menuButton setImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    //    [menuButton setImage:[UIImage imageNamed:@"menuButtonLighted.png"] forState:UIControlStateHighlighted];
    //    [menuButton addTarget:self action:@selector(toShowMenu) forControlEvents:UIControlEventTouchUpInside];
    //    if(kSystemIsIOS7)
    //        [menuButton setFrame:CGRectMake(0, 18, 45, 45)];
    //    else
    //        [menuButton setFrame:CGRectMake(0, 0, 45, 45)];
    //    [self.topScrollView addSubview:menuButton];
    
    //每个tab偏移量
    for (int i = 0; i < [_viewArray count]; i++) {
        UIViewController *vc = _viewArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSString *buttonTitle = nil;
        buttonTitle = [NSString stringWithFormat:@"%@",vc.title];
        [button setFrame:CGRectMake(xOffset,0,
                                    (kScreenWidth-60)/[_viewArray count], kHeightOfTopScrollView)];
        [button setTag:i+100];
        
        [button setTitle:buttonTitle forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        //   [_commentButton setTitleColor:COLOR(20, 74, 136) forState:UIControlStateNormal];
        //        [button setTitleColor: COLOR1(6, 72, 131) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectNameButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollView addSubview:button];
        //        [button setBackgroundColor:COLOR(0xe6, 0x32, 0x14)];
        xOffset +=(kScreenBounds.size.width-60)/[_viewArray count];
        if (i == 0) {
            
            if(iPhone5){
                
                _shadowImageView.frame = CGRectMake(24+11, 41,  _shadowImage.size.width, _shadowImage.size.height);
            }else
                _shadowImageView.frame = CGRectMake(24+11, 41,  _shadowImage.size.width, _shadowImage.size.height);
            button.selected = YES;
        }
        
        
    }
    
    
    //设置顶部滚动视图的内容总尺寸
    self.topScrollView.contentSize = CGSizeMake([_viewArray count]*kScreenBounds.size.width/3, kHeightOfTopScrollView);
}

#pragma mark --返回主页左侧栏

//返回主页左侧栏
-(void)toShowMenu{
    //    [MobClick event:@"left_menu_count"];
    if (self.slideSwitchViewDelegate
        && [self.slideSwitchViewDelegate respondsToSelector:@selector(tabMenuButton)]) {
        
        [self.slideSwitchViewDelegate tabMenuButton];
        
    }
}


#pragma mark - 顶部滚动视图逻辑方法

/*!
 * @method 选中tab时间
 * @abstract
 * @discussion
 * @param 按钮
 * @result
 */
- (void)selectNameButton:(UIButton *)sender
{
    //如果点击的tab文字显示不全，调整滚动视图x坐标使用使tab文字显示全
    [self adjustScrollViewContentX:sender];
    //如果更换按钮
    if (sender.tag != _userSelectedChannelID) {
        //取之前的按钮
        UIButton *lastButton = (UIButton *)[self.topScrollView viewWithTag:_userSelectedChannelID];
        lastButton.selected = NO;
        //赋值按钮ID
        _userSelectedChannelID = sender.tag;
    }else{
        
        //没有更换的话 判断是否超过10秒 （回到顶部并刷新数据）
    }
    
    //按钮选中状态
    if (!sender.selected) {
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            //            if([_viewArray count] == 2){
            //                if(kSystemIsIOS7){
            //                    _shadowImageView.frame = CGRectMake(sender.frame.origin.x-16, 28, 90, _shadowImage.size.height);
            //                }else{
            //
            //                    _shadowImageView.frame = CGRectMake(sender.frame.origin.x-16, 11, 90, _shadowImage.size.height);
            //                }
            //
            //            }
            //            else{
            //                if(kSystemIsIOS7){
            //                    if(sender.tag == 102){
            //                        [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x-10, 28, 42, _shadowImage.size.height)];
            //                    }
            //                    else{
            //                        if (sender.tag == 103) {
            //                            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x-7.5, 28, 60, _shadowImage.size.height)];
            //                        }
            //                        else{
            
//            NSString *buttonStr = sender.titleLabel.text;
            
            _shadowImageView.centerX = sender.centerX;
            
            if(iPhone5){
                //3个tab
//                [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x+7, 41, _shadowImage.size.width, _shadowImage.size.height)];
            }else{
            
//                 [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x+7, 41, _shadowImage.size.width, _shadowImage.size.height)];
            }
//            if([_viewArray count]==2){
//            
//                if([buttonStr isEqualToString:@"内容"]||[buttonStr isEqualToString:@"用户"]){
//                    if(iPhone5){
//                        [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x+27, 42, _shadowImage.size.width, _shadowImage.size.height)];
//                    else
//                        [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x+44, 42, _shadowImage.size.width, _shadowImage.size.height)];
//                }else
//                    [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x+30, 42, _shadowImage.size.width, _shadowImage.size.height)];
//            }else
//                [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x+20, 42, _shadowImage.size.width, _shadowImage.size.height)];
            
            //                        }
            //                    }
            //
            //                }else{
            //                    if(sender.tag == 102){
            //                        [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x-8, 11, 42, _shadowImage.size.height)];
            //                    }
            //                    else{
            //                        if (sender.tag == 103) {
            //                            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x-7.5, 11, 60, _shadowImage.size.height)];
            //                        }
            //                        else{
            //                            [_shadowImageView setFrame:CGRectMake(sender.frame.origin.x-7.5, 11, 42, _shadowImage.size.height)];
            //                        }
            //
            //                    }
            //                }
            //
            //            }
        } completion:^(BOOL finished) {
            if (finished) {
                //设置新页出现
                if (!_isRootScroll) {
                    [self.rootScrollView setContentOffset:CGPointMake((sender.tag - 100)*self.bounds.size.width, 0) animated:NO];
                }
                _isRootScroll = NO;
                
                if (self.slideSwitchViewDelegate && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:didselectTab:)]) {
                    [self.slideSwitchViewDelegate slideSwitchView:self didselectTab:_userSelectedChannelID - 100];
                }
            }
        }];
        
    }
    //重复点击选中按钮
    else {
        
    }
    
    _isRootScroll = NO;
}

/*!
 * @method 调整顶部滚动视图x位置
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)adjustScrollViewContentX:(UIButton *)sender
{
    //    如果 当前显示的最后一个tab文字超出右边界
    if (sender.frame.origin.x - self.topScrollView.contentOffset.x > self.bounds.size.width - (kWidthOfButtonMargin+sender.bounds.size.width)) {
        //向左滚动视图，显示完整tab文字
        [self.topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - (self.topScrollView.bounds.size.width- (kWidthOfButtonMargin+sender.bounds.size.width)), 0)  animated:YES];
    }
    
    //如果 （tab的文字坐标 - 当前滚动视图左边界所在整个视图的x坐标） < 按钮的隔间 ，代表tab文字已超出边界
    if (sender.frame.origin.x - self.topScrollView.contentOffset.x < kWidthOfButtonMargin) {
        //向右滚动视图（tab文字的x坐标 - 按钮间隔 = 新的滚动视图左边界在整个视图的x坐标），使文字显示完整
        [self.topScrollView setContentOffset:CGPointMake(sender.frame.origin.x - kWidthOfButtonMargin, 0)  animated:YES];
    }
}

#pragma mark 主视图逻辑方法

//滚动视图开始时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView == self.rootScrollView) {
        _userContentOffsetX = scrollView.contentOffset.x;
    }
}

//滚动视图结束
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    if (scrollView == self.rootScrollView) {
    //        //判断用户是否左滚动还是右滚动
    //        if (_userContentOffsetX < scrollView.contentOffset.x) {
    //            _isLeftScroll = YES;
    //        }
    //        else {
    //            _isLeftScroll = NO;
    //        }
    //    }
}

//滚动视图释放滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.rootScrollView) {
        _isRootScroll = YES;//调整顶部滑条按钮状态
        NSLog(@"xxx:%f",scrollView.contentOffset.x);
        int tag = buttonTags;
        //        if ([_viewArray count] != 2) {
        //            if(tag == 0)
        //                tag = 100;
        //        }
        //        else{
        if(tag == 0)
            tag = 100;
        //        }
        
        buttonTags = (int)scrollView.contentOffset.x/self.bounds.size.width +100;
        UIButton *button = (UIButton *)[self.topScrollView viewWithTag:buttonTags];
        if(tag != buttonTags)//防止滑倒最左边还调用首页刷新
            [self selectNameButton:button];
    }
}

//传递滑动事件给下一层
-(void)scrollHandlePan:(UIPanGestureRecognizer*) panParam
{
    //当滑道左边界时，传递滑动事件给代理
    //    if(self.rootScrollView.contentOffset.x <= 0) {
    //        if (self.slideSwitchViewDelegate
    //            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panLeftEdge:)]) {
    //            [self.slideSwitchViewDelegate slideSwitchView:self panLeftEdge:panParam];
    //        }
    //    } else if(self.rootScrollView.contentOffset.x >= self.rootScrollView.contentSize.width - self.rootScrollView.bounds.size.width) {
    //        if (self.slideSwitchViewDelegate
    //            && [self.slideSwitchViewDelegate respondsToSelector:@selector(slideSwitchView:panRightEdge:)]) {
    //            [self.slideSwitchViewDelegate slideSwitchView:self panRightEdge:panParam];
    //        }
    //    }
}

#pragma mark - 工具方法

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}



-(void)dealloc
{
    //    [rootScrollView release];
    //    [topScrollView release];
    //    [tabItemNormalBackgroundImage release];
    //    [tabItemSelectedBackgroundImage release];
    //    [_shadowImage release];
    //    [_rigthSideButton release];
    //    [_viewArray release];
    
    [super dealloc];
}


@end
