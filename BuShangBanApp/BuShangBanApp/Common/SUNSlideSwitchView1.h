//
//  SUNSlideSwitchView.h
//  SUNCommonComponent
//
//
//  
//


@protocol SUNSlideSwitchView1Delegate;
@interface SUNSlideSwitchView1 : UIView<UIScrollViewDelegate>
{
    UIScrollView *rootScrollView;                  //主视图
    UIScrollView *topScrollView;                   //顶部页签视图
    
    CGFloat     _userContentOffsetX;
    BOOL        _isLeftScroll;                             //是否左滑动
    BOOL        _isRootScroll;                             //是否主视图滑动
    BOOL        _isBuildUI;                                //是否建立了ui
    
    NSInteger   _userSelectedChannelID;               //点击按钮选择名字ID
    
    UIImageView *_shadowImageView;
    UIImage     *_shadowImage;
    
    UIColor     *_tabItemNormalColor;                   //正常时tab文字颜色
    UIColor     *_tabItemSelectedColor;                 //选中时tab文字颜色
    UIImage     *_tabItemNormalBackgroundImage;         //正常时tab的背景
    UIImage     *_tabItemSelectedBackgroundImage;       //选中时tab的背景
    NSMutableArray *_viewArray;                     //主视图的子视图数组
    
    UIButton    *_rigthSideButton;                     //右侧按钮
    
    id<SUNSlideSwitchView1Delegate> _slideSwitchViewDelegate;
    UIImageView *newestCountImageView;              //有多少最新的问题
    float       kHeightOfTopScrollView;                   //顶部导航高度
    UILabel     *tipLabel;                              //更新到的提问数
    int         buttonTags;                         //通过计算scrollview偏移量得到的tag
}

@property (nonatomic, retain) UIScrollView *rootScrollView;
@property (nonatomic, retain)  UIScrollView *topScrollView;
@property (nonatomic, assign) CGFloat userContentOffsetX;
@property (nonatomic, assign) NSInteger userSelectedChannelID;
@property (nonatomic, assign) NSInteger scrollViewSelectedChannelID;
@property (nonatomic, assign) IBOutlet id<SUNSlideSwitchView1Delegate> slideSwitchViewDelegate;
@property (nonatomic, retain) UIColor *tabItemNormalColor;
@property (nonatomic, retain) UIColor *tabItemSelectedColor;
@property (nonatomic, retain) UIImage *tabItemNormalBackgroundImage;
@property (nonatomic, retain) UIImage *tabItemSelectedBackgroundImage;
@property (nonatomic, retain) UIImage *shadowImage;
@property (nonatomic, retain) NSMutableArray *viewArray;
@property (nonatomic, retain) IBOutlet UIButton *rigthSideButton;

/*!
 * @method 创建子视图UI
 * @abstract
 * @discussion
 * @param
 * @result
 */
- (void)buildUI;

/*!
 * @method 通过16进制计算颜色
 * @abstract
 * @discussion
 * @param 16机制
 * @result 颜色对象
 */
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;

@end

@protocol SUNSlideSwitchView1Delegate <NSObject>

@required

/*!
 * @method 顶部tab个数
 * @abstract
 * @discussion
 * @param 本控件
 * @result tab个数
 */
- (NSUInteger)numberOfTab:(SUNSlideSwitchView1 *)view;

/*!
 * @method 每个tab所属的viewController
 * @abstract
 * @discussion
 * @param tab索引
 * @result viewController
 */
- (UIViewController *)slideSwitchView:(SUNSlideSwitchView1 *)view viewOfTab:(NSUInteger)number;

@optional

/*!
 * @method 滑动左边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result 
 */
- (void)slideSwitchView:(SUNSlideSwitchView1 *)view panLeftEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 滑动右边界时传递手势
 * @abstract
 * @discussion
 * @param   手势
 * @result
 */
- (void)slideSwitchView:(SUNSlideSwitchView1 *)view panRightEdge:(UIPanGestureRecognizer*) panParam;

/*!
 * @method 点击tab
 * @abstract
 * @discussion
 * @param tab索引
 * @result 
 */
- (void)slideSwitchView:(SUNSlideSwitchView1 *)view didselectTab:(NSUInteger)number;

//点击左上角滑出侧边栏
- (void)tabMenuButton;

//最新提问数
-(void)updateLastedQusetionCount;

//最新消息数
-(void)updateNewMessageCount;

@end
