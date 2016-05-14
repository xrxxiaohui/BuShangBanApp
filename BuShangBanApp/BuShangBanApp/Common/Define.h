//
//  Define.h
//  BeautyMakeup
//
//  Created by hers on 13-11-5.
//  Copyright (c) 2013年 hers. All rights reserved.
//

//定义屏幕
#define kScreenBounds          [[UIScreen mainScreen] bounds]
//#define kScreenWidth           [[UIScreen mainScreen] bounds].size.width
//#define kScreenHeight          [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth1           [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight1          [[UIScreen mainScreen] bounds].size.height

#define APP_CHANNEL @"App Store"

#define kPushLoginViewNotification  @"PushLoginViewNotification"
#define kNeedRefreshQuestionInfoNotification @"NeedRefreshQuestionInfoNotification"
#define kLoginOutNotification  @"LoginOutNotification"
#define kNewSegmentControllerNeedNotification   @"NewSegmentControlNeedNotification"
#define kPersonalDismissKeyboardNotification @"PersonalDismissKeyboardNotification"
#define kDismissKeyboardNotification    @"DismissKeyboardNotification"

#define kLogoutAccoutNotification   @"LogoutAccoutNotification"

#define kIsShowFlowTipsMaskView @"IsShowFlowTipsMaskView"

#define kApplicationWillEnterForegroundNotification @"ApplicationWillEnterForegroundNotification"

#define SafeForString(string) ((string && [string isKindOfClass:[NSString class]]) ? string :@"")
#define SafeForDictionary(dictionary) ((dictionary && [dictionary isKindOfClass:[NSDictionary class]]) ? dictionary : @{})
#define SafeForArray(array) ((array && [array isKindOfClass:[NSArray class]])? array : @[])


//iPhone5 定义
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6p ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

//iPhone4 定义
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)


#define SystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//判断是否是ios7系统
#define kSystemIsIOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7


//#define Links @"http://app.xjlastmile.com/"
#define kIsWifiEnable     [CheckNetwork IsEnableWIFI]


#pragma mark---
#pragma mark---font

//定义字体
#define kFontArial22 [UIFont fontWithName:@"Arial" size:22]
#define kFontArial17 [UIFont fontWithName:@"Arial" size:17]
#define kFontArial16 [UIFont fontWithName:@"Arial" size:16]
#define kFontArial15 [UIFont fontWithName:@"Arial" size:15]
#define kFontArial14 [UIFont fontWithName:@"Arial" size:14]
#define kFontArial13 [UIFont fontWithName:@"Arial" size:13]
#define kFontArial12 [UIFont fontWithName:@"Arial" size:12]
#define kFontArial11 [UIFont fontWithName:@"Arial" size:11]
#define kFontArial8 [UIFont fontWithName:@"Arial" size:8]

//定义项目红，绿 两种主基调颜色
#define kRedColor [UIColor colorWithRed:255.0f/255.0f green:114.0f/255.0f blue:114.0f/255.0f alpha:1.0f]
#define kGreenColor [UIColor colorWithRed:116.0f/255.0f green:209.0f/255.0f blue:187.0f/255.0f alpha:1.0f]
#define kDarkGreenColor [UIColor colorWithRed:113.0f/255.0f green:138.0f/255.0f blue:130.0f/255.0f alpha:1.0f]
#define kGrayColor  [UIColor colorWithRed:186.0f/255.0f green:189.0f/255.0f blue:196.0f/255.0f alpha:1];
#define RGBCOLOR(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define KAvatarUrl @"http://www.shunshunliuxue.com/uploads/avatar/%@"

#define KCdnUrl @"http://cdn.shunshunliuxue.com/%@/%@"

#define kTopic @"topic"

#define SSURLWithString(str) [NSURL URLWithString:str]

//大搜索
#define kSearchResignResponse  @"resignFirstR"
//邀请
#define kYaoQingResignResponse @"resignFirstR"
//重新加载QuestionList页面
#define LoadQuestionListData    @"loadAnswerListData"
#define kAdviserAnswer          @"/people/api/user_answer/?"
#define kServerExperience       @"/consultant/api/advisor_experience/?"
#define kReputationTopics       @"/consultant/api/reputation_topics/?"





#pragma --mark ============== 接口数据请求 ==============
#define avatarUrl     @"http://www.shunshunliuxue.com/uploads/avatar/"

//请求前缀
#define kHeader @"http://apitemp.shunshunliuxue.com"
//#define kServerHeader @"http://api.shunshunliuxue.com"
//#define kHeader @"http://123.57.2.117"
#define kTestUrl @"http://apitest.shunshunliuxue.com" // apitest
//#define kTestUrl @"http://api.shunshunliuxue.com" // apitest


