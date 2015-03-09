//
//  rewardViewController.m
//  completeImage
//
//  Created by 张力 on 14-8-8.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "rewardViewController.h"


@interface rewardViewController ()
@property (nonatomic ,strong) UIView *shareView ;
@property (nonatomic ,strong) UIView *bottomBar ;
@property (nonatomic ,strong) UIButton *aBtn;
@property (nonatomic ,strong) UIButton *cancelCamera;
@property (nonatomic ,strong) UIButton *cameraDevice;
@property (nonatomic ,strong) UIButton *shutter;
@property (nonatomic ,strong) UIButton *retakeButton;
@end


@implementation rewardViewController

NSInteger resultNum;
UIImageView *wrongAnswer;
UIButton *cancelInAlert;
UIView *tmpCustomView;

-(int)countBabyLevel
{
    int timeUsed = seconds;
    
    [self.willStopDelegate willStopTimer];
    
    int scoreTemp = [[scores objectAtIndex:[self.levelReward intValue]] intValue];
    
    if (scoreTemp > 9) {
        return 4;
    }else
    {
        if (scoreTemp == 0) {
            if (timeUsed  < TIME_PARENT) {
                return 9;
            }else
            {
            return 0;
            }
        }else
            return (1+(scoreTemp-1)/3);
    }
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        if ([[UIScreen mainScreen] bounds].size.height == 480) {
//
//            [self.backgroundImg setImage:[UIImage imageNamed: @"rewardPage480"]];
//            
//        }else
//        {
//
//            [self.backgroundImg setImage:[UIImage imageNamed: @"rewardPage"]];
//            
//        }
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        if ([CommonUtility isSystemVersionLessThan7]) {
            [self.view setFrame:CGRectMake(0, -20, SCREEN_WIDTH, 480)];
            
        }else
        {
            [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 480)];
            
           
        }

        
    }else
    {
//        [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 568)];
    }
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [self.backBtn  setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    }else
    {
        [self.backBtn setImage:[UIImage imageNamed:@"returnToLevelEN"] forState:UIControlStateNormal];
        [self.backBtn setImage:[UIImage imageNamed:@"returnTappedEN"] forState:UIControlStateHighlighted];
    }
    
    self.babyRewordImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-170)/2, SCREEN_HEIGHT+100, 170, 170)];
    [self.view addSubview:self.babyRewordImg];
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT*60/568, SCREEN_WIDTH, SCREEN_HEIGHT - SCREEN_HEIGHT*73/568 - SCREEN_HEIGHT*60/568)];
    self.shareView.backgroundColor = [UIColor clearColor];
    
    self.frontImage = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH, self.shareView.frame.size.height)];
    self.backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT*60/568, SCREEN_WIDTH, 426)];
    self.rewardImage = [[UIImageView alloc] initWithFrame:CGRectMake(-300,-300,300 ,300)];//frame for animation.
    
    [self.frontImage setClipsToBounds:YES];
    [self.backImage setClipsToBounds:YES];
    
    self.frontImage.backgroundColor = [UIColor clearColor];
    self.backImage.backgroundColor = [UIColor clearColor];
    
    //    [self.shareView addSubview:self.backImage];
    [self.shareView addSubview:self.backImage];
    [self.shareView sendSubviewToBack:self.backImage];
    [self.shareView addSubview:self.frontImage];
    [self.shareView addSubview:self.rewardImage];
    [self.shareView bringSubviewToFront:self.rewardImage];
    
    CGFloat deviceOffset_height=0;
    CGFloat deviceOffset_width=0;
    CGFloat deviceOffset_size=0;
    CGFloat deviceOffset_size_ipad=0;

    //    CGFloat deviceOffset_height=0;
    
    
    if (IS_IPHONE_6) {
        
        deviceOffset_height = 70;
        deviceOffset_width = 10;
        deviceOffset_size= 5;
        
        
        
        
    }else if (IS_IPHONE_6P)
    {
        deviceOffset_height = 120;
        deviceOffset_width = 15;
        deviceOffset_size= 7;
        
    }else if (IS_IPAD)
    {
        deviceOffset_height = 320;
        deviceOffset_width = 15;
        deviceOffset_size= 25;
        deviceOffset_size_ipad = 60;
        
    }
    

    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        self.share = [[UIButton alloc] initWithFrame:CGRectMake(125, 395, 70, 70)];
        self.retakeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 395, 70, 70)];
        self.savePic = [[UIButton alloc] initWithFrame:CGRectMake(243, 408, 50, 50)];
        self.backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 460)];
        [self.backgroundImg setImage:[UIImage imageNamed: @"rewardPage460"]];
        
        self.babyTextImg = [[UIImageView alloc] initWithFrame:CGRectMake(50, 169, 220, 125)];
        self.goCamera = [[UIButton alloc] initWithFrame:CGRectMake(110, 298, 125, 87)];
        
    }else
    {
        self.share = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-(80+deviceOffset_size)/2, SCREEN_HEIGHT-80-deviceOffset_size, 80+deviceOffset_size, 80+deviceOffset_size)];
        self.retakeButton = [[UIButton alloc] initWithFrame:CGRectMake(10+deviceOffset_width, SCREEN_HEIGHT-80-deviceOffset_size, 80+deviceOffset_size, 80+deviceOffset_size)];
        self.savePic = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-(60+deviceOffset_size)-deviceOffset_width, SCREEN_HEIGHT-70-deviceOffset_size, 60+deviceOffset_size, 60+deviceOffset_size)];
        self.backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self.backgroundImg setImage:[UIImage imageNamed: @"rewardPage"]];
        self.babyTextImg = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-240)/2, 209+deviceOffset_height/2, 240, 134)];
        self.goCamera = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 70-deviceOffset_size_ipad/2, 380+deviceOffset_height, 139+deviceOffset_size_ipad, 96+deviceOffset_size_ipad/2)];


    }
    [self.view addSubview:self.backgroundImg];
    self.babyTextImg.alpha = 0;
    [self.view addSubview:self.babyTextImg];
    self.goCamera.alpha = 0;
    [self.goCamera addTarget:self action:@selector(goPhotograph) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.goCamera];

    if ([CommonUtility isSystemLangChinese]) {
        
        [self.goCamera setImage:[UIImage imageNamed:@"goPhoto"] forState:UIControlStateNormal];

        [self.share setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"分享" ofType:@"png"]] forState:UIControlStateNormal];
        [self.retakeButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"重拍" ofType:@"png"]] forState:UIControlStateNormal];
        [self.savePic setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"保存" ofType:@"png"]] forState:UIControlStateNormal];
        
        
    }else
    {
        [self.goCamera setImage:[UIImage imageNamed:@"en-goPhoto"] forState:UIControlStateNormal];

        [self.share setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-分享" ofType:@"png"]] forState:UIControlStateNormal];
        [self.retakeButton setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-重拍" ofType:@"png"]] forState:UIControlStateNormal];
        [self.savePic setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-保存" ofType:@"png"]] forState:UIControlStateNormal];
    }
//    [self.share setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"分享" ofType:@"png"]] forState:UIControlStateNormal];
    [self.share addTarget:self action:@selector(shareAlert) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.retakeButton setImage:[UIImage imageNamed:@"重拍"] forState:UIControlStateNormal];
    [self.retakeButton addTarget:self action:@selector(goPhotograph) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.savePic setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
    [self.savePic addTarget:self action:@selector(saveImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.shareView];
    [self.view sendSubviewToBack:self.shareView];
    
    //    new version

    [self.view addSubview:self.share];
    [self.share setHidden:YES];
    [self.view addSubview:self.retakeButton];
    [self.view addSubview:self.savePic];
    
    [self.retakeButton setHidden:YES];
    [self.savePic setHidden:YES];
    

    
    [self.view bringSubviewToFront: self.backgroundImg];
    [self.view bringSubviewToFront: self.topBar];
    [self.view bringSubviewToFront: self.babyRewordImg];
    [self.view bringSubviewToFront: self.goCamera];
    [self.view bringSubviewToFront:self.babyTextImg];
    
//    [self performSelector:@selector(animationStart) onThread:[[NSThread alloc] init] withObject:nil waitUntilDone:NO];
    
    
        _afterShutter = NO;

}

-(void)animationStart
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(goBigSmall) object:nil];
    
    [thread start];
//    [self goBigSmall];

    

}
-(void)goBigSmall
{
    self.babyRewordImg.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:@"big"context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:2.5];
    self.babyRewordImg.frame=CGRectMake(0 , 180, SCREEN_WIDTH, SCREEN_WIDTH);
    [UIView setAnimationDidStopSelector:@selector(gosmall)];
    [UIView commitAnimations];
    
//    
//    SystemSoundID soundSmile;
//    
//    CFBundleRef CNbundle=CFBundleGetMainBundle();
//    
//    CFURLRef soundfileurl=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)@"smile",CFSTR("wav"),NULL);
//    //创建system sound 对象
//    AudioServicesCreateSystemSoundID(soundfileurl, &soundSmile);
//    AudioServicesPlaySystemSound(soundSmile);
    [CommonUtility tapSound:@"smile" withType:@"wav"];


}
-(void)gosmall
{
    CGFloat offside = 0;
    if (IS_IPHONE_6) {
        offside = 20;
    }else if(IS_IPHONE_6P)
    {
        offside = 30;
    }else if(IS_IPAD)
    {
        offside = 90;
    }
    
    self.babyRewordImg.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:@"small"context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        self.babyRewordImg.frame=CGRectMake((SCREEN_WIDTH-140)/2 , 55, 140, 140);

    }else
    {
        self.babyRewordImg.frame=CGRectMake((SCREEN_WIDTH-170)/2 , 62+offside, 170, 170);

    }
    [UIView setAnimationDidStopSelector:@selector(fadeIn)];
    [UIView commitAnimations];
    
}

