//
//  teachingView.m
//  completeImage
//
//  Created by 张力 on 14-6-16.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "teachingView.h"
#import "globalVar.h"

@implementation teachingView


SystemSoundID soundCN;
SystemSoundID soundEN;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(id)initWithWordsAndSound:(NSString *)chinese english:(NSString *)eng soundCN:(NSString *)sndCN soundEN:(NSString *)sndEN
{
    self = [super init];

    if (self) {
        CGFloat deviceOffside_size = 0;
        CGFloat deviceOffside_w = 0;
        CGFloat deviceOffside_h = 0;
        CGFloat deviceOffside_height = 0;
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
            cryOffside_size = 25;
            
        }
        
        if ([[UIScreen mainScreen] bounds].size.height == 480) {
            
            self.frame = CGRectMake(80, 60, 160, 100);
            self.answerCN = [[UIButton alloc] initWithFrame:CGRectMake(20, 15, 110, 35)];
            self.answerEN = [[UIButton alloc] initWithFrame:CGRectMake(20, 55, 110, 35)];
            
        }else
        {
            
            self.frame = CGRectMake(80+deviceOffside_w, 70+deviceOffside_h, 160+deviceOffside_size, 120+deviceOffside_height);
            
            self.answerCN = [[UIButton alloc] initWithFrame:CGRectMake(15+deviceOffside_size/2-cryOffside_size, 13+cryOffside_size/2, 140+cryOffside_size*1.85, 45+cryOffside_size*0.9)];
            self.answerEN = [[UIButton alloc] initWithFrame:CGRectMake(15+deviceOffside_size/2-cryOffside_size, 62+1.2*cryOffside_size, 140+cryOffside_size*1.85, 45+cryOffside_size*0.9)];
            
        }
        
        UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [backImg setImage:[UIImage imageNamed:@"board" ]];
        [backImg setContentMode:UIViewContentModeScaleToFill];
        [self.answerCN setContentMode:UIViewContentModeScaleToFill];
        [self.answerEN setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:backImg];
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"board" ]];
        

 /*//       self.answerCN .backgroundColor =[UIColor greenColor];
        [self.answerCN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.answerEN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       
        UIImageView *amplifierCN = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amplifier"] highlightedImage:[UIImage imageNamed:@"amplifier2"]];
        
        UIImageView *amplifierEN = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"amplifier"] highlightedImage:[UIImage imageNamed:@"amplifier2"]];
        amplifierCN.frame = CGRectMake(105, 9, 25, 25);
        amplifierEN.frame = CGRectMake(105, 9, 25, 25);

        [self.answerCN addSubview:amplifierCN];
        [self.answerEN addSubview:amplifierEN];

        [self.answerCN setTitle:chinese forState:UIControlStateNormal];
        [self.answerEN setTitle:eng forState:UIControlStateNormal];
        self.answerCN.titleLabel.font = [UIFont fontWithName:@"SegoePrint" size:20];
        self.answerEN.titleLabel.font = [UIFont fontWithName:@"SegoePrint" size:20];
        [self bringSubviewToFront:self.answerCN];
 */
        [self.answerCN setImage:[UIImage imageNamed:chinese] forState:UIControlStateNormal];
        [self.answerEN setImage:[UIImage imageNamed:eng] forState:UIControlStateNormal];

        
        [self addSubview:self.answerEN];
        [self addSubview:self.answerCN];
        
        CFBundleRef CNbundle=CFBundleGetMainBundle();
        
        //获得声音文件URL
        CFURLRef soundfileurlCN=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)sndCN,CFSTR("wav"),NULL);
        //创建system sound 对象
        AudioServicesCreateSystemSoundID(soundfileurlCN, &soundCN);
        
      //  CFBundleRef ENbundle=CFBundleGetMainBundle();
        
        //获得声音文件URL
        CFURLRef soundfileurlEN=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)sndEN,CFSTR("wav"),NULL);
        //创建system sound 对象
        AudioServicesCreateSystemSoundID(soundfileurlEN, &soundEN);
        
        self.soundCNObj = [NSNumber numberWithInt:soundCN];
        self.soundENObj = [NSNumber numberWithInt:soundEN];
        
    
        
        
    }
    
    return self;

}


-(void)setWordsAndSound:(NSString *)chinese english:(NSString *)eng soundCN:(NSString *)sndCN soundEN:(NSString *)sndEN
{
//    [self.answerCN setTitle:chinese forState:UIControlStateNormal];
//    [self.answerEN setTitle:eng forState:UIControlStateNormal];
//    
    [self.answerCN setImage:[UIImage imageNamed:chinese] forState:UIControlStateNormal];
    [self.answerEN setImage:[UIImage imageNamed:eng] forState:UIControlStateNormal];
    
    CFBundleRef CNbundle=CFBundleGetMainBundle();
    
    //获得声音文件URL
    CFURLRef soundfileurlCN=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)sndCN,CFSTR("wav"),NULL);
    //创建system sound 对象
    AudioServicesCreateSystemSoundID(soundfileurlCN, &soundCN);
    
//    CFBundleRef ENbundle=CFBundleGetMainBundle();
    
    //获得声音文件URL
    CFURLRef soundfileurlEN=CFBundleCopyResourceURL(CNbundle,(__bridge CFStringRef)sndEN,CFSTR("wav"),NULL);
    //创建system sound 对象
    AudioServicesCreateSystemSoundID(soundfileurlEN, &soundEN);
    
    self.soundCNObj = [NSNumber numberWithInt:soundCN];
    self.soundENObj = [NSNumber numberWithInt:soundEN];
}

@end
