//
//  ViewController.m
//  completeImage
//
//  Created by 张力 on 14-6-4.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "ViewController.h"
//ad...big
#import "AppDelegate.h"

#define levelBtnWidth 66
#define levelBtnHeight 81


@interface ViewController ()

@property (nonatomic ,strong)gameLevelController *game;
@property (nonatomic ,strong) UIButton *lockedInAlert;
@property (nonatomic ,strong) UIButton *cancelInAlert;


@property (nonatomic ,strong) NSMutableArray *lockImg;
@end

@implementation ViewController
NSInteger resultNum;
UIImageView *wrongAnswer;
UIButton *cancelInAlert;
UIView *tmpCustomView;

bool levelLock[bigLevel];


- (void)viewDidLoad
{
    [super viewDidLoad];
        NSError *error;
        //eric:sound test...
       [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
    
        [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker
                                                        error:&error];
    
        [[AVAudioSession sharedInstance] setActive: YES error: nil];

		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(snailAnimation) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [MobClick event:@"9"];

        
    }else
    {
        [MobClick event:@"8"];

    }
    
    isAnimating =NO;
    resultNum = -1;

    
    sharePic = [[NSArray alloc] initWithObjects:@"animalShare",@"sportShare",@"foodShare",@"livingGoodShare",@"plantShare", nil];
    sharePic480 = [[NSArray alloc] initWithObjects:@"animalShare480",@"sportShare480",@"foodShare480",@"livingGoodShare480",@"plantShare480", nil];
    
    int y = 0;
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        if ([CommonUtility isSystemVersionLessThan7]) {
            [self.view setFrame:CGRectMake(0, -20, 320, 480)];
            y=-13;
        }else
        {
            [self.view setFrame:CGRectMake(0, 0, 320, 480)];
            y = 7;
        }
        self.animal = [[UIButton alloc] initWithFrame:CGRectMake(14+3, 75.5-10+y, levelBtnWidth, levelBtnHeight)];
        self.sport = [[UIButton alloc] initWithFrame:CGRectMake(167-1, 95-10+y, levelBtnWidth, levelBtnHeight)];
        self.food = [[UIButton alloc] initWithFrame:CGRectMake(31+4, 239-11+y+5, levelBtnWidth-6, levelBtnHeight-20)];
        self.livingGood = [[UIButton alloc] initWithFrame:CGRectMake(134+3,239-13+y, levelBtnWidth-7, levelBtnHeight-7)];
        self.plant = [[UIButton alloc] initWithFrame:CGRectMake(75+3, 389-16+y+7, levelBtnWidth-7, levelBtnHeight-7)];
        self.moreFun = [[UIButton alloc] initWithFrame:CGRectMake(166+1, 385-16+y, levelBtnWidth-20, levelBtnHeight-25)];
        self.aboutUs = [[UIButton alloc] initWithFrame:CGRectMake(248-2, 398-20+y+5, levelBtnWidth-30, levelBtnHeight-35)];
        self.shareApp = [[UIButton alloc] initWithFrame:CGRectMake(228, 22+y, 60, 60)];
        
        self.levelTitle = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10+y, 200, 41)];
        self.movingSnail = [[UIImageView alloc] initWithFrame:CGRectMake(1, 210-13+y, 40, 40)];

        
    }else
    {
        [self.view setFrame:CGRectMake(0, 0, 320, 568)];
        self.animal = [[UIButton alloc] initWithFrame:CGRectMake(14, 75.5, levelBtnWidth, levelBtnHeight)];
        self.sport = [[UIButton alloc] initWithFrame:CGRectMake(167, 95, levelBtnWidth, levelBtnHeight)];
        self.food = [[UIButton alloc] initWithFrame:CGRectMake(31, 239+8, levelBtnWidth-3, levelBtnHeight-20)];
        self.livingGood = [[UIButton alloc] initWithFrame:CGRectMake(134,239, levelBtnWidth-7, levelBtnHeight-7)];
        self.plant = [[UIButton alloc] initWithFrame:CGRectMake(75, 389+4, levelBtnWidth-5, levelBtnHeight-5)];
        self.moreFun = [[UIButton alloc] initWithFrame:CGRectMake(166, 385, levelBtnWidth-20, levelBtnHeight-25)];
        self.aboutUs = [[UIButton alloc] initWithFrame:CGRectMake(248, 398, levelBtnWidth-30, levelBtnHeight-35)];
        self.shareApp = [[UIButton alloc] initWithFrame:CGRectMake(228, 30, 60, 60)];
        
        self.levelTitle = [[UIImageView alloc] initWithFrame:CGRectMake(20, 25, 200, 41)];
        self.movingSnail = [[UIImageView alloc] initWithFrame:CGRectMake(1, 210, 40, 40)];

    }
    self.animal.tag = 1;
    self.sport.tag = 2;
    self.food.tag = 3;
    self.livingGood.tag = 4;
    self.plant.tag = 5;
    
    [self.animal setImage:[UIImage imageNamed:@"b4"] forState:UIControlStateNormal];
    [self.plant setImage:[UIImage imageNamed:@"b7"] forState:UIControlStateNormal];
    [self.food setImage:[UIImage imageNamed:@"b5"] forState:UIControlStateNormal];
    [self.sport setImage:[UIImage imageNamed:@"b6"] forState:UIControlStateNormal];
    [self.livingGood setImage:[UIImage imageNamed:@"b8"] forState:UIControlStateNormal];
    [self.moreFun setImage:[UIImage imageNamed:@"b2"] forState:UIControlStateNormal];
    [self.aboutUs setImage:[UIImage imageNamed:@"b3"] forState:UIControlStateNormal];
    [self.shareApp setImage:[UIImage imageNamed:@"b1"] forState:UIControlStateNormal];
    
    [self.animal setImage:[UIImage imageNamed:@"b4h"] forState:UIControlStateHighlighted];
    [self.plant setImage:[UIImage imageNamed:@"b7h"] forState:UIControlStateHighlighted];
    [self.food setImage:[UIImage imageNamed:@"b5h"] forState:UIControlStateHighlighted];
    [self.sport setImage:[UIImage imageNamed:@"b6h"] forState:UIControlStateHighlighted];
    [self.livingGood setImage:[UIImage imageNamed:@"b8h"] forState:UIControlStateHighlighted];
    [self.aboutUs setImage:[UIImage imageNamed:@"b3h"] forState:UIControlStateHighlighted];
    [self.shareApp setImage:[UIImage imageNamed:@"b1h"] forState:UIControlStateHighlighted];
    
    [self.movingSnail setImage:[UIImage imageNamed:@"movingSnail"]];

    if ([CommonUtility isSystemLangChinese]) {
        [self.levelTitle setImage:[UIImage imageNamed:@"levelTitle"]];

    }else
    {
        [self.levelTitle setImage:[UIImage imageNamed:@"en-levelTitle"]];

    }
    
    [self.animal addTarget:self action:@selector(animalBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.plant addTarget:self action:@selector(plantBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.food addTarget:self action:@selector(foodBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.sport addTarget:self action:@selector(sportBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.livingGood addTarget:self action:@selector(livingGoodBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.shareApp addTarget:self action:@selector(shareAlert) forControlEvents:UIControlEventTouchUpInside];
    [self.aboutUs addTarget:self action:@selector(aboutUsTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.moreFun addTarget:self action:@selector(moreInfoAlert) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview: self.animal];
    [self.view addSubview: self.plant];

    [self.view addSubview: self.food];

    [self.view addSubview: self.sport];

    [self.view addSubview: self.livingGood];

    [self.view addSubview: self.moreFun];

    [self.view addSubview: self.aboutUs];

    [self.view addSubview: self.shareApp];
    
    [self.view addSubview:self.levelTitle];
    
    [self.shareApp setEnabled:YES];
//    [self.view addSubview:self.movingSnail];



    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    levelTop = [[ud objectForKey:@"saveLevel"] intValue];
    level = levelTop;
    
    if([ud objectForKey:@"saveShareState"]){
        haveShared = [NSMutableArray arrayWithArray:[[ud objectForKey:@"saveShareState"] componentsSeparatedByString:@","]];
    }else
    {
        haveShared = [[NSMutableArray alloc] init];
        for (int i = 0; i<bigLevel; i++) {
            haveShared[i] = @"0";

        }
        NSLog(@"%@",haveShared);

    }

    
    if (level<1 ||level>50) {
        level =1;
    }
    
    NSLog(@"%@",haveShared);
    self.game = [[gameLevelController alloc] initWithNibName:@"gameLevelController" bundle:nil];

    self.game.stopDelegate = self;

    UIImageView *homeBackground = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        homeBackground.image = [UIImage imageNamed:@"level480"];

        
    }else
    {
        homeBackground.image = [UIImage imageNamed:@"level"];
        
    }
    

    self.lockImg = [[NSMutableArray alloc] init];
    for (int i = 0; i <5; i++) {
        levelLock[i] = NO;
        UIButton *levelEntrance = (UIButton *)[self.view viewWithTag:(i+1)];
        UIImageView *lockImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suozi" ]];
        [lockImage setFrame:CGRectMake(levelEntrance.frame.size.width/2-22, levelEntrance.frame.size.height-60, 42, 42)];
        [self.lockImg insertObject:lockImage atIndex:i];
    }

//    [self moveToRight];
//    [self snailAnimation];
    
    [self.view addSubview:homeBackground];
    [self.view sendSubviewToBack:homeBackground];
    
    
    
//set ad......iad and admob
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        self.iAdBannerView = [[ADBannerView alloc] initWithFrame:CGRectMake(0.0,self.view.frame.size.height - GAD_SIZE_320x50.height,GAD_SIZE_320x50.width,GAD_SIZE_320x50.height)];
        
        [self.iAdBannerView setDelegate:self];
        self.iAdBannerView.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:self.iAdBannerView];
        self.bannerIsVisible = YES;
        
        self.gAdBannerView = [[GADBannerView alloc]
                              initWithFrame:CGRectMake(0.0,self.view.frame.size.height - GAD_SIZE_320x50.height,GAD_SIZE_320x50.width,GAD_SIZE_320x50.height)];
        
        self.gAdBannerView.adUnitID = ADMOB_ID;//调用id
        
        self.gAdBannerView.delegate = self;
        self.gAdBannerView.rootViewController = self;
        self.gAdBannerView.backgroundColor = [UIColor clearColor];
        [self.gAdBannerView loadRequest:[GADRequest request]];
        
        
    }


}

-(void)moveToRight
{
    CGRect aframe = self.movingSnail.frame;
    aframe.origin.x=-30;
    self.movingSnail.frame=aframe;
    
    self.movingSnail.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:@"toRight"context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:18];
    aframe.origin.x+=320;
    self.movingSnail.frame=aframe;
    [UIView setAnimationDidStopSelector:@selector(moveToLeft)];
    [UIView commitAnimations];
}
-(void)moveToLeft
{    CGRect aframe = self.movingSnail.frame;
    aframe.origin.x=-30;
    self.movingSnail.frame=aframe;

    
    self.movingSnail.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:@"toleft"context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:18];
    aframe.origin.x+=320;
    self.movingSnail.frame=aframe;
    [UIView setAnimationDidStopSelector:@selector(moveToRight)];
    [UIView commitAnimations];
}