-(void)fadeIn
{
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"reward" ofType: @"mp3"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
    self.myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
//    self.myAudioPlayer.numberOfLoops = -1; //infinite loop
    [self.myAudioPlayer play];
    
    
    self.babyTextImg.transform = CGAffineTransformIdentity;
    self.goCamera.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:@"fadeIn"context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1.5];
    self.goCamera.alpha = 1.0;
    self.babyTextImg.alpha = 1.0;
    [UIView commitAnimations];

    
}

//- (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView {
//    CABasicAnimation *animation = [ CABasicAnimation
//                                   animationWithKeyPath: @"transform" ];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    //围绕Z轴旋转，垂直与屏幕
//    animation.toValue = [ NSValue valueWithCATransform3D:
//                         CATransform3DMakeRotation(M_PI/2, 0.0, 0.0, 1.0) ];
//    animation.duration = 0.4;
//    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
//    animation.cumulative = YES;
//    animation.repeatCount = 16;
////    animation.removedOnCompletion = YES;
//    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
//    UIGraphicsBeginImageContext(imageRrect.size);
//    [imageView.image drawInRect:imageRrect];
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [imageView.layer addAnimation:animation forKey:nil ];
//    return imageView;
//}
//
//- (UIImageView *)bigWithImageView:(UIImageView *)imageView {
//    CABasicAnimation *animation = [ CABasicAnimation
//                                   animationWithKeyPath: @"transform" ];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    //围绕Z轴旋转，垂直与屏幕
//    animation.toValue = [ NSValue valueWithCATransform3D:CATransform3DMakeScale(1.5, 1.5,1.5 )
//                         ];
//
//    animation.duration = 0.5;
//    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
//    animation.cumulative = YES;
//    animation.repeatCount = 2;
////    animation.removedOnCompletion = YES;
//    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
//    UIGraphicsBeginImageContext(imageRrect.size);
//    [imageView.image drawInRect:imageRrect];
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [imageView.layer addAnimation:animation forKey:nil ];
//    return imageView;
//}
//
//- (UIImageView *)smallWithImageView:(UIImageView *)imageView {
//    CABasicAnimation *animation = [ CABasicAnimation
//                                   animationWithKeyPath: @"transform" ];
//    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    animation.toValue = [ NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5,0.5 )
//                         ];
//    animation.duration = 0.4;
//    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
//    animation.cumulative = YES;
//    animation.repeatCount = 1;
////    animation.removedOnCompletion = YES;
//    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
//    UIGraphicsBeginImageContext(imageRrect.size);
//    [imageView.image drawInRect:imageRrect];
//    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [imageView.layer addAnimation:animation forKey:nil ];
//    return imageView;
//}

