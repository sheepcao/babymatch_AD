//
//  gameLevelController.m
//  completeImage
//
//  Created by 张力 on 14-6-22.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "gameLevelController.h"
#import "moreInfoViewController.h"

//ad...big
#import "AppDelegate.h"
#import "TOLAdViewController.h"
#import "LARSAdController.h"


@interface gameLevelController ()

@end

@implementation gameLevelController

double posX[MAXlevel] = {216.6,113.1,107.4,118.5,90.6,/*5*/141.4,48.9,136,116,198.8,/*10*/166.8,142.4,168.99,117.31,130.9,/*15*/27.7,56.9,235.7,37.4,83/*20*/,194.4,186.8,192.7,191.7,193.4,/*25*/78.7,174.8,138.9,168,110.6,/*30*/155.8,95,68.4,48.4,133.1,/*35*/72.5,123.6,131.9,140.4,107.5,/*40*/130.1,200.7,129.7,135.5,108.2,/*45*/215.9,137,178.8,102.1,42.1};
double posY[MAXlevel] = {277.1,284.3,282.5,195.1,340.1,/*5*/274.7,324.5
    ,229.5,227.6,232.7/*10*/,230.5,314.24,194.6,330.36,333.8,/*15*/237
    ,244,331.8,193.4,319.1/*20*/,339.6,208,339.6,223.7,211.95,/*25*/339.1,319.6,280.1,311.6,284,/*30*/307.9,292.8,347.5,206.8,258.1,/*35*/238.6,227.3,214.6,250,212.4,/*40*/283.8,286.4,279.1,240.2,189+169.9,/*45*/216.6,256.8,241.7,271.8,259.1};
double animationSpeed[MAXlevel] = {0.35,0.31,0.27,0.34,0.33,/*5*/0.24,0.24,0.18,0.22,0.40,/*10*/0.23,0.2,0.18,0.17,0.24,/*15*/0.2,0.28,0.23,0.22,0.37/*20*/,0.36,1.0,0.3,0.7,0.8,/*25*/0.5,0.45,0.4,0.36,0.45,/*30*/0.45,0.33,0.3,0.35,0.26,/*35*/0.25,0.46,0.43,0.37,0.15,/*40*/0.6,0.2,0.29,0.38,0.39,/*45*/0.4,0.5,0.4,0.45,0.3};
double repeatTime[MAXlevel] = {3,1,3,1,1,/*5*/2,2,2,2,3,/*10*/2,2,2,2,2,/*15*/2,2,2,2,1/*20*/,1,1,1,1,1/*25*/,1,1,3,1,1,/*30*/1,2,2,1,2,/*35*/2,1,1,2,3,/*40*/1,3,1,1,1,/*45*/1,1,1,1,2};
double largeEmpty[bigLevel] = {122.22,200,55,55,55};
bool haveFixed[MAXlevel] = {NO};
bool notJumpOver = NO;
bool isFromAD = NO;



NSArray *wordsCN;
NSArray *wordsEN;
NSArray *backgroundName;

NSMutableArray  *arrayM;
NSMutableArray  *arrayGif;




- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [self.backButton setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
        [self.backButton setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    }else
    {
        [self.backButton setImage:[UIImage imageNamed:@"returnToLevelEN"] forState:UIControlStateNormal];
        [self.backButton setImage:[UIImage imageNamed:@"returnTappedEN"] forState:UIControlStateHighlighted];
    }

    
    
    self.isFormRewordFlag = NO;

    
    for (int i=0; i<levelTop-1; i++) {
        haveFixed[i]= YES;
    }
    NSLog(@"levelTop:%d,fixed:%d",levelTop,haveFixed[levelTop-1]);
    
    CGFloat deviceOffset_height=0;
    CGFloat deviceOffset_width=0;
    CGFloat deviceOffset_size=0;
//    CGFloat deviceOffset_height=0;


    
    if (IS_IPHONE_6) {
        
        deviceOffset_height = 25;
//        deviceOffset_width = 20;
        deviceOffset_size= 5;
 
    }else if (IS_IPHONE_6P)
    {
        deviceOffset_height = 35;
//        deviceOffset_width = 20;
        deviceOffset_size= 8;
    }else if(IS_IPAD)
    {
        deviceOffset_height = 180;
        deviceOffset_width = 50;
        deviceOffset_size= 55;
    }
    
    self.answer2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - (55+deviceOffset_size)/2, 450+2*deviceOffset_height, 55+deviceOffset_size, 55+deviceOffset_size)];
    self.answer2.tag = 2;
    
    self.answer1 = [[UIButton alloc] initWithFrame:CGRectMake(self.answer2.frame.origin.x - 45-deviceOffset_width - (55+deviceOffset_size), 450+2*deviceOffset_height, 55+deviceOffset_size, 55+deviceOffset_size)];
    self.answer1.tag = 1;

    self.answer3 = [[UIButton alloc] initWithFrame:CGRectMake(self.answer2.frame.origin.x + 45+deviceOffset_width + (55+deviceOffset_size), 450+2*deviceOffset_height, 55+deviceOffset_size, 55+deviceOffset_size)];
    self.answer3.tag = 3;

    [self.answer1 setBackgroundImage:[UIImage imageNamed:@"choiceBackground"] forState:UIControlStateNormal];
    [self.answer2 setBackgroundImage:[UIImage imageNamed:@"choiceBackground"] forState:UIControlStateNormal];
    [self.answer3 setBackgroundImage:[UIImage imageNamed:@"choiceBackground"] forState:UIControlStateNormal];
    [self.answer1 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.answer2 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.answer3 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];


    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        self.picture = [[UIImageView alloc] initWithFrame: CGRectMake(33, 157, 250, 230)];
     
        self.animationBegin = [[UIButton alloc] initWithFrame:CGRectMake(33, 157, 250, 230)];

        [self.answer1 setFrame:CGRectMake(33, 400, 55, 55)];
        [self.answer2 setFrame:CGRectMake(131, 400, 55, 55)];
        [self.answer3 setFrame:CGRectMake(228, 400, 55, 55)];
        
    }else
    {
        CGFloat pictureOffset_height=0;
        CGFloat pictureOffset_width=0;
        CGFloat pictureOffset_h = 0;
        CGFloat pictureOffset_w = 0;


        
        if(IS_IPHONE_6)
        {
            pictureOffset_height=13;
            pictureOffset_width=28;

            for (int i = 0; i <MAXlevel; i++) {
       
                posY[i] +=(1+pictureOffset_height);
                posX[i] +=pictureOffset_width;
            }

            
            
        }else if(IS_IPHONE_6P)
        {
            pictureOffset_height=40;
            pictureOffset_width=48;
            
            for (int i = 0; i <MAXlevel; i++) {
                
                posY[i] +=(1+pictureOffset_height);
                posX[i] +=pictureOffset_width;
            }
        }else if(IS_IPAD)
        {

            
            pictureOffset_height=100;
            pictureOffset_width=95;
            pictureOffset_h = 230;
            pictureOffset_w = 250;
            
            for (int i = 0; i <MAXlevel; i++) {
                
                posY[i] += (posY[i]-190) ;
                posX[i] += (posX[i]-33) ;
                
                posY[i] +=pictureOffset_height;
                posX[i] +=pictureOffset_width;
            }

        }
        
        self.picture = [[UIImageView alloc] initWithFrame:CGRectMake(33+pictureOffset_width, 190+pictureOffset_height, 250+pictureOffset_w, 230+pictureOffset_h)];
        self.animationBegin = [[UIButton alloc] initWithFrame:CGRectMake(33+pictureOffset_width, 190+pictureOffset_height, 250+pictureOffset_w, 230+pictureOffset_h)];


        
        

    }
    [self.view addSubview:self.answer1];
    [self.view addSubview:self.answer2];
    [self.view addSubview:self.answer3];
    self.animationBegin.backgroundColor = [UIColor clearColor];
    self.picture.layer.borderWidth = 0;
    [self.view addSubview:self.picture];
    [self.view addSubview:self.animationBegin];
    [self.view bringSubviewToFront:self.animationBegin];
    [self.animationBegin addTarget:self action:@selector(animationTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    self.choices = [[NSMutableArray alloc] initWithObjects:self.answer1,self.answer2,self.answer3, nil];
    NSString *words1 = @"猪,猫,兔子,鸡,青蛙,蜜蜂,狗,鲨鱼,蜗牛,考拉,羽毛球,足球,乒乓球,高尔夫,保龄球,射箭,滑雪,篮球,帆船,举重,牛奶,土豆,月饼,栗子,米饭,披萨饼,西瓜,花生,橙子,黄瓜,眼镜,牙刷,钢笔,红绿灯,奶嘴,卫生间,钟表,蜡烛,放大镜,洗衣液,向日葵,柳树,玫瑰,荷花,竹子,松树,仙人掌,银杏树,菊花,牵牛花";
    wordsCN = [words1 componentsSeparatedByString:@","];
    NSString *words2 = @"pig,cat,rabbit,chicken,frog,bee,dog,shark,snail,koala,badminton,football,table tennis,golf,bowling,archery,skiing,basketball,sailing,weightlifting,milk,potato,mooncake,chestnut,rice,pizza,watermelon,peanut,orange,cucumber,glasses,toothbrush,pen,traffic light,pacifier,toilet,clock,candle,magnifier,landry,sunflower,willow,rose,lotus,bamboo,pine,cactus,gingko,chrysanthemum,morning glory";
    wordsEN = [words2 componentsSeparatedByString:@","];

    NSString *backgroundNames = @"animalBackground";
    backgroundName = [backgroundNames componentsSeparatedByString:@","];

    self.empty = [[UIButton alloc] init];
    [self.empty setBackgroundColor:[UIColor clearColor]];
    self.empty.layer.borderWidth = 0;

//share change task.    [self.shareBtn setHidden:YES];

    self.questionMark = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
    self.questionMark.layer.borderWidth = 0;
    self.questionMark.alpha = 0.8;
    [self.empty addSubview:self.questionMark];
    
    arrayGif=[[NSMutableArray array] init];
    UIImage *gif = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuestionMark" ofType:@"png"]];
    [arrayGif addObject:gif];
    
    [arrayGif addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"透明" ofType:@"png"]]];
    
    [arrayGif addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"QuestionMarkBlue" ofType:@"png"]]];

    [arrayGif addObject:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"透明" ofType:@"png"]]];


    
    UIImageView *gameBackground = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];

    gameBackground.image = [UIImage imageNamed:@"animalBackground"];
    
    [self.view addSubview:gameBackground];
    [self.view sendSubviewToBack:gameBackground];

    

    

    


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [[LARSAdController sharedManager] addAdContainerToViewInViewController:self];
    
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
    if (IS_IPHONE_6) {
        CGPoint priorBtnCenter = self.priorButton.center;
        priorBtnCenter.y += 17;
        priorBtnCenter.x += 10;
        [self.priorButton setCenter:priorBtnCenter];
        
        CGPoint nextBtnCenter = self.nextButton.center;
        nextBtnCenter.y += 17;
        nextBtnCenter.x += 40;
        [self.nextButton setCenter:nextBtnCenter];
        
        CGSize backBtnSize = self.backButton.frame.size;
        backBtnSize.width +=5  ;
        backBtnSize.height +=3;
        CGPoint backButtonCenter = self.backButton.center;
        backButtonCenter.y += 3;
        backButtonCenter.x += 5;
        [self.backButton setCenter:backButtonCenter];
        
        CGSize shareBtnSize = self.shareBtn.frame.size;
        shareBtnSize.width +=5  ;
        shareBtnSize.height +=3;
        CGPoint shareBtnCenter = self.shareBtn.center;
        shareBtnCenter.y += 3;
        shareBtnCenter.x += 55;
        [self.shareBtn setCenter:shareBtnCenter];
        
        CGSize levelCountSize = self.levelCount.frame.size;
        levelCountSize.width +=5  ;
        levelCountSize.height +=5;
        CGPoint levelCountCenter = self.levelCount.center;
        levelCountCenter.y += 5;
        levelCountCenter.x += 28;
        [self.levelCount setCenter:levelCountCenter];
        
    }else if (IS_IPHONE_6P) {
        CGPoint priorBtnCenter = self.priorButton.center;
        priorBtnCenter.y += 30;
        priorBtnCenter.x += 12;
        [self.priorButton setCenter:priorBtnCenter];
        
        CGPoint nextBtnCenter = self.nextButton.center;
        nextBtnCenter.y += 30;
        nextBtnCenter.x += 80;
        [self.nextButton setCenter:nextBtnCenter];
        
        CGSize backBtnSize = self.backButton.frame.size;
        backBtnSize.width +=5  ;
        backBtnSize.height +=3;
        CGPoint backButtonCenter = self.backButton.center;
        backButtonCenter.y += 5;
        backButtonCenter.x += 5;
        [self.backButton setCenter:backButtonCenter];
        
        CGSize shareBtnSize = self.shareBtn.frame.size;
        shareBtnSize.width +=5  ;
        shareBtnSize.height +=3;
        CGPoint shareBtnCenter = self.shareBtn.center;
        shareBtnCenter.y += 3;
        shareBtnCenter.x += 90;
        [self.shareBtn setCenter:shareBtnCenter];
        
        CGSize levelCountSize = self.levelCount.frame.size;
        levelCountSize.width +=5  ;
        levelCountSize.height +=5;
        CGPoint levelCountCenter = self.levelCount.center;
        levelCountCenter.y += 10;
        levelCountCenter.x += 47;
        [self.levelCount setCenter:levelCountCenter];
        
    }else if (IS_IPAD) {
        
        CGRect priorBtnSize = self.priorButton.bounds;
        priorBtnSize.size.width +=50  ;
        priorBtnSize.size.height +=38;
        [self.priorButton setBounds:priorBtnSize];
        CGPoint priorBtnCenter = self.priorButton.center;
        priorBtnCenter.y += 85;
        priorBtnCenter.x += 60;
        [self.priorButton setCenter:priorBtnCenter];
        
        CGRect nextBtnSize = self.nextButton.bounds;
        nextBtnSize.size.width +=50  ;
        nextBtnSize.size.height +=38;
        [self.nextButton setBounds:nextBtnSize];
        CGPoint nextBtnCenter = self.nextButton.center;
        nextBtnCenter.y += 85;
        nextBtnCenter.x += 370;
        [self.nextButton setCenter:nextBtnCenter];
        
        CGRect backBtnSize = self.backButton.bounds;
        backBtnSize.size.width +=40  ;
        backBtnSize.size.height +=27;
        [self.backButton setBounds:backBtnSize];
        CGPoint backButtonCenter = self.backButton.center;
        backButtonCenter.y += 25;
        backButtonCenter.x += 35;
        [self.backButton setCenter:backButtonCenter];
        
        CGRect shareBtnSize = self.shareBtn.bounds;
        shareBtnSize.size.width +=35  ;
        shareBtnSize.size.height +=23;
        [self.shareBtn setBounds:shareBtnSize];
        CGPoint shareBtnCenter = self.shareBtn.center;
        shareBtnCenter.y += 25;
        shareBtnCenter.x += 398;
        [self.shareBtn setCenter:shareBtnCenter];
        
        CGRect levelSize = self.levelCount.bounds;
        levelSize.size.width +=35  ;
        levelSize.size.height +=23;
        [self.levelCount setBounds:levelSize];
        CGPoint levelCountCenter = self.levelCount.center;
        levelCountCenter.y += 32;
        levelCountCenter.x += 223;
        [self.levelCount setCenter:levelCountCenter];
        self.levelCount.font = [UIFont fontWithName:@"SegoePrint" size:50];

        
    }

    
    
}