- (void)viewDidAppear:(BOOL)animated
{
    
    if (!isAnimating ) {
        [self snailAnimation];
    }
    

    [MobClick beginLogPageView:@"selectLevelPage"];
    
    
//    ad.....big
    if (ADTimer ==nil) {
        
        ADTimer = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(bigAd) userInfo:nil repeats:NO];

    }
    

    
    if ( levelTop < level) {
        levelTop = level;
    }
    


    
    for (int i=(bigLevel-1); i>0; i--) {

        UIButton *levelEntrance = (UIButton *)[self.view viewWithTag:(i+1)];

        
        if (i>(levelTop-1)/10) {
            
            levelLock[i] = YES;

            [levelEntrance addSubview:self.lockImg[i]];
            [levelEntrance bringSubviewToFront:self.lockImg[i]];
        }else
        {
            levelLock[i] = NO;
            
            [self.lockImg[i] removeFromSuperview];
            
        }
       
   
        
    }
    
}

//ad...big
-(void)bigAd
{
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.delegate = self;
    
    // Note: Edit InterstitialExampleAppDelegate.m to update
    // INTERSTITIAL_AD_UNIT_ID with your interstitial ad unit id.
    AppDelegate *appDelegate =
    (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.interstitial.adUnitID = ADMOB_ID_DaysInLine;
    
    [self.interstitial loadRequest: [appDelegate createRequest]];
}



- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"selectLevelPage"];
    //ad...big
    if (ADTimer != nil)
	{
		[ADTimer invalidate];
		ADTimer = nil;
	}
}
- (IBAction)animalBtn:(UIButton *)sender {
    
//    [CommonUtility tapSound:@"selectLevel"];
    [CommonUtility tapSound:@"selectLevel" withType:@"mp3"];


    
    
    level = 1;
    [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];
    
    if (levelLock[sender.tag-1]) {

        [self setupAlert];
        
        
    }else{
        
        self.game.backgroundImg = [UIImage imageNamed:@"植物背景6"];

        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countSecond:) userInfo:nil repeats:YES];
        
        seconds = 0;
    }
    
    
 
}