-(void)viewWillAppear:(BOOL)animated
{

    [MobClick beginLogPageView:@"rewardPage"];
    
    [self.babyRewordImg setFrame:CGRectMake((SCREEN_WIDTH-170)/2, SCREEN_HEIGHT+100, 170, 170)];


    if ([CommonUtility isSystemLangChinese]) {
        
  
        [self.babyTextImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"babyText%d",[self countBabyLevel]]]];
        [self.babyRewordImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"baby%d",[self countBabyLevel]]]];
        [self.rewardImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"baby%d",[self countBabyLevel]]]];
    }else
    {
   
        [self.babyTextImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"en-babyText%d",[self countBabyLevel]]]];
        [self.babyRewordImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"en-baby%d",[self countBabyLevel]]]];
        [self.rewardImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"en-baby%d",[self countBabyLevel]]]];
    }



    
    if (_afterShutter){
        [self.goCamera setHidden:YES];
        [self.backgroundImg setHidden:YES];
        [self.babyRewordImg setHidden:YES];
        [self.babyTextImg setHidden:YES];
        [self.share setHidden:NO];
        [self.retakeButton setHidden:NO];
        [self.savePic setHidden:NO];


        
        if ([[UIScreen mainScreen] bounds].size.height == 480) {

            UIImageView *bottombar = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-SCREEN_HEIGHT*73/568-20, SCREEN_WIDTH, SCREEN_HEIGHT*73/568)];
            [bottombar setImage:[UIImage imageNamed:@"bottomImage"]];
            [self.view addSubview:bottombar];