#define kRegister      @"%@/account/api/register_process/?"
#define kLogin         @"%@/account/api/login_process/?"
#define kYanZhengMa    @"%@/account/api/send_sms/?"
#define kCategoryUrl   @"%@/topic/api/topic_catalog/?"
#define kUserInfo      @"%@/account/api/get_user_info/?"
#define kAdvisorList   @"/consultant/api/advisor_list/?"
#define kAdvisorServerCase @"/consultant/api/advisor_tags/?"
#define kAdvisorDetail @"/consultant/api/advisor/?"
#define kAdvisorListSearch @"%@/search/api/search_advisor/"

#define kYuyue @"%@/home/api/subscribe_list/?"
#define kFenPei @"%@/home/api/potential_list/?"

//需要传token
#define kQuestionUrl   @"%@/question/api/question_list/?sort_type=%@&topic_id=%@&page=%@&token=%@"
//ta的动态
#define kUserActionUrl   @"%@/people/api/user_actions/?"
//我的动态
#define kMyActionUrl   @"%@/home/api/activity_list/?"

//messageList
#define kMessageList   @"%@/inbox/api/get_message_list/"
//点赞 取消点赞
#define kVoteTheAnswer @"%@/question/api/answer_vote/?answer_id=%@&token=%@&value=1"
//问题info
#define kQuestionInfo  @"%@/question/api/question/?id=%@&page=%@&token=%@"
//关注问题
#define kCareQuestion  @"%@/question/api/focus/?question_id=%@&token=%@"
//添加回答  attach_access_key暂时没有写
#define kSaveAnswer    @"%@/question/api/save_answer/?"

//编辑修改回答  attach_access_key meiyou xie
#define kUpdateAnswer  @"%@/question/api/update_answer/?"
//编辑修改问题
#define kUpdateQuestion  @"%@/publish/api/modify_question/?"
//举报问题
#define kReportQuestion  @"%@/question/api/report_question/?"

//hot_topic
#define kHotTopic      @"%@/topic/api/hot_topics/?"
//focus_topics_list
#define kFocusTopic    @"%@/home/api/focus_topics_list/?page=%@&token=%@"

// 预约咨询
#define kSubscribeConsult @"%@/account/api/subscribe_customer_insert/?"

//关注
#define kFollowPeople    @"%@/follow/api/follow_people/"
//focus_topic
#define kSSFocusTopic    @"%@/topic/api/focus_topic/"
//http://api.shunshunliuxue.com/topic/api/check_focus/
//搜索
#define kSearchTeacher @"%@/search/api/search/?"
//邀请
#define kInvite        @"%@/question/api/save_invite/?"

//focus_question_list
#define kFocusTopicList     @"%@/home/api/focus_topics_list/?"
//focus_question_list
#define kFocusQuestionList  @"%@/home/api/focus_question_list/?"
//get_user_friends
#define kFocusFriendList    @"%@/follow/api/get_user_friends/?"

//我的粉丝
#define kMFansList          @"%@/follow/api/get_user_fans/?"

//我的提问
#define kFocusUserQuestion  @"%@/people/api/user_question/?"
//发布问题
#define kFaBuQuestion @"%@/publish/api/publish_question/?"
//我的回答
#define kFocusUserAnswer  @"%@/people/api/user_answer/?"
#define kQuestionList @"/question/api/question_list/?"

#define kPersonalList @"%@/people/api/space/?"
#define kAllAnswerDetail @"%@/question/api/get_answer_info/?"

#define kMyDongTai @"%@/people/api/user_actions/"



//定义请求数据长度
#define kCount @"10"

#define kFreshQuestionData @"FreshQuestionData"

#define kNeedRefreshMessageNotification @"NeedRefreshMessageNotification"

#define kDefaultBiLi kScreenWidth/414

#define DCBlockRun(block) if (block) { block(); }

//#define kYuanXiaoKu @"http://crptest1.shunshunliuxue.com:3001/uscollege"
#define kYuanXiaoKu @"http://mobile.api.shunshunliuxue.com/uscollege"

#define kMessageListWithUser @"http://apitemp.shunshunliuxue.com/inbox/api/get_talking/"

//#define kFind

// 发送消息
#define kSendMessage @"http://apitemp.shunshunliuxue.com/inbox/api/send/"

/** 上传token*/
#define kPostToken @"http://apitemp.shunshunliuxue.com/account/api/login_process/"
/** 法律信息H5页*/
#define kLawInfo @"http://api.shunshunliuxue.com/m/client/servies/"