-(void)setupAlert
{
    
    UIView *tmpCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 300, 208)];
//    tmpCustomView.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tagAlert" ofType:@"png"]]];

    
//    UIImageView *imageInTag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300 , 211)];
//    imageInTag.image = [UIImage imageNamed:@"tagAlert.png"];
//
//    [tmpCustomView addSubview:imageInTag];
//    [tmpCustomView sendSubviewToBack:imageInTag];
//    tmpCustomView.backgroundColor = [UIColor clearColor];
    
    
    
    self.lockedInAlert = [[UIButton alloc] initWithFrame:CGRectMake(40, 145, 90, 47)];
    self.cancelInAlert = [[UIButton alloc] initWithFrame:CGRectMake(170, 145, 90, 47)];
    
    if ([CommonUtility isSystemLangChinese]) {
        
        tmpCustomView.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tagAlert" ofType:@"png"]]];

        
        [self.lockedInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"okButton" ofType:@"png"]] forState:UIControlStateNormal];
        [self.cancelInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cancelButton" ofType:@"png"]] forState:UIControlStateNormal];


    }else
    {
        tmpCustomView.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-tagAlert" ofType:@"png"]]];

        
        [self.lockedInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-okButton" ofType:@"png"]] forState:UIControlStateNormal];
        [self.cancelInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-cancelButton" ofType:@"png"]] forState:UIControlStateNormal];
    }
    
//    [self.lockedInAlert setTitle:@"前往当前进度" forState:UIControlStateNormal];
//    self.lockedInAlert.titleLabel.font = [UIFont systemFontOfSize:14.0];
//    self.lockedInAlert.titleLabel.textColor = [UIColor redColor];


//    self.lockedInAlert.backgroundColor = [UIColor greenColor];
    [self.lockedInAlert addTarget:self action:@selector(goToLevelNow) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelInAlert addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchUpInside];

    [tmpCustomView addSubview:self.lockedInAlert];
    [tmpCustomView addSubview:self.cancelInAlert];
    
    
    CustomIOS7AlertView *alert = [[CustomIOS7AlertView alloc] init];
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:nil]];
    alert.backgroundColor = [UIColor whiteColor];
    
    [alert setContainerView:tmpCustomView];
    
    self.lockedAlert = alert;
    [alert show];
    


}