//            [self.view bringSubviewToFront:bottombar];
            
//            self.view.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"拍照底图480" ofType:@"png"]]];
            [self.view bringSubviewToFront:self.share];
            [self.view bringSubviewToFront:self.savePic];
            [self.view bringSubviewToFront:self.retakeButton];
            
            [self.frontImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@480",self.frontImageName]]];
        }else
        {
//           self.view.backgroundColor = [UIColor colorWithPatternImage:    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"拍照底图" ofType:@"png"]]];
            UIGraphicsBeginImageContext(self.view.frame.size);
            [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"拍照底图" ofType:@"png"]] drawInRect:self.view.bounds];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            self.view.backgroundColor = [UIColor colorWithPatternImage:image];
            
            [self.frontImage setImage:[UIImage imageNamed:self.frontImageName]];
        }
        
        
    }else//未拍摄时的界面
    {
        [self.frontImage setImage:nil];
        [self.view bringSubviewToFront: self.topBar];
        [self.share setHidden:YES];
        [self.retakeButton setHidden:YES];
        [self.savePic setHidden:YES];
        [self.goCamera setHidden:NO];
        [self.backgroundImg setHidden:NO];
        [self.babyRewordImg setHidden:NO];
      
        self.goCamera.alpha = 0.0f;
        self.babyTextImg.alpha = 0.0f;
        
        [self performSelector:@selector(animationStart) withObject:nil afterDelay:0.15f];
        
        //   [self.saveImage setHidden:YES];
        
    }

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"rewardPage"];
}