- (void)viewDidAppear:(BOOL)animated

{
    [MobClick beginLogPageView:@"gamePage"];
    

    

    
    //ad.....big
    if (ADTimer ==nil) {
        
        ADTimer = [NSTimer scheduledTimerWithTimeInterval:18.0 target:self selector:@selector(bigAd) userInfo:nil repeats:NO];
        
    }
    [self createAndLoadInterstitial];

    
    if (self.isFormRewordFlag == YES) {
        self.isFormRewordFlag = NO;
        [self dismissViewControllerAnimated:YES completion:nil];
    }

    [self.animationBegin setHidden:YES];
    
    for (int i =0; i<3; i++) {
        [self setButton:(UIButton *)self.choices[i]];
    }

    
    
    self.myImg = [[uncompleteImage alloc] initWithEmptyX:posX[level-1] Y:posY[level-1]];

    [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];

    
    self.teachView = [[teachingView alloc] initWithWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
    
    if (!haveFixed[level-1]) {
        
        [self.nextButton setEnabled:NO];
        
    }else
    {
        [self.nextButton setEnabled:YES];

    }
    
    if (arrayGif.count>0) {
        //设置动画数组
        [self.questionMark setAnimationImages:arrayGif];
        //设置动画播放次数
        [self.questionMark setAnimationRepeatCount:0];
        //设置动画播放时间
        [self.questionMark setAnimationDuration:2*1.0];
        //开始动画
        [self.questionMark startAnimating];
        
        
    }
    
    //投稿alert.
    if ((level-10)%10 == 1 ) {
        
        if (!isFromAD) {
            [self setupAlert];
        }
        else
            isFromAD = NO;
   
        
        
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
    
    
    
    UIButton *goInAlert = [[UIButton alloc] initWithFrame:CGRectMake(40, 145, 90, 47)];
    UIButton *cancelInAlert = [[UIButton alloc] initWithFrame:CGRectMake(170, 145, 90, 47)];
    
    if ([CommonUtility isSystemLangChinese]) {
        
        tmpCustomView.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"submitAlert" ofType:@"png"]]];
        
        
        [goInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"okButton" ofType:@"png"]] forState:UIControlStateNormal];
        [cancelInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cancelButton" ofType:@"png"]] forState:UIControlStateNormal];
        
        
    }else
    {
        tmpCustomView.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-submitAlert" ofType:@"png"]]];
        
        
        [goInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-okButton" ofType:@"png"]] forState:UIControlStateNormal];
        [cancelInAlert setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-cancelButton" ofType:@"png"]] forState:UIControlStateNormal];
    }
    
    //    [self.lockedInAlert setTitle:@"前往当前进度" forState:UIControlStateNormal];
    //    self.lockedInAlert.titleLabel.font = [UIFont systemFontOfSize:14.0];
    //    self.lockedInAlert.titleLabel.textColor = [UIColor redColor];
    
    
    //    self.lockedInAlert.backgroundColor = [UIColor greenColor];
    [goInAlert addTarget:self action:@selector(goToLevelNow) forControlEvents:UIControlEventTouchUpInside];
    [cancelInAlert addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchUpInside];
    
    [tmpCustomView addSubview:goInAlert];
    [tmpCustomView addSubview:cancelInAlert];
    
    CustomIOS7AlertView *alert = [[CustomIOS7AlertView alloc] init];
    [alert setButtonTitles:[NSMutableArray arrayWithObjects:nil]];
    alert.backgroundColor = [UIColor whiteColor];
    
    self.submitAlert = alert;
    
    [alert setContainerView:tmpCustomView];
    [alert show];
    
}

-(void)goToLevelNow
{
    [CommonUtility tapSound:@"tapSound" withType:@"wav"];

    moreInfoViewController *more = [[moreInfoViewController alloc] init];
    more.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:more animated:YES completion:Nil ];
    [self.submitAlert close];

}

