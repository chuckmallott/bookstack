//
//  AboutViewController.m
//  bookstack
//
//  Created by Shivani Khanna on 1/13/17.
//  Copyright © 2017 sandc. All rights reserved.
//

#import "AboutViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
    
    UIImage *image = [UIImage imageNamed:@"mvp-assets/logo-horiz.png"];
    UIImageView *imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(132, 30, 111, 24)];
    imageViewLogo.image = image;
    [self.view addSubview:imageViewLogo];
    
    UIImage *imageClose = [UIImage imageNamed:@"mvp-assets/icon-close-grey"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 36, 14, 14);
    [btn setBackgroundImage:imageClose
                   forState:UIControlStateNormal];
    [btn addTarget:self
            action:@selector(doneClick)
  forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:btn];
    
    UIImage *imageWads = [UIImage imageNamed:@"mvp-assets/wadsworth.png"];
    UIImageView *imageViewWads = [[UIImageView alloc] initWithFrame:CGRectMake(138, 90, 100, 79)];
    imageViewWads.image = imageWads;
    [self.view addSubview:imageViewWads];
    
    UILabel *labelBig = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 189.0, 288.0, 20.0)];
    labelBig.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightBold];
    labelBig.textColor = [UIColor whiteColor];
    labelBig.text = @"Thank you for using Bookstack!";
    labelBig.numberOfLines = 0;
    [self.view addSubview:labelBig];
    
    UILabel *labelSmall = [[UILabel alloc]initWithFrame:CGRectMake(50.0, 215.0, 275.0, 200.0)];
    labelSmall.font = [UIFont systemFontOfSize:15.0];
    labelSmall.textColor = [UIColor whiteColor];
    labelSmall.text = @"We believe Bookstack is the easiest and most enjoyable way to organize, track and share the books you read.\n\nIf your experience using Bookstack doesn’t support that claim, we want to know about it. We’re always striving to improve Bookstack and appreciate any feedback you have that can help us make it better.";
    labelSmall.numberOfLines = 0;
    [self.view addSubview:labelSmall];
    
    UIButton *btnFeedback = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFeedback.frame = CGRectMake(50.0, 440.0, 275.0, 40.0);
    btnFeedback.backgroundColor = [UIColor colorWithRed:249/255.0 green:80/255.0 blue:32/255.0 alpha:1.0];
    [btnFeedback setTitle:@"Send Feedback" forState:UIControlStateNormal];
    btnFeedback.titleLabel.textColor = [UIColor whiteColor];
    btnFeedback.layer.cornerRadius = 3.0f;
    btnFeedback.titleLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightBold];
    [btnFeedback addTarget:self
            action:@selector(feedbackClick)
  forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:btnFeedback];
}

-(void)doneClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)feedbackClick {
    if (![MFMailComposeViewController canSendMail]) {
        NSLog(@"can't send mail");
    }
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setSubject:@"My Subject"];
    [controller setMessageBody:@"Hello there." isHTML:NO];
    [controller setToRecipients:@[@"chuckmallott@gmail.com"]];
    if (controller) [self presentViewController:controller animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