-(void)viewDidDisappear:(BOOL)animated
{
//    self.backImage.image = nil;
//    _afterShutter = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveImage:(id)sender {
    
    
    [CommonUtility tapSound:@"tapSound" withType:@"wav"];

    
    [self.shareView sendSubviewToBack:self.backImage];
    
    UIGraphicsBeginImageContext(self.shareView.frame.size);
    
    
    //获取图像
    [self.shareView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageShare = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(imageShare, nil, nil,nil);
    
    UIAlertView *successAlert = [[UIAlertView alloc] initWithTitle:@"成功保存" message:@"已将保存萌照至系统相册" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [successAlert show];
    
}

- (IBAction)goPhotograph {
    
    [CommonUtility tapSound:@"tapSound" withType:@"wav"];
    
    
    CGFloat deviceOffset_height=0;
    CGFloat deviceOffset_width=0;
    CGFloat deviceOffset_size=0;
    CGFloat deviceOffset_size_ipad=0;
    
    if (IS_IPAD)
    {
        deviceOffset_height = 10;
        deviceOffset_width = 15;
        deviceOffset_size= 50;
        deviceOffset_size_ipad = 30;
        
    }
    

    //  [UIApplication sharedApplication].statusBarHidden = YES;
    if([CommonUtility isSystemVersionLessThan7])
    {
        self.SharePhotoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }else
    {
        self.SharePhotoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
//    [self.SharePhotoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"拍照底图480"]]];
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"拍照底图480" ofType:@"png"]] drawInRect:self.view.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.SharePhotoView.backgroundColor = [UIColor colorWithPatternImage:image];
        
        self.cancelCamera = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, 45, 32)];
        self.cameraDevice = [[UIButton alloc] initWithFrame:CGRectMake(250, 10, 40, 32)];
    }else
    {
//        [self.SharePhotoView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 568)];
//        [self.SharePhotoView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"拍照底图"]]];
        UIGraphicsBeginImageContext(self.view.frame.size);
        [[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"拍照底图" ofType:@"png"]] drawInRect:self.view.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        UIImageView *PhotoBackground = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        
        PhotoBackground.image = [UIImage imageNamed:@"拍照底图"];
        
        [self.view addSubview:PhotoBackground];
        [self.view sendSubviewToBack:PhotoBackground];
        
//        [self.view sendSubviewToBack:shareBackground];

        
        
        self.SharePhotoView.backgroundColor = [UIColor colorWithPatternImage:image];
        
        self.cancelCamera = [[UIButton alloc] initWithFrame:CGRectMake(15+deviceOffset_width, 18+deviceOffset_height, 50+deviceOffset_size, 36+deviceOffset_size*2/3)];
        self.cameraDevice = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70-deviceOffset_width*3, 20+deviceOffset_height, 45+deviceOffset_size, 36+deviceOffset_size*2/3)];
        
//        self.cancelCamera = [[UIButton alloc] initWithFrame:CGRectMake(15, 18, 50, 36)];
//        self.cameraDevice = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, 20, 45, 36)];
        
    }
    

    UIView *topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*60/568)];
    //    topBar.backgroundColor = [UIColor colorWithRed:255/255.0f green:167/255.0f blue:22/255.0f alpha:1.0f];
    topBar.backgroundColor = [UIColor clearColor];
    if ([CommonUtility isSystemLangChinese]) {
        
        [self.cancelCamera setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
        [self.cancelCamera setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    }else
    {
        [self.cancelCamera setImage:[UIImage imageNamed:@"returnToLevelEN"] forState:UIControlStateNormal];
        [self.cancelCamera setImage:[UIImage imageNamed:@"returnTappedEN"] forState:UIControlStateHighlighted];
    }
//    [self.cancelCamera setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
//    [self.cancelCamera setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    [self.cancelCamera addTarget:self action:@selector(returnToShare) forControlEvents:UIControlEventTouchUpInside];
    
//    self.cameraDevice = [[UIButton alloc] initWithFrame:CGRectMake(250, 20, 50, 36)];
    [self.cameraDevice setImage:[UIImage imageNamed:@"前后摄像头"] forState:UIControlStateNormal];
    [self.cameraDevice addTarget:self action:@selector(exchangeDevice) forControlEvents:UIControlEventTouchUpInside];
    [topBar addSubview:self.cameraDevice];
    [topBar addSubview:self.cancelCamera];
    
    
    self.bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-(SCREEN_HEIGHT*73/568), SCREEN_WIDTH, SCREEN_HEIGHT*73/568)];
    //    self.bottomBar.backgroundColor = [UIColor colorWithRed:255/255.0f green:167/255.0f blue:22/255.0f alpha:1.0f];
    
    self.bottomBar.backgroundColor = [UIColor clearColor];
    