-(void)closeAlert
{
    [CommonUtility tapSound:@"backAndCancel" withType:@"mp3"];

    [self.submitAlert close];

}

//ad...big
//-(void)bigAd
//{
//    self.interstitial = [[GADInterstitial alloc] init];
//    self.interstitial.delegate = self;
//    
//    AppDelegate *appDelegate =
//    (AppDelegate *)[UIApplication sharedApplication].delegate;
//    self.interstitial.adUnitID = ADMOB_ID_DaysInLine;
//    
//    [self.interstitial loadRequest: [appDelegate createRequest]];
//}

#pragma mark big advertisement

- (void)createAndLoadInterstitial {
    
    if (self.interstitial) {
        self.interstitial = nil;
    }
    self.interstitial = [[GADInterstitial alloc] init];
    self.interstitial.adUnitID = ADMOB_ID_DaysInLine;
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    
    [self.interstitial loadRequest:request];
}

-(void)bigAd {
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self];
    } else {
        NSLog(@"big ad not ready");
        [self createAndLoadInterstitial];
        
        if (ADTimer != nil)
        {
            [ADTimer invalidate];
            ADTimer = nil;
            
        }
        
        ADTimer = [NSTimer scheduledTimerWithTimeInterval:7.0 target:self selector:@selector(bigAd) userInfo:nil repeats:NO];
    }
    
    
}

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");
    [ADTimer invalidate];
    isFromAD = YES;
    ADTimer =nil;
    ADTimer = [NSTimer scheduledTimerWithTimeInterval:50.0 target:self selector:@selector(bigAd) userInfo:nil repeats:NO];
    [self createAndLoadInterstitial];
    
    
}




- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"gamePage"];
    //ad...big
    if (ADTimer != nil)
	{
		[ADTimer invalidate];
		ADTimer = nil;
	}
}

-(void)setupWithEmptyPosition:(NSInteger )px :(NSInteger )py
{
    levelTop = levelTop<level?level:levelTop;
    
    
    [self.levelCount setText:[NSString stringWithFormat:@"%d",level]];
    self.levelCount.font = [UIFont fontWithName:@"SegoePrint" size:23];
    [self.levelCount setTextColor:[UIColor blackColor]];
    
    if (self.wrongLabel.superview) {
        [self.wrongLabel removeFromSuperview];

    }

    
    
    NSString *pic = [NSString stringWithFormat:@"pic%d",level];
    
    NSString *an1 = [NSString stringWithFormat:@"an1-%d",level];
    
    NSString *an2 = [NSString stringWithFormat:@"an2-%d",level];
    
    NSString *an3 = [NSString stringWithFormat:@"an3-%d",level];
    
    
    
    [self setImages:an1:an2 :an3 :pic];

    CGFloat sizeOffside = 0;
    if(IS_IPAD)
    {
        sizeOffside = 55;
    }

    
    if (level%10 == 9) {
        [self.empty setFrame:CGRectMake(px, py, largeEmpty[(level-1)/10], largeEmpty[(level-1)/10])];
        
        [self.questionMark setFrame:CGRectMake(0, 0, largeEmpty[(level-1)/10], largeEmpty[(level-1)/10])];

    }else
    {
   
        [self.empty setFrame:CGRectMake(px, py, 55+sizeOffside, 55+sizeOffside)];
        
        [self.questionMark setFrame:CGRectMake(0, 0, 55+sizeOffside, 55+sizeOffside)];
    }
    if(level ==16)
    {
        [self.empty setFrame:CGRectMake(px, py, 150,150)];
        [self.questionMark setFrame:CGRectMake(0, 0, 150,150)];

    }
    if(level ==17)
    {
        [self.empty setFrame:CGRectMake(px, py, 100,100)];
        [self.questionMark setFrame:CGRectMake(0, 0, 100,100)];
    }
    [self setButton:self.empty];
    self.empty.layer.borderWidth = 0;
    
    self.empty.tag = 0;
    
    for (int i =0; i<3; i++) {
        [((UIButton *)self.choices[i]) setHidden:NO];
    }
    [self.view addSubview:self.empty];
    
    [self.teachView removeFromSuperview];
    [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
    
    
//share change task.    [self.shareBtn setHidden:YES];
    

    if (!haveFixed[level-1]) {
        
        [self.nextButton setEnabled:NO];
        
    }else
    {
        [self.nextButton setEnabled:YES];
  
        
    }
    
    //每个主题的第一关不允许点击上一关
    if (level%10 == 1) {
        [self.priorButton setEnabled:NO];
    }else
    {
        [self.priorButton setEnabled:YES];

    }
    
    [self.animationBegin setHidden:YES];//每关开始不可点击。

 
}

-(void)setImages:(NSString *)rightAns :(NSString *)wrong1 :(NSString *)wrong2 :(NSString *)guess
{
    unsigned int randomNumber = arc4random();
    
    int correctAns = randomNumber%MAXanswer;
    UIButton *rightBtn = self.choices[correctAns];
    
    [rightBtn setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:rightAns ofType:@"png"]] forState:UIControlStateNormal];
    correct[level-1] = correctAns+1;
    
    [self.choices[(correctAns+1)%3] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", wrong1] ofType:@"png"]]forState:UIControlStateNormal];
    [self.choices[(correctAns+2)%3] setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", wrong2] ofType:@"png"]]forState:UIControlStateNormal];
    
    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", wrong1] ofType:@"png"]];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@", guess] ofType:@"png"];
    UIImage *myImage = [UIImage imageWithContentsOfFile:path];
    [self.picture setImage:myImage];

    [self.empty setImage:nil forState:UIControlStateNormal];
    [self.questionMark setHidden:NO];
    
    
}

