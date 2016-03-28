//
//  ConstObject.m
//  ChuanDaZhi
//
//  Created by Lee xiaohui on 12-5-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ConstObject.h"

@implementation ConstObject
@synthesize homeViewController;
@synthesize sinaLoginFrom,qqLoginFrom;

@synthesize questionID;
@synthesize questionText;
@synthesize isFromQusetionToAnswer;
@synthesize questionFocus;
@synthesize askQuestionInfo;
@synthesize teacherName;
@synthesize personalInfo;
@synthesize searchResultArray;
@synthesize selectIndex;
@synthesize answerInfoDic;
@synthesize userInfoDics;
@synthesize selectTeacherID;
@synthesize publishedUid;
@synthesize personalInfoDics;
@synthesize localTagArray;
@synthesize certainTagText;
@synthesize tagssArray;
@synthesize countrySelectedTag;
@synthesize countrySelectedTagArray;
@synthesize identitySelectedTag;
@synthesize itemsArray;
@synthesize recentlyQuestionID;
@synthesize countryArray;


@synthesize isLogin,isFromQQFriendsInvite,isFromWXFriendsInvite,isHavePic,isWXFromExchangeGoodsPage,isWXFromZaShiWuPage,isWXFromFreeUseGoodsPage,isAddCoins_ExchangeGoodsSinaShare,isAddCoins_ExchangeGoodsTencentShare,isAddCoins_ExchangeGoodsWXShare,isAddCoins_ZaShiWuSinaShare,isAddCoins_ZaShiWuTencentShare,isAddCoins_ZaShiWuWXShare,isAddCoins_FreeUseGoodsWXShare,isAddCoins_FreeUseGoodsSinaShare,isAddCoins_FreeUseGoodsTencentShare,isReloadProductDetailData,isFromZaShiWuView,isFromFreeUseDetailPage,isFromExchangeGoodsPage,questionDetailWXShare,isQuestionDeatailQQShare,isQuestionDeatailWXFriOrWXCircleShare,isSystemMess_TQRichTextView,isSystemMessTitle_TQRichTextView,isBeforeWXFromFreeUseGoods,noShareWX_FreeUseApply;
@synthesize clickFrom;
@synthesize questionCount;
@synthesize messageCount;
@synthesize isHomePage;
@synthesize coinNumber,eggCoinCount;
@synthesize mainNavigationController;
@synthesize jinDanPic,userLocationInfo;
@synthesize jinDanTitle;
@synthesize reLoadHomeData,reLoadMessageData,reLoadWealthData,reLoadFreeUseData,reLoadMallData,reLoadSetData,reLoadProfileData,isReloadDiaryList,removeTQTextDelegate;
@synthesize isReloadCoins;
@synthesize DanImageString;
@synthesize afterImageString;
@synthesize tipString;
@synthesize upgradeGifString;
@synthesize tuisongDic;
@synthesize isReloadData_MyFreeUsePage,photoRectFromZero,isNewUser;
@synthesize yuanxiaoSearchText;

@synthesize lowschoolRank;
@synthesize highschoolRank;
@synthesize  is_private ;//选择的学校类型 0 全不选或者全选 1 私立 2公立
@synthesize  is_jisu ;//选择的学校类型 0 全不选或者全选 1 私立寄宿 2私立走读

@synthesize need_toefls;
@synthesize need_SATs;
@synthesize isietlsaccepteds;

@synthesize lowSATaccept_average;
@synthesize highSATaccept_average;
@synthesize lowtoeflaccept_average;
@synthesize hightoeflaccept_average;

@synthesize lowusnewsranking;
@synthesize highusnewsranking;

@synthesize lowusnewsnational_ranking;
@synthesize highusnewsnational_ranking;

@synthesize lowqsrank;
@synthesize highqsrank;

@synthesize lowthetimes_ranking;
@synthesize highthetimes_ranking;
@synthesize lowsjtuglobal;
@synthesize highsjtuglobal;

@synthesize isspringapplication_accepteds;
@synthesize is_EAs;
@synthesize is_EDs;

@synthesize need_toefls2;
@synthesize need_SATs2;
@synthesize isietlsaccepteds2;

@synthesize lowSATaccept_average2;
@synthesize highSATaccept_average2;
@synthesize lowAPcount;
@synthesize hightAPcount;

@synthesize lownationStudent;
@synthesize highnationStudent;

@synthesize lowfee;
@synthesize highfee;

@synthesize needSEL;
@synthesize isSpringAccept;

@synthesize lowyasNum;
@synthesize highyasNum;
@synthesize lowSchoolRank;
@synthesize highSchoolRank;


//@synthesize imagePickerBar,urlArray,totalSelectedCount,returnToWhichPage,rectFromZero,rootScrollView,photoTipButton,hasAlertLogin,networkIsAvailable,presentLoginController;

+ (id)instance {
	static id obj = nil;
	if( nil == obj ) {
		obj = [[self alloc] init];
	}
	return obj;
}

- (id)init {
	if ((self = [super init])) {
        self.tagssArray = [NSMutableArray arrayWithCapacity:1];
	}
    
    return self;
}

- (void)setIsLogin:(BOOL)isThirdLogin{
    [[NSUserDefaults standardUserDefaults] setBool:isThirdLogin forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isLogin{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"] boolValue];
}

- (NSString*)fileTextPath:(NSString*)fileName{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

-(void)dealloc
{
    
    [super dealloc];
}

@end