//    self.shutter = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-30, 5, 70, 50)];
        self.shutter = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-30-deviceOffset_size*3/5, 5+deviceOffset_height*1.5, 70+deviceOffset_size*1.3, 50+deviceOffset_size)];
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [self.shutter setImage:[UIImage imageNamed:@"shutter"] forState:UIControlStateNormal];

    }else
    {
        [self.shutter setImage:[UIImage imageNamed:@"shutterEN"] forState:UIControlStateNormal];
    }
    [self.shutter addTarget:self action:@selector(takeMyPic) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.bottomBar addSubview:self.shutter];
    UIImageView *backImage = [[UIImageView alloc] init];

    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        [backImage setFrame:CGRectMake(0, topBar.frame.size.height+8, SCREEN_WIDTH, (SCREEN_HEIGHT - topBar.frame.size.height - self.bottomBar.frame.size.height))];
        [backImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@480",self.frontImageName]]];

    }else
    {
        [backImage setFrame:CGRectMake(0, topBar.frame.size.height, SCREEN_WIDTH, (SCREEN_HEIGHT - topBar.frame.size.height - self.bottomBar.frame.size.height))];
        [backImage setImage:[UIImage imageNamed:self.frontImageName]];
   
    }

    
    
    //    self.aBtn = [[UIButton alloc] init] ;
    //    [self.aBtn setImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
    //    [self.aBtn setTitle:@"start" forState:UIControlStateNormal];
    //    [self.aBtn setFrame:CGRectMake(0, 430, 100, 50)];
    //
    //    [self.aBtn addTarget:self action:@selector(takeMyPic) forControlEvents:UIControlEventTouchUpInside];
    
    //    [self.SharePhotoView addSubview:self.aBtn];
    
    [self.SharePhotoView addSubview:backImage];
    [self.SharePhotoView addSubview:topBar];
    [self.SharePhotoView addSubview:self.bottomBar];
    
    
    //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
    @try {
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        self.picker = [[UIImagePickerController alloc] init];
        
        self.picker.delegate = self;
        self.picker.allowsEditing = YES;
        self.picker.sourceType = sourceType;
        self.picker.cameraOverlayView = self.SharePhotoView;
        self.picker.showsCameraControls = NO;
        UIDevice *currentDevice = [UIDevice currentDevice];
        
        while ([currentDevice isGeneratingDeviceOrientationNotifications])
            [currentDevice endGeneratingDeviceOrientationNotifications];
        
        [self presentViewController:self.picker animated:YES completion:Nil];
        
        while ([currentDevice isGeneratingDeviceOrientationNotifications])
            [currentDevice endGeneratingDeviceOrientationNotifications];
    }
    @catch (NSException *exception)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Camera" message:[NSString stringWithFormat: @"Camera is not available\n%@",exception]delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }

}



-(void)exchangeDevice
{
    if (self.picker.cameraDevice ==UIImagePickerControllerCameraDeviceFront) {
        self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }else
        self.picker.cameraDevice =UIImagePickerControllerCameraDeviceFront;
}

-(void)takeMyPic
{
    //    [self.cancelCamera setHidden:YES];
    //    [self.cameraDevice setHidden:YES];
    //    [self.shutter setHidden:YES];
    //    [self.retakeButton setHidden:NO];
    
    [self.picker takePicture];
    _afterShutter = YES;
    //[self.picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)returnToShare
{
    [CommonUtility tapSound:@"backAndCancel" withType:@"mp3"];

    [self dismissViewControllerAnimated:YES completion:Nil];
    
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    // /* change to custom VC.
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    
    CGFloat photoOffside = 0;
    if (IS_IPAD) {
        photoOffside = SCREEN_HEIGHT*60/568-40;
    }
    [self.backImage setFrame: CGRectMake(0,-SCREEN_HEIGHT*60/568+photoOffside, SCREEN_WIDTH, self.shareView.frame.size.height)];
    self.backImage.image = image;
//    [self.view sendSubviewToBack:shareBackground];
    
    [self performSelector:@selector(goAttachThread) withObject:nil afterDelay:0.5f];
    

    
    
}

-(void)goAttachThread
{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(goAttach) object:nil];
    
    [thread start];
}

-(void)goAttach
{
    CGFloat offside = 0;
    if (IS_IPHONE_6) {
        offside = 20;
    }else if(IS_IPHONE_6P)
    {
        offside = 30;
    }else if(IS_IPAD)
    {
        offside = 90;
    }
    
    self.rewardImage.transform = CGAffineTransformIdentity;
    [UIView beginAnimations:@"goAttach"context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:1.0];
    self.rewardImage.frame=CGRectMake(SCREEN_WIDTH-(170+offside), SCREEN_HEIGHT-(170+offside*3.2),170+offside ,170+offside);
    
    [UIView setAnimationDidStopSelector:@selector(soundStart)];

    
    [UIView commitAnimations];
}