-(void)setButton:(UIButton *)btn
{
    btn.layer.borderWidth = 1.0f;
    btn.layer.borderColor = [UIColor blackColor].CGColor;
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonTap:(UIButton *)sender
{
//    
//    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"choiceSound" ofType: @"mp3"];
//    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
//    self.myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
//    //    self.myAudioPlayer.numberOfLoops = -1; //infinite loop
//    [self.myAudioPlayer play];

    [CommonUtility tapSound:@"choiceSound" withType:@"mp3"];
    
    if (sender.tag == 0) {
        if (self.empty.imageView.image) {
            [self.empty setImage:nil forState:UIControlStateNormal];
            [self.questionMark setHidden:NO];
            
            for (int i = 0; i<3; i++) {
                if ([((UIButton *) self.choices[i]) isHidden]) {
                    [((UIButton *) self.choices[i]) setHidden:NO];
                }
            }
            [self.wrongLabel removeFromSuperview];
            
        }
        [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }else
    {
        
        for (int i=0; i<3; i++) {
            if ([((UIButton *)self.choices[i]) isHidden]) {
                return;
            }
        }
        
        [((UIButton *) self.choices[sender.tag-1]) setHidden:YES];
        [self.questionMark setHidden:YES];

        [self.empty setImage:((UIButton *) self.choices[sender.tag-1]).imageView.image forState:UIControlStateNormal];
        self.empty.layer.borderWidth = 0;
        
        
        if (sender.tag == correct[level-1] ) {
            
            
            
//            [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(correctAnswer) userInfo:nil repeats:NO];
            [self correctAnswer];
            
        }
        else
        {
//            
//            [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(wrongAnswer) userInfo:nil repeats:NO];
            [self wrongAnswer];
            
            
        }
        
    }
    
    
    
}

-(void)animationOver
{
    [self.animationBegin setHidden:NO];

    [self.empty setHidden:NO];
    if (!haveFixed[level-1]) {
        levelTop++;

        haveFixed[level-1] = YES;

    }
    //每个主题的第一关不允许点击上一关
    if (level%10 == 1) {
        [self.priorButton setEnabled:NO];
        [self.nextButton setEnabled:YES];
        
    }else{
        [self.nextButton setEnabled:YES];
        [self.priorButton setEnabled:YES];
    }
    NSLog(@"%d",haveFixed[level-1]);
    NSLog(@"%d",levelTop);
    
    [self.empty addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)sayEnglish
{
//    AudioServicesPlaySystemSound([self.teachView.soundENObj intValue]);
    [CommonUtility tapSound:wordsEN[level-1] withType:@"wav"];
    
}

-(void)correctAnswer{
    
    
    notJumpOver = YES;
    [self.nextButton setEnabled:NO];
    [self.priorButton setEnabled:NO];

    
    /* fit for 4-inch screen */
//    if ([[UIScreen mainScreen] bounds].size.height == 480) {
//        self.teachView.frame = CGRectMake(80, 60, 160, 100);
//        
//    }else
//    {
//        self.teachView.frame = CGRectMake(80, 70, 160, 120);
//
//    }
    
    [self.teachView.answerCN addTarget:self action:@selector(chineseTap) forControlEvents:UIControlEventTouchUpInside];
    [self.teachView.answerEN addTarget:self action:@selector(englishTap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.teachView];
    
//    AudioServicesPlaySystemSound([self.teachView.soundCNObj intValue]);

    [CommonUtility tapSound:wordsCN[level-1] withType:@"wav"];

    [NSTimer scheduledTimerWithTimeInterval:1.6 target:self selector:@selector(sayEnglish) userInfo:nil repeats:NO];
    
    [self.empty setHidden:YES];

    arrayM=[[NSMutableArray array] init];
    for (int i=1; i<15; i++) {

        UIImage *gif = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"level%d-%d",level,i] ofType:@"png"]];
        if (gif) {
            [arrayM insertObject:gif atIndex:i-1];
            
        }
        else if(i == 1)
        {
            [arrayM removeAllObjects];
            break;
        }
        else
        {
            for (int j=i-1; j<arrayM.count; j++) {
                [arrayM removeObjectAtIndex:j];
            }
            
//            if (arrayM.count>i-1) {
//                [arrayM removeObjectAtIndex:i-1];//make every level's animation with different image count.
//
//            }
        }
    }
    
    if (arrayM.count>0) {
        //设置动画数组
        [self.picture setAnimationImages:arrayM];
        //设置动画播放次数
        [self.picture setAnimationRepeatCount:repeatTime[level-1]];
        //设置动画播放时间
        [self.picture setAnimationDuration:arrayM.count*animationSpeed[level-1]];
        //开始动画
        [self.picture startAnimating];
        
        
    }
    
    double timeInterval =(1.5*self.picture.animationDuration > 3.5)?(1.5*self.picture.animationDuration):3.5;
   
    [self performSelector:@selector(animationOver) withObject:nil afterDelay:timeInterval];
    
    
    
    
}


-(void)choiceBack
{
    //correct记录的是选项tag，1～3而非0～2.
    for (int i = 0; i<3; i++) {
        if ( [((UIButton *) self.choices[i]) isHidden ] && ((i+1) == correct[level-1]) ) {
            return;
        }else if( [((UIButton *) self.choices[i]) isHidden ])
            [((UIButton *) self.choices[i]) setHidden:NO];

    }
    
    if (self.empty.imageView.image) {
        [self.empty setImage:nil forState:UIControlStateNormal];
        [self.questionMark setHidden:NO];
/*
        for (int i = 0; i<3; i++) {
            if ( [((UIButton *) self.choices[i]) isHidden ] ) {
                [((UIButton *) self.choices[i]) setHidden:NO];

            }
        }
 */       
        [self.wrongLabel removeFromSuperview];
        
        [self.empty removeTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];

    }
    
    
}

-(void)wrongAnswer{
    
//    SystemSoundID soundSmile;
//    
//    CFBundleRef CNbundle=CFBundleGetMainBundle();
//    
//    CFURLRef soundfileurl=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)@"衰",CFSTR("wav"),NULL);
//    //创建system sound 对象
//    AudioServicesCreateSystemSoundID(soundfileurl, &soundSmile);
//    AudioServicesPlaySystemSound(soundSmile);
    [CommonUtility tapSound:@"衰" withType:@"wav"];

    
    int scoreTemp = [[scores objectAtIndex:((level-1)/10)] intValue];
    
    [scores setObject:[NSNumber numberWithInt:(scoreTemp +1)] atIndexedSubscript:((level-1)/10)];
    
    
    if([self.teachView superview])
    {
        [self.teachView removeFromSuperview];
    }
    
    CGFloat deviceOffside_size = 0;
    CGFloat deviceOffside_height = 0;
    CGFloat deviceOffside_w = 0;
    CGFloat deviceOffside_h = 0;
    CGFloat cryOffside_size = 0;

    if (IS_IPHONE_6) {
        deviceOffside_size = 30;
        deviceOffside_h = 5;
        deviceOffside_w = 10;
    }else if(IS_IPHONE_6P)
    {
        deviceOffside_size = 40;
        deviceOffside_h = 28;
        deviceOffside_w = 24;
    }else if(IS_IPAD)
    {
        deviceOffside_size = 160;
        deviceOffside_height = 60;

        deviceOffside_h = 46;
        deviceOffside_w = 135;
        cryOffside_size = 40;

    }
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
            self.wrongLabel = [[UIImageView alloc] initWithFrame:CGRectMake(80, 60, 160, 100)];
    }else
    {
        self.wrongLabel = [[UIImageView alloc] initWithFrame:CGRectMake(80+deviceOffside_w, 70+deviceOffside_h, 160+deviceOffside_size, 120+deviceOffside_height)];
    }

    [self.wrongLabel setImage:[UIImage imageNamed:@"board" ]];
    [self.wrongLabel setContentMode:UIViewContentModeScaleToFill];

    UIImageView *cryFace = [[UIImageView alloc] initWithFrame:CGRectMake(self.wrongLabel.frame.size.width/2-65/2, 15, 65+cryOffside_size, 65+cryOffside_size)];
    [cryFace setCenter:CGPointMake(self.wrongLabel.frame.size.width/2, self.wrongLabel.frame.size.height/2)];
    cryFace.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"wrongImg" ofType:@"png"]];
    [self.wrongLabel addSubview:cryFace];
    [self.view addSubview:self.wrongLabel];
    
    //5秒后按钮自动退回
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(choiceBack) userInfo:nil repeats:NO];
    [self.empty addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
   //cancel the border..
    //self.empty.layer.borderWidth = 1.0f;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma alert delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        if (level<MAXlevel) {
            level++;
        }
        [self.myImg setEmptyX:posX[level-1] Y:posY[level-1]];
        [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];
        [self.teachView setWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
        
    }
}


