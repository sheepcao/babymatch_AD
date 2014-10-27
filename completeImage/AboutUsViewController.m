//
//  AboutUsViewController.m
//  completeImage
//
//  Created by 张力 on 14-8-17.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 50, 36)];

    if ([[UIScreen mainScreen] bounds].size.height == 480) {
     
        [backBtn setFrame:CGRectMake(15, 12, 50, 36)];
    }
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [backBtn setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    }else
    {
        [backBtn setImage:[UIImage imageNamed:@"returnToLevelEN"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"returnTappedEN"] forState:UIControlStateHighlighted];
    }

    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];

    
    UIImageView *fullScreen = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    fullScreen.contentMode = UIViewContentModeScaleAspectFit;
    
    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        [fullScreen setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aboutUs460" ofType:@"png"]]];

    
    }else
    {
        if ([CommonUtility isSystemLangChinese]) {
            
            [fullScreen setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aboutUs" ofType:@"png"]]];

        }else
        {
            [fullScreen setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-aboutUs" ofType:@"png"]]];

        }
        

    }
    [self.view addSubview:fullScreen];
    [self.view addSubview:backBtn];
    [self.view bringSubviewToFront:backBtn];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"aboutPage"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"aboutPage"];
}

-(void)backTapped
{
    [CommonUtility tapSound:@"backAndCancel" withType:@"mp3"];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
