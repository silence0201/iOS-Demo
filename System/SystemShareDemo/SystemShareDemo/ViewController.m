//
//  ViewController.m
//  SystemShareDemo
//
//  Created by 杨晴贺 on 9/13/16.
//  Copyright © 2016 silence. All rights reserved.
//

#import "ViewController.h"
#import "CustomActivity.h"
#import <Twitter/TWTweetComposeViewController.h>
#import <SafariServices/SafariServices.h>
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

@interface ViewController ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic,strong) UIDocumentInteractionController *documentController ;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)documentInteractionControllerClick:(UIButton *)sender {
    NSURL *sourceUrl = [[NSBundle mainBundle]URLForResource:@"Steve" withExtension:@"pdf"] ;
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:sourceUrl] ;
    
    self.documentController.delegate = self ;
    
    // 弹出选项视图
    [self.documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

#pragma mark - UIDocumentInteractionControllerDelegate
// 设置预览的代理
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self ;
}

// UIActivityViewController相比于UIDocumentInteractionController的最大优势就是UIActivityViewController所提供的自定义服务，我们可以通过UIActivity在UIActivityViewController上添加我们自定义的服务。
- (IBAction)activityViewControllerClick:(UIButton *)sender {
    NSURL *sourceUrl = [[NSBundle mainBundle]URLForResource:@"Steve" withExtension:@"pdf"] ;
    UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[sourceUrl] applicationActivities:@[[[CustomActivity alloc] init]]];
    
    // hide AirDrop
    // activity.excludedActivityTypes = @[UIActivityTypeAirDrop] ;
    
    UIPopoverPresentationController *popover = activity.popoverPresentationController;

    if (popover) {
        popover.sourceView = self.button ;
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp ;
    }
    
    
    [self presentViewController:activity animated:YES completion:nil] ;
}

// 复制文字
- (IBAction)copy:(UIButton *)sender {
    UIPasteboard *pastrboard = [UIPasteboard generalPasteboard] ;
    pastrboard.string = @"内容" ;
}

// 发送推文
- (IBAction)twSend:(UIButton *)sender {
    TWTweetComposeViewController *tweetComposeViewController = [[TWTweetComposeViewController alloc]init] ;
    [tweetComposeViewController setInitialText:@"测试文本"] ;
    [tweetComposeViewController addURL:[NSURL URLWithString:@"https://github.com/silence0201"]] ;
    [tweetComposeViewController addImage:[UIImage imageNamed:@"guest"]] ;
    if([TWTweetComposeViewController canSendTweet]){
        [self presentViewController:tweetComposeViewController animated:YES completion:nil] ;
    }
}

// 保存图片
- (IBAction)saveImage:(UIButton *)sender {
    UIImage *image = [UIImage imageNamed:@"guest"] ;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL) ;
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}


- (void)didWriteToSavedPhotosAlbum{
    NSLog(@"保存完成") ;
}

// 添加阅读列表
- (IBAction)addBookMark:(UIButton *)sender {
    NSURL *Url = [NSURL URLWithString:@"https://github.com/silence0201"] ;
    BOOL result = [[SSReadingList defaultReadingList] addReadingListItemWithURL:Url title:@"MyGithub" previewText:@"你好" error:NULL] ;
    if(result){
        NSLog(@"添加书签成功") ;
    }
}

// 发送短信
- (IBAction)sendMessage:(id)sender {
    MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    messageComposeViewController.recipients = @[@"你好"];
    //messageComposeViewController.delegate = self;
    messageComposeViewController.body = @"测试";
    messageComposeViewController.subject = @"测试";
}

// 发送邮件
- (IBAction)sendMail:(id)sender {
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    [mailComposeViewController setToRecipients:@[@"111@qq.com"]];
    [mailComposeViewController setSubject:@"Hello"];
    [mailComposeViewController setMessageBody:@"测试"
                                       isHTML:NO];
    if([MFMailComposeViewController  canSendMail]){
        [self presentViewController:mailComposeViewController animated:YES completion:nil];
    };
}

// 系统自带的分享
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[SLComposeViewController isAvailableForServiceType: @"com.tencent.xin.sharetimeline"];微信
    
    //判断平台是否可用(系统没有集成,用户设置新浪账号)
    if (![SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        NSLog(@"到设置界面去设置自己的新浪账号");
        return;
    }
    
    // 创建分享控制器
    SLComposeViewController *composeVc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
    
    // 添加分享的文字
    [composeVc setInitialText:@"测试"];
    
    // 添加分享的图片
    [composeVc addImage:[UIImage imageNamed:@"guest"]];
    
    // 添加分享的URL
    [composeVc addURL:[NSURL URLWithString:@"https://github.com/silence0201"]];
    
    // 弹出控制器进行分享
    [self presentViewController:composeVc animated:YES completion:nil];
    
    // 设置监听发送结果
    composeVc.completionHandler = ^(SLComposeViewControllerResult reulst) {
        if (reulst == SLComposeViewControllerResultDone) {
            NSLog(@"用户发送成功");
        } else {
            NSLog(@"用户发送失败");
        }
    };
}

@end
