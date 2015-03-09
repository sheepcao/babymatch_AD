//
//  moreInfoViewController.m
//  completeImage
//
//  Created by 张力 on 14-8-17.
//  Copyright (c) 2014年 张力. All rights reserved.
//

#import "moreInfoViewController.h"
#import <MessageUI/MessageUI.h>

@interface moreInfoViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation moreInfoViewController

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
    // Do any additional setup after loading the view.
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 20, 50, 36)];
    UIButton *goAppstore = [[UIButton alloc] initWithFrame:CGRectMake(110, self.view.frame.size.height/2-70,100 , 51)];
    UIButton *submitEmail = [[UIButton alloc] initWithFrame:CGRectMake(110, self.view.frame.size.height/2+210,100, 51)];
    CGFloat deviceOffset_height=0;
    CGFloat deviceOffset_width=0;
    CGFloat deviceOffset_size=0;
    CGFloat deviceOffset_top=0;

    
    if (IS_IPHONE_6) {
        deviceOffset_height = 35;
        deviceOffset_width = 24;
        deviceOffset_size= 5;
    }else if(IS_IPHONE_6P)
    {
        deviceOffset_height = 60;
        deviceOffset_width = 42;
        deviceOffset_size= 7;
    }
    else if(IS_IPAD)
    {
        deviceOffset_height = 200;
        deviceOffset_width = 210;
        deviceOffset_size= 47;
        deviceOffset_top = 40;
        [backBtn setFrame:CGRectMake(15, 30, 90, 60)];
    }
    
    [goAppstore setFrame:CGRectMake(110+deviceOffset_width, self.view.frame.size.height/2-70-deviceOffset_top,100+deviceOffset_size , 51+deviceOffset_size/2)];
    [submitEmail setFrame:CGRectMake(110+deviceOffset_width, self.view.frame.size.height/2+210+deviceOffset_height-deviceOffset_top/2,100+deviceOffset_size, 51+deviceOffset_size/2)];


    if ([[UIScreen mainScreen] bounds].size.height == 480) {
        
        [backBtn setFrame:CGRectMake(15, 12, 50, 36)];
        [goAppstore setFrame:CGRectMake(110, self.view.frame.size.height/2-70, 100, 51)];
        [submitEmail setFrame:CGRectMake(110, self.view.frame.size.height/2+170, 100, 51)];

    }
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [backBtn setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    }else
    {
        [backBtn setImage:[UIImage imageNamed:@"returnToLevelEN"] forState:UIControlStateNormal];
        [backBtn setImage:[UIImage imageNamed:@"returnTappedEN"] forState:UIControlStateHighlighted];
    }
//    [backBtn setImage:[UIImage imageNamed:@"returnToLevel"] forState:UIControlStateNormal];
//    [backBtn setImage:[UIImage imageNamed:@"returnTapped"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *fullScreen = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    fullScreen.contentMode = UIViewContentModeScaleToFill;
    if ([[UIScreen mainScreen] bounds].size.height == 480) {

        if ([CommonUtility isSystemLangChinese]) {
            
            
            [fullScreen setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"morePage460" ofType:@"png"]]];
        }else
        {
            [fullScreen setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-morePage460" ofType:@"png"]]];
            
        }

    }else
    {
        if ([CommonUtility isSystemLangChinese]) {
            
            [fullScreen setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"morePage" ofType:@"png"]]];

        }else
        {
            [fullScreen setImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"en-morePage" ofType:@"png"]]];

        }

    }
    [self.view addSubview:fullScreen];
    [self.view addSubview:backBtn];
    [self.view bringSubviewToFront:backBtn];
    
    if ([CommonUtility isSystemLangChinese]) {
        
        [goAppstore setImage:[UIImage imageNamed:@"goComment"] forState:UIControlStateNormal];
        [submitEmail setImage:[UIImage imageNamed:@"goSubmit"] forState:UIControlStateNormal];


    }else
    {
        
        [goAppstore setImage:[UIImage imageNamed:@"en-goComment"] forState:UIControlStateNormal];
        [submitEmail setImage:[UIImage imageNamed:@"en-goSubmit"] forState:UIControlStateNormal];
        
    }
    
    [goAppstore addTarget:self action:@selector(gotoStore) forControlEvents:UIControlEventTouchUpInside];
//    new version
    [self.view addSubview:goAppstore];
    [self.view bringSubviewToFront:goAppstore];
    
    [submitEmail addTarget:self action:@selector(emailMe) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitEmail];
    [self.view bringSubviewToFront:submitEmail];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"morePage"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"morePage"];
}


//- (IBAction)selectForAlbumButtonClick:(UIButton *)sender
//{
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    imagePickerController.delegate = self;
//    [self presentViewController:imagePickerController animated:YES completion:nil];
//    imagePickerController.allowsEditing = YES;
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//}
//
//
//- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
//{
//    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
//    
//    // 获取沙盒目录
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
//                          stringByAppendingPathComponent:imageName];
//    
//    // 将图片写入文件
//    [imageData writeToFile:fullPath atomically:NO];
// 
//}
//
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//	[picker dismissViewControllerAnimated:YES completion:^{}];
//    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//    NSString *UUID = [[NSUUID UUID] UUIDString];
//    NSString *name = [NSString stringWithFormat:@"%@.png", UUID];
//    
//    [self saveImage:image withName: name];
//    
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
//    
//    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    int index = 0;
//    if ([self.imageName isEqualToString:@""] || self.imageName == nil) {
//        self.imageName = name;
//    } else {
//        self.imageName = [NSString stringWithFormat:@"%@;%@", self.imageName, name];
//        index = (int)[[self.imageName componentsSeparatedByString:@";"] count] - 1;
//    }
//    // [[self.imageView objectAtIndex:index] setImage:savedImage];
//    //button for every imageView
//    
//    //[[self.imageViewButton objectAtIndex:index] setFrame:[[self.imageView objectAtIndex:index] frame]];
//    // [self.view addSubview:[self.imageViewButton objectAtIndex:index]];
//    // [[self.imageViewButton objectAtIndex:index] setTag:index+IMAGEBUTTON_TAG_BASE];
//    //  //NSLog(@"button tag is :%d",((UIButton *)self.imageViewButton[index]).tag );
//    [[self.imageAttach objectAtIndex:index] setImage:savedImage forState:UIControlStateNormal];
//    [[self.imageAttach objectAtIndex:index] addTarget:self action:@selector(pictureTapped:) forControlEvents:UIControlEventTouchUpInside];
//    
//}
//