-(void)closeAlert
{
    [CommonUtility tapSound:@"backAndCancel" withType:@"mp3"];

    [self.lockedAlert close];
}

-(void)goToLevelNow
{
    [CommonUtility tapSound];

    if (levelTop>MAXlevel) {
        level = MAXlevel;
    }else{
        level = levelTop;

    }
    


    [self.lockedAlert close];
    
    self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:self.game animated:YES completion:Nil ];
    
}

- (IBAction)sportBtn:(UIButton *)sender {
    
    [CommonUtility tapSound:@"selectLevel" withType:@"mp3"];

    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 11;
        [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];

        self.game.backgroundImg = [UIImage imageNamed:@"animalBackground"];
        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}

- (IBAction)livingGoodBtn:(UIButton *)sender {
    
    [CommonUtility tapSound:@"selectLevel" withType:@"mp3"];

    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 31;
        [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];

        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}

- (IBAction)plantBtn:(UIButton *)sender {
    
    [CommonUtility tapSound:@"selectLevel" withType:@"mp3"];

    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
         level = 41;
        [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];

        self.game.backgroundImg = [UIImage imageNamed:@"plantBackground"];
        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}



- (IBAction)foodBtn:(UIButton *)sender {
    
    [CommonUtility tapSound:@"selectLevel" withType:@"mp3"];

    
    if (levelLock[sender.tag-1]) {
        
        [self setupAlert];
        
        
    }else{
        level = 21;
        [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];

        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:self.game animated:YES completion:Nil ];
    }
    

}