- (IBAction)priorLevel {

    
    [CommonUtility tapSound:@"levelSound" withType:@"mp3"];

    
    [MobClick event:@"2"];
    
    if (level>1) {
        level--;
        
        [self.myImg setEmptyX:posX[level-1] Y:posY[level-1]];
        [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];
        [self.teachView setWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
        
        
    }else if(level ==1)
    {
        return;
    }
}



- (IBAction)nextLevel {

    
    [CommonUtility tapSound:@"levelSound" withType:@"mp3"];
    
    [MobClick event:@"1"];
    
    [arrayM removeAllObjects];
    if (!notJumpOver) {
        int scoreTemp = [[scores objectAtIndex:((level-1)/10)] intValue];
        
        [scores setObject:[NSNumber numberWithInt:(scoreTemp +2)] atIndexedSubscript:((level-1)/10)];
    }
    
    
    if (level%10==0)
    {
        //        [self performSelector:@selector(switchToReward) withObject:nil afterDelay:0.35f];
        rewardViewController *myReward = [[rewardViewController alloc] initWithNibName:@"rewardViewController" bundle:nil];
        myReward.delegate = self;
        myReward.frontImageName = sharePic[(level-1)/10];
        myReward.levelReward = [[NSNumber alloc] initWithInt:((level-1)/10)];
        myReward.afterShutter = NO;
        myReward.backImage.image = nil;
        myReward.willStopDelegate = self;
        
        @try
        {
            myReward.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            [self presentViewController:myReward animated:YES completion:Nil ];
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
        }
        
        
    }else
    {
//        [self performSelector:@selector(changeImgs) withObject:nil afterDelay:0.05f];
        [self changeImgs];
        
    }
    
}
-(void)changeImgs
{
    
    
    if (haveFixed[level-1]) {
        
        if (level<MAXlevel) {
            level++;
            notJumpOver = NO;
            


            [self.myImg setEmptyX:posX[level-1] Y:posY[level-1]];
            [self setupWithEmptyPosition:self.myImg.positionX :self.myImg.positionY];
            [self.teachView setWordsAndSound:wordsCN[level-1] english:wordsEN[level-1] soundCN:wordsCN[level-1] soundEN:wordsEN[level-1]];
            
        }else if(level == MAXlevel )
        {
            
            return;
            
        }
    }

}



- (IBAction)backToLevel {
    
    [CommonUtility tapSound:@"backAndCancel" withType:@"mp3"];

    [self dismissViewControllerAnimated:YES completion:Nil];
    
}

- (IBAction)share {
    
    [CommonUtility tapSound];
    [CommonUtility tapSound:@"tapSound" withType:@"wav"];
    
    sharePhotoViewController *myShare = [[sharePhotoViewController alloc] initWithNibName:@"sharePhotoViewController" bundle:nil];
    myShare.frontImageName = sharePic[(level-1)/10];
    myShare.afterShutter = NO;
    myShare.backImage.image = nil;
    
    myShare.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:myShare animated:YES completion:Nil ];

}

