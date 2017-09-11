//
//  AppDelegate.m
//  bookstack
//
//  Created by Shivani Khanna on 10/4/16.
//  Copyright © 2016 sandc. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "PlanToReadViewController.h"
#import "FinishedViewController.h"
#import "DashboardViewController.h"
#import "FindBooksViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
UITabBarController *tabBarController;
bool isDashboard = true;

- (ViewController *)demoController {
    return [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
}

- (UINavigationController *)navigationController {
    return [[UINavigationController alloc]
            initWithRootViewController:[self demoController]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    tabBarController = [[UITabBarController alloc] init];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor colorWithRed:240/255.0f green:244/255.0f blue:247/255.0f alpha:1.0f];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:60/255.0f green:70/255.0f blue:75/255.0f alpha:1.0f]];
    [[UINavigationBar appearance] setTranslucent:NO];
    DashboardViewController *dashboardViewController = [[DashboardViewController alloc] initWithNibName:@"DashboardViewController" bundle:nil];
    ViewController *viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    FinishedViewController *finishedViewController = [[FinishedViewController alloc] initWithNibName:@"FinishedViewController" bundle:nil];
    PlanToReadViewController *planToReadViewController = [[PlanToReadViewController alloc] initWithNibName:@"PlanToReadViewController" bundle:nil];
    UINavigationController *navcontroller1=[[UINavigationController alloc] initWithRootViewController:viewController];
    UINavigationController *navcontroller2=[[UINavigationController alloc] initWithRootViewController:finishedViewController];
    UINavigationController *navcontroller3=[[UINavigationController alloc] initWithRootViewController:planToReadViewController];
    UINavigationController *navcontroller4=[[UINavigationController alloc] initWithRootViewController:dashboardViewController];
    
    UIImage *imageReading = [[UIImage imageNamed:@"mvp-assets/icon-reading-small-grey.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.image = imageReading;
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"mvp-assets/icon-reading-small-blue.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    UIImage *imagePlan = [[UIImage imageNamed:@"mvp-assets/icon-planning-small-grey.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    planToReadViewController.tabBarItem.image = imagePlan;
    planToReadViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"mvp-assets/icon-planning-small-blue.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imageFinished = [[UIImage imageNamed:@"mvp-assets/icon-finished-small-grey.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    finishedViewController.tabBarItem.image = imageFinished;
    finishedViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"mvp-assets/icon-finished-small-blue.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imageDashboard = [[UIImage imageNamed:@"mvp-assets/icon-home-small-grey.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    dashboardViewController.tabBarItem.image = imageDashboard;
    dashboardViewController.tabBarItem.selectedImage = [[UIImage imageNamed:@"mvp-assets/icon-home-small-blue.png"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSArray* controllers = [NSArray arrayWithObjects:navcontroller4, navcontroller1, navcontroller3, navcontroller2, nil];
    tabBarController.viewControllers = controllers;
    tabBarController.tabBar.backgroundColor =  [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1.0];
    tabBarController.tabBar.tintColor = [UIColor darkGrayColor];
    [[UITabBar appearance] setTranslucent:NO];
    
    [[tabBarController.tabBar.items objectAtIndex:0]setTitle:@"Dashboard"];
    [[tabBarController.tabBar.items objectAtIndex:1]setTitle:@"Reading"];
    [[tabBarController.tabBar.items objectAtIndex:2]setTitle:@"Plan to Read"];
    [[tabBarController.tabBar.items objectAtIndex:3]setTitle:@"Finished"];
    
    UIImage *imageAdd = [UIImage imageNamed:@"mvp-assets/btn-add.png"];
    UIImageView *imageViewAdd = [[UIImageView alloc] initWithFrame:CGRectMake(166, 588, 44, 44)];
    imageViewAdd.image = imageAdd;
    [tabBarController.view addSubview:imageViewAdd];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [imageViewAdd setUserInteractionEnabled:YES];
    [imageViewAdd addGestureRecognizer:singleTap];
    
    
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)tapDetected{
    FindBooksViewController *findViewController = [[FindBooksViewController alloc] initWithNibName:@"FindBooksViewController" bundle:nil];
    [tabBarController presentViewController:findViewController animated:YES completion:nil];
   // [self.window setRootViewController:findViewController];
   // [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