//- (IBAction)moreBtn:(UIButton *)sender {
//    
//    
//    
//    if (levelLock[sender.tag-1]) {
//        
//        [self setupAlert];
//        
//        
//    }else{
//        level = 51;
//        [scores setObject:[NSNumber numberWithInt:0] atIndexedSubscript:(level-1)/10];
//
//        self.game.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//        [self presentViewController:self.game animated:YES completion:Nil ];
//    }
//    
//
//}
//
-(void)shareAlert
{
   [CommonUtility tapSound:@"selectLevel" withType:@"mp3"];
    
    tmpCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 300, 208)];
    UIImageView *title = [[UIImageView alloc] initWithFrame:CGRectMake(77, 15, 146, 47)];

    
    wrongAnswer = [[UIImageView alloc] initWithFrame:CGRectMake(45, 145, 110, 40)];
   
    
    cancelInAlert = [[UIButton alloc] initWithFrame:CGRectMake(105, 145, 90, 47)];
    
    tmpCustomView.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"alertBackground" ofType:@"png"]]];
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [cancelInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cancelButton" ofType:@"png"]] forState:UIControlStateNormal];
        [wrongAnswer setImage:[UIImage imageNamed:@"错误答案"]];
        [title setImage:[UIImage imageNamed:@"家长控制"]];
        
        
        
    }else
    {
       [cancelInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-cancelButton" ofType:@"png"]] forState:UIControlStateNormal];
        [wrongAnswer setImage:[UIImage imageNamed:@"wronganswer"]];
        [title setImage:[UIImage imageNamed:@"Grown-upsOnly"]];
    }
    
//    [lockedInAlert addTarget:self action:@selector(shareFunc) forControlEvents:UIControlEventTouchUpInside];
    [cancelInAlert addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchUpInside];
    

    
    UILabel *numberA = [[UILabel alloc] initWithFrame:CGRectMake(40, 80, 47, 47)];
    UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake(85, 83.5, 40, 40)];
    [plus setImage:[UIImage imageNamed:@"+"]];
    
    UILabel *numberB = [[UILabel alloc] initWithFrame:CGRectMake(130, 80, 47, 47)];
    UIImageView *equals = [[UIImageView alloc] initWithFrame:CGRectMake(175, 83.5, 40, 40)];
    [equals setImage:[UIImage imageNamed:@"="]];
    UITextField *answer = [[UITextField alloc] initWithFrame:CGRectMake(220, 80, 47, 47)];
    numberA.font = [UIFont fontWithName:@"SegoePrint" size:30];
    [numberA setTextColor:[UIColor blueColor]];
    numberA.textAlignment = NSTextAlignmentCenter;
    numberB.font = [UIFont fontWithName:@"SegoePrint" size:30];
    [numberB setTextColor:[UIColor brownColor]];
    numberB.textAlignment = NSTextAlignmentCenter;
    answer.backgroundColor = [UIColor clearColor];
    answer.textAlignment = NSTextAlignmentCenter;
    [answer setTextColor:[UIColor purpleColor]];
    answer.font = [UIFont fontWithName:@"SegoePrint" size:30];
    [answer setBackground:[UIImage imageNamed:@"border"]];
    answer.delegate = self;
    answer.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    answer.tag = 0;

    unsigned int randomA = arc4random()%20;
    unsigned int randomB = arc4random()%20;
    resultNum = randomA+randomB;
    [numberA setText:[NSString stringWithFormat:@"%d",randomA]];
    [numberB setText:[NSString stringWithFormat:@"%d",randomB]];
    
//    [tmpCustomView addSubview:lockedInAlert];
    [tmpCustomView addSubview:title];
    [tmpCustomView addSubview:cancelInAlert];