#define kHire @"http://www.shunshunliuxue.com/m/client/hire/"
/** 关于顺顺H5页*/
#define kAboutShunshun @"http://www.shunshunliuxue.com/m/about/"

/** 意见反馈接口*/
#define kAdviceFeedback @"http://apitemp.shunshunliuxue.com/about/api/feedback/"

/** 首页三个链接*/
//#define kAboutShunshun @"http://api.shunshunliuxue.com/m/about/"

#define kKeHuBao @"http://khbm.shunshunliuxue.com/"

//#define kAboutShunshun @"http://api.shunshunliuxue.com/m/about/"
#define top_H 64

#define BACK_X 0
#define BACK_Y 5
#define BACK_WEITH 30
#define BACK_HIGHT 30

#define OTHERBTN_X 0
#define OTHERBTN_Y 5
#define OTHERBTN_WEITH 30
#define OTHERBTN_HIGHT 30

#define LOGIN_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"png"]]

#define LOGIN_BG_568h [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_568h" ofType:@"png"]]

#define INPUT_BG [UIImage imageNamed:@"input_bg"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input_bg" ofType:@"png"]]

#define INPUT_BG_Text [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input_bg_text" ofType:@"png"]]

#define ACCOUNT_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"account" ofType:@"png"]]
#define PASSWORD_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"password" ofType:@"png"]]
#define LOGIN_BTN_BG [UIImage imageNamed:@"login_btn_bg"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"login_btn_bg" ofType:@"png"]]

#define WINXIN_LOGIN_BG [UIImage imageNamed:@"weixin"]// [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weixin" ofType:@"png"]]
#define QQ_LOGIN_BG [UIImage imageNamed:@"QQ"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QQ" ofType:@"png"]]

#define BACK_IMAGE [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"leftReturn" ofType:@"png"]]
#define CANCLE_IMAGE [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"close" ofType:@"png"]]
#define LOGIN_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg" ofType:@"png"]]

#define LOGIN_BG_568h [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bg_568h" ofType:@"png"]]

#define INPUT_BG [UIImage imageNamed:@"input_bg"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input_bg" ofType:@"png"]]
#define COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define INPUT_BG_Text [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"input_bg_text" ofType:@"png"]]

#define ACCOUNT_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"account" ofType:@"png"]]
#define PASSWORD_BG [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"password" ofType:@"png"]]
#define LOGIN_BTN_BG [UIImage imageNamed:@"login_btn_bg"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"login_btn_bg" ofType:@"png"]]

#define WINXIN_LOGIN_BG [UIImage imageNamed:@"weixin"]// [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"weixin" ofType:@"png"]]
#define QQ_LOGIN_BG [UIImage imageNamed:@"QQ"]//[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QQ" ofType:@"png"]]

#define BACK_IMAGE [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"leftReturn" ofType:@"png"]]
#define CANCLE_IMAGE [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"close" ofType:@"png"]]
#define COLOR1(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kCommonBottomLineColor COLOR1(227, 227, 227)
#define kAppRedColor COLOR(0xe6, 0x32, 0x14)
#define kTabBtnSelectedColor COLOR(0xff, 0x3e, 0x30)
#define kTabBtnNormalColor COLOR(56, 56, 56)

//cell accessoryType
#define CellAccessoryNone @"UITableViewCellAccessoryNone"                   // don't show any accessory view
#define CellAccessoryDisclosureIndicator @"UITableViewCellAccessoryDisclosureIndicator"    // regular chevron. doesn't track
#define CellAccessoryDetailDisclosureButton @"UITableViewCellAccessoryDetailDisclosureButton" // blue button w/ chevron. tracks
#define CellAccessoryCheckmark @"UITableViewCellAccessoryCheckmark"

#define kCellSegue @"kCellSegue" //cell要跳转的

#pragma mark - 宏定义键
#define kDeviceToken @"DeviceTokenForMiPush"
#define kRefreshLeftView @"refreshLeftView"

#define KRefreshPersonData @"KRefreshPersonData"
#define UMENG_APPKEY @"55f949b9e0f55a3d01003987"

#define kUserName @"username"
#define kUserIcon @"usericon"
#define kMessageNotification @"MessageNotification"
#define kUserInfoDic @"UserInfoDic"
#define kPersonalInfoDic @"kPersonalInfoDic"
#define SaveUserTag @"SaveUserTag"  //问答资讯页
#define kLoginStatus @"loginStatus"
#define kSessionToken @"sessionToken"
#define kObjectID @"objectID"

//1已登录


