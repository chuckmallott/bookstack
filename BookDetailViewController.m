//
//  BookDetailViewController.m
//  bookstack
//
//  Created by Shivani Khanna on 4/17/17.
//  Copyright © 2017 sandc. All rights reserved.
//

#import "BookDetailViewController.h"
#import "SCBook.h"
#import "AddToStackViewController.h"
#import <UIKit/UIKit.h>

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController
@synthesize book;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if(!book)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
    if(book.imagelink != nil)
    {
        NSURL *url = [NSURL URLWithString:book.imagelink];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(134, 80, 106.4, 160)];
                            imageView.image = image;
                            [self.view addSubview:imageView];
                        
                        UIGraphicsBeginImageContext(self.view.frame.size);
                        [image drawInRect:self.view.bounds];
                        UIImage *image_background = UIGraphicsGetImageFromCurrentImageContext();
                        self.view.backgroundColor = [UIColor colorWithPatternImage:image_background];
                        UIGraphicsEndImageContext();
                       // self.view.backgroundColor = [UIColor colorWithPatternImage:[self blurredImageWithImage:image_background]];
                    });
        
                }
            }
        }];
        [task resume];
    }
    else {
        self.view.backgroundColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
    }
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.alpha= 20.0f;
    blurEffectView.frame = self.view.bounds;
    [self.view addSubview:blurEffectView];
    
    //UIColor *foregroundColor = [self readableForegroundColorForBackgroundColor:self.view.backgroundColor];
    
    UIColor *foregroundColor = [UIColor whiteColor];
    
    if(book.title != nil && book.title.length > 0)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 255, self.view.frame.size.width-5, 22)];
        label.text = book.title;
        label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        label.font = [UIFont boldSystemFontOfSize:17.0];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    
    if(book.author != nil && book.author.length > 0)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, 280, self.view.frame.size.width - 5, 17)];
        label.text = book.author;
        label.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:.35];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    
    if(book.bookDescription != nil && book.bookDescription.length > 0)
    {
        UITextView *label = [[UITextView alloc]initWithFrame:CGRectMake(40, 310, 295, 303)];
        label.text = book.bookDescription;
        label.editable = NO;
        label.textColor = foregroundColor;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textAlignment = NSTextAlignmentLeft;
        [self.view addSubview:label];
    }
    
    UIImage *imageAdd;
    UIImage *imageMore;
    UIImage *imageShare = [UIImage imageNamed:@"mvp-assets/icon-share-white.png"];
    imageAdd = [UIImage imageNamed:@"mvp-assets/icon-close-white.png"];
    imageMore = [UIImage imageNamed:@"mvp-assets/icon-stack-white.png"];
    UIImageView *imageViewAdd = [[UIImageView alloc] initWithFrame:CGRectMake(20, 36, 14, 14)];
    imageViewAdd.image = imageAdd;
    [self.view addSubview:imageViewAdd];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doneClick)];
    singleTap.numberOfTapsRequired = 1;
    [imageViewAdd setUserInteractionEnabled:YES];
    [imageViewAdd addGestureRecognizer:singleTap];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(328, 40, 24, 19);
    [btn setBackgroundImage:imageMore
                   forState:UIControlStateNormal];
    [btn addTarget:self
            action:@selector(moreClick)
    forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:btn];
    
    UIButton *btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
    btnShare.frame = CGRectMake(290, 36, 16, 21);
    [btnShare setBackgroundImage:imageShare
                   forState:UIControlStateNormal];
    [btnShare addTarget:self
            action:@selector(shareClick)
  forControlEvents:UIControlEventAllEvents];
    [self.view addSubview:btnShare];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 0)];
    view.backgroundColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
    [self.view addSubview:view];
    
    //UIImage *image = [UIImage imageNamed:@"mvp-assets/logo-horiz.png"];
    //UIImageView *imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(132, 29, 111, 24)];
    //imageViewLogo.image = image;
    //[self.view addSubview:imageViewLogo];
    
}

-(void)doneClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)moreClick {
    AddToStackViewController *viewController = [[AddToStackViewController alloc] initWithNibName:@"AddToStackViewController" bundle:nil];
    viewController.book = book;
    [self presentViewController:viewController animated:YES completion:nil];
}

-(void)shareClick {
    NSString *url=@"http://itunes.apple.com/us/app/APPNAME/idXXXXXXXXX";
    NSString * title =[NSString stringWithFormat:@"Download ECG app %@ and get free reward points!",url];
    NSArray* dataToShare = @[title];
    UIActivityViewController* activityViewController =[[UIActivityViewController alloc] initWithActivityItems:dataToShare applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypeAirDrop];
    [self presentViewController:activityViewController animated:YES completion:^{}];
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