//    [cancelInAlert setHidden:YES];
    [tmpCustomView addSubview:wrongAnswer];
    [wrongAnswer setHidden:YES];
    [tmpCustomView addSubview:numberA];
    [tmpCustomView addSubview:numberB];
    [tmpCustomView addSubview:plus];
    [tmpCustomView addSubview:equals];
    [tmpCustomView addSubview:answer];

    
    CustomIOS7AlertView *alert = [[CustomIOS7AlertView alloc] init];
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:nil]];
    alert.backgroundColor = [UIColor whiteColor];
    
    [alert setContainerView:tmpCustomView];
    
    self.lockedAlert = alert;
    [alert show];
    
    
    [answer becomeFirstResponder];
}





-(void)shareFunc
{
    

    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:NO
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"clcstudio@163.com"],
                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
                                    nil]];


    
    
    UIImage *imageShare = [UIImage imageNamed:@"appIcon"];
    NSString *message = nil;
    NSString *testShare = nil;
    if ([CommonUtility isSystemLangChinese]) {
        message = @"宝贝,拼吧！\n亲子游戏悄然来袭！";
        testShare = @"赶快下载《宝贝，拼吧！》\n来自星星的宝宝就是你！\nhttps://itunes.apple.com/cn/app/baby-match!/id915444234?l=zh&mt=8";
        
    }else
    {
        message = @"BabyMatch!\nA fantastic parent-child game.";
        testShare = @"Download <BabyMatch!>.\n You’re the Baby from the Star!\nhttps://itunes.apple.com/en/app/baby-match!/id915444234?l=en&mt=8";
    }
    
        //构造分享内容
   id<ISSContent> publishContent = [ShareSDK content: testShare
                                       defaultContent: testShare
                                                image:[ShareSDK pngImageWithImage:imageShare]
                                                title:message
                                                 url:@"https://itunes.apple.com/cn/app/baby-match!/id915444234?l=zh&mt=8"
                                          description: testShare
                                            mediaType:SSPublishContentMediaTypeNews];
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:NO
                       authOptions:authOptions
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tips" message:@"Success!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alert show];
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tips" message:[NSString stringWithFormat:@"Failed! \n%@", [error errorDescription]]delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                    [alert show];
                                    
                                }
                            }];
    
  
}

