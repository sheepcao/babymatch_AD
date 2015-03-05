//
//  globalVar.h
//  completeImage
//
//  Created by 张力 on 14-6-25.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#ifndef completeImage_globalVar_h
#define completeImage_globalVar_h

#define IPhoneHeight (([UIScreen mainScreen].bounds.size.height == 568.0)?568:460)
#define TIME_PARENT 120

#define bigLevel 5


#import <iAd/iAd.h>
#import "GoogleMobileAds/GADBannerView.h"
#define ADMOB_ID @"ca-app-pub-3074684817942615/4079653086"
#define ADMOB_ID_DaysInLine @"ca-app-pub-3074684817942615/1126186689"
//#import <ShareSDK/ShareSDK.h>
#import "CommonUtility.h"
#import "MobClick.h"
#import "UMSocial.h"


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

int level ;
NSNumber *levelSaved;
int levelTop;
NSMutableArray *haveShared;
NSMutableArray *scores;
NSString *haveSharedString;
int seconds;
BOOL isAnimating;

NSArray *sharePic;
NSArray *sharePic480;


@protocol  backToLevelDelegate<NSObject>

-(BOOL) isFromReward :(BOOL)check;
@end



#endif