- (IBAction)animationTapped:(id)sender {
    
    [CommonUtility tapSound];

    [self.nextButton setEnabled:NO];
    [self.priorButton setEnabled:NO];
    [self.empty setHidden:YES];

    
    if (arrayM.count>0) {
              //开始动画
        [self.picture startAnimating];
    }
    
    [self performSelector:@selector(animationOnly) withObject:nil afterDelay:self.picture.animationDuration * repeatTime[level-1]];

}
-(void)animationOnly
{
    if (level%10 == 1) {
        [self.priorButton setEnabled:NO];
        [self.nextButton setEnabled:YES];
        
    }else{
        [self.nextButton setEnabled:YES];
        [self.priorButton setEnabled:YES];
    }
    [self.empty setHidden:NO];
}

-(void)chineseTap

{
    [MobClick event:@"5"];
//    AudioServicesPlaySystemSound([self.teachView.soundCNObj intValue]);

    [CommonUtility tapSound:wordsCN[level-1] withType:@"wav"];

}

-(void)englishTap
{
      [MobClick event:@"6"];
//    AudioServicesPlaySystemSound([self.teachView.soundENObj intValue]);
    [CommonUtility tapSound:wordsEN[level-1] withType:@"wav"];

}
-(void)emptyDisappear
{
    [self.empty setHidden:YES];
    [self.questionMark setHidden:YES];
}
-(void)emptyAppear
{
    [self.empty setHidden:NO];
    [self.questionMark setHidden:NO];
}

//#pragma mark - AdViewDelegates
//
//
//- (void)adViewDidReceiveAd:(GADBannerView *)view
//{
//    NSLog(@"Admob load");
//    
//}
//
//// An error occured
//- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
//{
//    NSLog(@"Admob error: %@", error);
//    [self.gAdBannerView removeFromSuperview];
//}
//
//-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    NSLog(@"iad failed");
//    [self.iAdBannerView removeFromSuperview];
//    self.bannerIsVisible = NO;
//    
//    [self.view addSubview:self.gAdBannerView];
//    
//    
//}
//
//
//-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
//    NSLog(@"iAd will load");
//}
//-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
//    NSLog(@"iAd did finish");
//    
//}

#pragma backToLevelDelegate

-(BOOL) isFromReward :(BOOL)check
{
    self.isFormRewordFlag = YES;
    return check;
}



-(void)willStopTimer
{
    [self.stopDelegate stopTimer];
}


//ad...big
//#pragma bigAD delegate method
//- (void)interstitial:(GADInterstitial *)interstitial
//didFailToReceiveAdWithError:(GADRequestError *)error {
//    // Alert the error.
//    
//    NSLog(@"big ad error:%@",[error description]);
//}

//- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
//    [interstitial presentFromRootViewController:self];
//
//}
//- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial
//{
//    [ADTimer invalidate];
//    isFromAD = YES;
//    ADTimer =nil;
//    ADTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(bigAd) userInfo:nil repeats:NO];
//    
//    
//}
@end