-(void)aboutUsTapped
{
    [CommonUtility tapSound:@"selectLevel" withType:@"mp3"];

    AboutUsViewController *teamInfo = [[AboutUsViewController alloc] init];
    teamInfo.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:teamInfo animated:YES completion:Nil ];
    
}
-(void)moreInfoAlert
{
    [CommonUtility tapSound:@"selectLevel" withType:@"mp3"];
    
    tmpCustomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , 300, 208)];
    UIImageView *title = [[UIImageView alloc] initWithFrame:CGRectMake(77, 15, 146, 47)];
    
    
    wrongAnswer = [[UIImageView alloc] initWithFrame:CGRectMake(45, 145, 110, 40)];
    
    
    cancelInAlert = [[UIButton alloc] initWithFrame:CGRectMake(105, 145, 90, 47)];
    
    tmpCustomView.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"alertBackground" ofType:@"png"]]];
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [cancelInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cancelButton" ofType:@"png"]] forState:UIControlStateNormal];
        [wrongAnswer setImage:[UIImage imageNamed:@"错误答案"]];
        [title setImage:[UIImage imageNamed:@"家长控制"]];
        
        
        
    }else
    {
        [cancelInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-cancelButton" ofType:@"png"]] forState:UIControlStateNormal];
        [wrongAnswer setImage:[UIImage imageNamed:@"wronganswer"]];
        [title setImage:[UIImage imageNamed:@"Grown-upsOnly"]];
    }
    
    //    [lockedInAlert addTarget:self action:@selector(shareFunc) forControlEvents:UIControlEventTouchUpInside];
    [cancelInAlert addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *numberA = [[UILabel alloc] initWithFrame:CGRectMake(40, 80, 47, 47)];
    UIImageView *plus = [[UIImageView alloc] initWithFrame:CGRectMake(85, 83.5, 40, 40)];
    [plus setImage:[UIImage imageNamed:@"+"]];
    
    UILabel *numberB = [[UILabel alloc] initWithFrame:CGRectMake(130, 80, 47, 47)];
    UIImageView *equals = [[UIImageView alloc] initWithFrame:CGRectMake(175, 83.5, 40, 40)];
    [equals setImage:[UIImage imageNamed:@"="]];
    UITextField *answer = [[UITextField alloc] initWithFrame:CGRectMake(220, 80, 47, 47)];
    numberA.font = [UIFont fontWithName:@"SegoePrint" size:30];
    [numberA setTextColor:[UIColor blueColor]];
    numberA.textAlignment = NSTextAlignmentCenter;
    numberB.font = [UIFont fontWithName:@"SegoePrint" size:30];
    [numberB setTextColor:[UIColor brownColor]];
    numberB.textAlignment = NSTextAlignmentCenter;
    answer.backgroundColor = [UIColor clearColor];
    answer.textAlignment = NSTextAlignmentCenter;
    [answer setTextColor:[UIColor purpleColor]];
    answer.font = [UIFont fontWithName:@"SegoePrint" size:30];
    [answer setBackground:[UIImage imageNamed:@"border"]];
    answer.delegate = self;
    answer.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    answer.tag = 1;
    
    unsigned int randomA = arc4random()%20;
    unsigned int randomB = arc4random()%20;
    resultNum = randomA+randomB;
    [numberA setText:[NSString stringWithFormat:@"%d",randomA]];
    [numberB setText:[NSString stringWithFormat:@"%d",randomB]];
    
    //    [tmpCustomView addSubview:lockedInAlert];
    [tmpCustomView addSubview:title];
    [tmpCustomView addSubview:cancelInAlert];
    //    [cancelInAlert setHidden:YES];
    [tmpCustomView addSubview:wrongAnswer];
    [wrongAnswer setHidden:YES];
    [tmpCustomView addSubview:numberA];
    [tmpCustomView addSubview:numberB];
    [tmpCustomView addSubview:plus];
    [tmpCustomView addSubview:equals];
    [tmpCustomView addSubview:answer];
    
    
    CustomIOS7AlertView *alert = [[CustomIOS7AlertView alloc] init];
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:nil]];
    alert.backgroundColor = [UIColor whiteColor];
    
    [alert setContainerView:tmpCustomView];
    
    self.lockedAlert = alert;
    [alert show];
    
    
    [answer becomeFirstResponder];

}
-(void)moreInfo
{
    [CommonUtility tapSound:@"selectLevel" withType:@"mp3"];

    moreInfoViewController *more = [[moreInfoViewController alloc] init];
    more.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:more animated:YES completion:Nil ];
}


- (void)countSecond:(NSTimer*)timer1
{

	seconds = seconds + 1;
	
}

#pragma stopTimerDelegate method
-(void) stopTimer
{
    if (timer != nil)
	{
		[timer invalidate];
		timer = nil;
	}
}

//ad...big
#pragma bigAD delegate method
- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    // Alert the error.

    NSLog(@"big ad error:%@",[error description]);
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [interstitial presentFromRootViewController:self];

}
- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
{
    [ADTimer invalidate];
    ADTimer =nil;
    ADTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(bigAd) userInfo:nil repeats:NO];


}