-(void)emailMe
{
   [CommonUtility tapSound:@"tapSound" withType:@"wav"];

    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    [picker.view setFrame:CGRectMake(0,20 , 320, self.view.frame.size.height-20)];
    picker.mailComposeDelegate = self;
    
    
    
    // Set up recipients
    NSArray *toRecipients = [NSArray arrayWithObject:@"clcstudio@163.com"];
    
    
    [picker setToRecipients:toRecipients];
//    
//    // Attach an image to the email
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"" ofType:@"png"];
//    NSData *myData = [NSData dataWithContentsOfFile:path];
//    [picker addAttachmentData:myData mimeType:@"image/png" fileName:@""];
    
    // Fill out the email body text
    NSString *emailBody= @"";
    if ([CommonUtility isSystemLangChinese]) {
        [picker setSubject:@"投稿"];
        emailBody = @"亲爱的BabyMatch用户，\n只要拍下宝宝的绘画作品投稿，您宝宝的大作就有机会成为新的游戏关卡！只需三步哦！\n1、宝宝绘画——围绕着某一个特定主题宝宝进行绘画，可以画在纸上或者平板电脑上\n2、家长拍照——用像素较高的手机或相机拍下您宝宝的绘画作品，如果在平板上绘画直接截屏或保存图片\n3、签名发送——邮件标题或正文写清宝宝名字，宝宝年龄，以及绘画主题，我们会把这些信息清晰的附在图片之中。\n\n我们将会选出适合猜图、图片清晰的作品作为新游戏的素材！\n宝宝也可以是APP设计师！快快投稿吧！\n\n投稿标题示例：\n张小宝，5岁，小鸟在唱歌\n(注：手机用户直接双击邮件正文选择添加图片。)";
    }else
    {
    
        [picker setSubject:@"Subscription"];
        emailBody = @"Dear user,\nJust take a photo of your baby’s painting, and your sweetheart’s masterpiece will likely become the material of our new game level.Only three steps are needed. Simple and easy!\nStep 1: baby draw – your baby can draw whatever he/she like on certain theme, either on a piece of paper or iPad.\nStep 2: parents shoot – please take a photo of your baby’s painting if it’s been drawn on a piece of paper, or just screenshot and save the painting on the iPad.\nStep 3: Sign & Send – please write your baby’s name, age and painting theme in the title of subscription email so that we can make a footnote on your baby’s work.\n\nThen we’ll carefully select suitable and clear paintings, and use them in our new materials of game levels.\nEvery baby is a genius in designing!\n\nExample for subscription email title:\nDaniel Cooper, 5 years old, a singing bird \n(PS: mobile users can add a picture directly by double-click the email message body.)";
    }
    
    [picker setMessageBody:emailBody isHTML:NO];
    [self presentViewController:picker animated:YES completion:nil];
    

}

-(NSString*)currentLanguage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLang = [languages objectAtIndex:0];
    return currentLang;
}


-(void)gotoStore
{
    [CommonUtility tapSound:@"tapSound" withType:@"wav"];

    if([[self currentLanguage] compare:@"zh-Hans" options:NSCaseInsensitiveSearch]==NSOrderedSame || [[self currentLanguage] compare:@"zh-Hant" options:NSCaseInsensitiveSearch]==NSOrderedSame)
    {
        NSLog(@"current Language == Chinese");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/bao-bei-pin-ba-mian-fei-ban/id936064964?ls=1&mt=8"]];
        
        
    }else{
        NSLog(@"current Language == English");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/bao-bei-pin-ba-mian-fei-ban/id936064964?ls=1&mt=8"]];
        
    }
    
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

- (void)alertWithTitle: (NSString *)_title_ msg: (NSString *)msg

{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_

                                                    message:msg

                                                   delegate:nil
                                          cancelButtonTitle:@"OK"

                                          otherButtonTitles:nil];

    [alert show];
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error

{
    
        NSString *title = @"Mail";
    
        NSString *msg;
    
        switch (result)
    
        {
    
            case MFMailComposeResultCancelled:
    
                msg = @"Mail canceled";//@"邮件发送取消";
    
                break;
    
            case MFMailComposeResultSaved:
    
                msg = @"Mail saved";//@"邮件保存成功";
    
                [self alertWithTitle:title msg:msg];
    
                break;
    
            case MFMailComposeResultSent:
    
                msg = @"Mail sent";//@"邮件发送成功";
    
                [self alertWithTitle:title msg:msg];
    
                break;
    
            case MFMailComposeResultFailed:
    
                msg = @"Mail failed";//@"邮件发送失败";
    
                [self alertWithTitle:title msg:msg];
    
                break;
    
            default:
    
                msg = @"Mail not sent";
    
                [self alertWithTitle:title msg:msg];
    
               break;
    
        }
    
    [self  dismissViewControllerAnimated:YES completion:nil];
    
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
