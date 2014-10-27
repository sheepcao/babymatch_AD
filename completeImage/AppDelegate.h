//
//  AppDelegate.h
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globalVar.h"
#import "GADInterstitial.h"



@interface AppDelegate : UIResponder <UIApplicationDelegate,GADInterstitialDelegate>
{
    GADInterstitial *splashInterstitial_;
}

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic, readonly) NSString *interstitialAdUnitID;

- (GADRequest *)createRequest;
@end