- (void)snailAnimation {

	
	self.view.backgroundColor = [UIColor greenColor];
    
	UIBezierPath *trackPath = [UIBezierPath bezierPath];
	
    [trackPath moveToPoint:P(-30,self.movingSnail.frame.origin.y+15)];
    
    [trackPath addLineToPoint:P(30,self.movingSnail.frame.origin.y+2+15)];

    [trackPath addLineToPoint:P(110,self.movingSnail.frame.origin.y-15+20)];
    [trackPath addLineToPoint:P(200,self.movingSnail.frame.origin.y+1+17)];
    [trackPath addLineToPoint:P(280,self.movingSnail.frame.origin.y+1+16)];
    [trackPath addLineToPoint:P(350,self.movingSnail.frame.origin.y-5+16)];

//	[trackPath addCurveToPoint:P(300, 120)
//				 controlPoint1:P(320, 0)
//				 controlPoint2:P(300, 80)];
//	[trackPath addCurveToPoint:P(80, 380)
//				 controlPoint1:P(300, 200)
//				 controlPoint2:P(200, 480)];
//	[trackPath addCurveToPoint:P(140, 300)
//				 controlPoint1:P(0, 300)
//				 controlPoint2:P(200, 220)];
//	[trackPath addCurveToPoint:P(210, 200)
//				 controlPoint1:P(30, 420)
//				 controlPoint2:P(280, 300)];
//	[trackPath addCurveToPoint:P(70, 110)
//				 controlPoint1:P(110, 80)
//				 controlPoint2:P(110, 80)];
//	[trackPath addCurveToPoint:P(160, 25)
//				 controlPoint1:P(0, 160)
//				 controlPoint2:P(0, 40)];
//	
//	CAShapeLayer *racetrack = [CAShapeLayer layer];
//	racetrack.path = trackPath.CGPath;
//	racetrack.strokeColor = [UIColor blackColor].CGColor;
//	racetrack.fillColor = [UIColor clearColor].CGColor;
//	racetrack.lineWidth = 30.0;
//	[self.view.layer addSublayer:racetrack];
    
//	CAShapeLayer *centerline = [CAShapeLayer layer];
//	centerline.path = trackPath.CGPath;
//	centerline.strokeColor = [UIColor whiteColor].CGColor;
//	centerline.fillColor = [UIColor clearColor].CGColor;
//	centerline.lineWidth = 2.0;
//	centerline.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:6], [NSNumber numberWithInt:2], nil];
//	[self.view.layer addSublayer:centerline];
	
	CALayer *car = [CALayer layer];
	car.bounds = CGRectMake(0, 0, 40, 40);
	car.position = P(-30,self.movingSnail.frame.origin.y);
	car.contents = (id)([UIImage imageNamed:@"movingSnail"].CGImage);
	[self.view.layer addSublayer:car];
	
	CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	anim.path = trackPath.CGPath;
	anim.rotationMode = kCAAnimationRotateAuto;
	anim.repeatCount = HUGE_VALF;
	anim.duration = 25.0;
	[car addAnimation:anim forKey:@"race"];
    isAnimating =YES;
}


-(void)dealloc
{
        NSError *error;
        //eric:sound test...
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    
        [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideNone
                                                            error:&error];
    
        [[AVAudioSession sharedInstance] setActive: NO error: nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    }

-(BOOL)shouldAutorotate
{
        return NO;
    }

-(NSUInteger)supportedInterfaceOrientations
{
       return UIInterfaceOrientationMaskPortrait;

}

//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    if([textField.text isEqualToString:[NSString stringWithFormat:@"%d",resultNum]])
//    {
//        [self.lockedAlert close];
//        [self shareFunc];
//        
//    }else
//    {
//        [wrongAnswer setHidden:NO];
//    }
//    
//}
//

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField.tag == 0)
    {
        if([textField.text isEqualToString:[NSString stringWithFormat:@"%d",resultNum]])
        {
            [self.lockedAlert close];
            [self shareFunc];
            
        }else
        {
            [cancelInAlert removeFromSuperview];
            [self performSelector:@selector(redrawCancel) withObject:nil afterDelay:0.35];
            //        [cancelInAlert setFrame:CGRectMake(105, 145, 90, 47)];
            //        [self.lockedAlert addSubview:cancelInAlert];
            
            [wrongAnswer setHidden:NO];
            
        }
    }else
    {
        if([textField.text isEqualToString:[NSString stringWithFormat:@"%d",resultNum]])
        {
            [self.lockedAlert close];
            [self moreInfo];
            

            
        }else
        {
            [cancelInAlert removeFromSuperview];
            [self performSelector:@selector(redrawCancel) withObject:nil afterDelay:0.35];
            //        [cancelInAlert setFrame:CGRectMake(105, 145, 90, 47)];
            //        [self.lockedAlert addSubview:cancelInAlert];
            
            [wrongAnswer setHidden:NO];
            
        }

        
    }
    [textField resignFirstResponder];
    return YES;
}
-(void)redrawCancel
{
    [cancelInAlert setFrame:CGRectMake(170, 145, 90, 47)];
    [tmpCustomView addSubview:cancelInAlert];
}

#pragma mark - AdViewDelegates


- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"Admob load");
    
}

// An error occured
- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"Admob error: %@", error);
    [self.gAdBannerView removeFromSuperview];
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"iad failed");
    [self.iAdBannerView removeFromSuperview];
    self.bannerIsVisible = NO;
    
    [self.view addSubview:self.gAdBannerView];
    
    
}


-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"iAd will load");
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"iAd did finish");
    
}
@end