-(void)soundStart
{
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"reward" ofType: @"mp3"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath ];
    self.myAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    //    self.myAudioPlayer.numberOfLoops = -1; //infinite loop
    [self.myAudioPlayer play];
}
- (IBAction)backButton {
    
//    self.isBackFromReward = YES;
    [CommonUtility tapSound:@"backAndCancel" withType:@"mp3"];

    [self.delegate isFromReward:YES];

    [self dismissViewControllerAnimated:NO completion:nil];



}

-(void)closeAlert
{
    [CommonUtility tapSound:@"backAndCancel" withType:@"mp3"];
    
    [self.lockedAlert close];
}

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
    [answer addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    
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


      [MobClick event:@"4"];
    
//  id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
//                                                         allowCallback:NO
//                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
//                                                          viewDelegate:nil
//                                               authManagerViewDelegate:nil];
//    
//    [authOptions setFollowAccounts:[NSDictionary dictionaryWithObjectsAndKeys:
//                                    [ShareSDK userFieldWithType:SSUserFieldTypeName value:@"clcstudio@163.com"],
//                                    SHARE_TYPE_NUMBER(ShareTypeSinaWeibo),
//                                    nil]];
    
    

    
    [self.shareView sendSubviewToBack:self.backImage];
    UIGraphicsBeginImageContext(self.shareView.frame.size);
    //获取图像
    [self.shareView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageShare = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(imageShare, nil, nil,nil);
    
    //    [ShareSDK pngImageWithImage:imageShare];
    
    
    //    [self saveToPath:imageShare];
    //
    //    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"smartbabyImg%ld",(ImgIndex-1)]  ofType:@"png"];
    
    
    
    //
    //
    //    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    //    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK"  ofType:@"jpg"];
    
    //构造分享内容
    NSString *message;
    
    if ([CommonUtility isSystemLangChinese]) {
        message = @"宝宝识图－中英双语看图识字\n我最聪明我最棒，开动脑筋和我一起进步吧!";
    }else
    {
        message = @"Flash Cards-Talk&Active\nDownload : https://itunes.apple.com/us/app/bao-bei-pin-ba-mian-fei-ban/id936064964?ls=1&mt=8";
    }
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"53f866f1fd98c5860a021da6"
                                      shareText:message
                                     shareImage:imageShare
                                shareToSnsNames:@[UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToFacebook,UMShareToQQ,UMShareToQzone]
                                       delegate:(id)self];
    
    // music url
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"https://itunes.apple.com/cn/app/bao-bei-pin-ba-mian-fei-ban/id936064964?ls=1&mt=8"];
    
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"https://itunes.apple.com/cn/app/bao-bei-pin-ba-mian-fei-ban/id936064964?ls=1&mt=8";
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://itunes.apple.com/cn/app/bao-bei-pin-ba-mian-fei-ban/id936064964?ls=1&mt=8";
    [UMSocialData defaultData].extConfig.qqData.url = @"https://itunes.apple.com/cn/app/bao-bei-pin-ba-mian-fei-ban/id936064964?ls=1&mt=8";
    [UMSocialData defaultData].extConfig.qzoneData.url = @"https://itunes.apple.com/cn/app/bao-bei-pin-ba-mian-fei-ban/id936064964?ls=1&mt=8";
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
-(void)textFieldDidChange:(UITextField *)sender
{
    UITextField *textField = (UITextField *)sender;
    
    
    
    if([textField.text isEqualToString:[NSString stringWithFormat:@"%ld",(long)resultNum]])
    {
        [self.lockedAlert close];
        [self shareFunc];
        
    }
    
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField.text isEqualToString:[NSString stringWithFormat:@"%ld",(long)resultNum]])
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
    [textField resignFirstResponder];
    return YES;
}

-(void)redrawCancel
{
    [cancelInAlert setFrame:CGRectMake(170, 145, 90, 47)];
    [tmpCustomView addSubview:cancelInAlert];
}
@end
