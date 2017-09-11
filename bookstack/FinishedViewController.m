//
//  FinishedViewController.m
//  bookstack
//
//  Created by Shivani Khanna on 12/30/16.
//  Copyright © 2016 sandc. All rights reserved.
//

#import "FinishedViewController.h"
#import "SCBook.h"
#import "BookDetailViewController.h"
#import "MGSwipeButton.h"
#import "MGSwipeTableCell.h"
#import "AboutViewController.h"

@interface FinishedViewController ()

@end
NSMutableArray *finishedList;

@implementation FinishedViewController
@synthesize tableView;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self populateList];
    [tableView reloadData];
}

-(void)populateList {
    [tableView removeFromSuperview];
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:@"finishedReading"];
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
        {
            finishedList = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        }
        else
        {
            finishedList = [[NSMutableArray alloc] init];
        }
    }
    float height = finishedList.count * 80;
    if (height < 80.0f)
    {
        height = height + 80.0f;
    }
    if (height > 500.0f)
    {
        height = 520.0f;
    }
    if(finishedList.count > 0)
    {
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(15.0, 70.0, 345.0, height)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.layer.cornerRadius = 10.0f;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self.view addSubview:tableView];
        
        UIView *removeView  = [self.view viewWithTag:107];
        [removeView removeFromSuperview];
        removeView  = [self.view viewWithTag:108];
        [removeView removeFromSuperview];
        removeView  = [self.view viewWithTag:109];
        [removeView removeFromSuperview];
    }
    else {
        UILabel *labelBig = [[UILabel alloc]initWithFrame:CGRectMake(83.0, 170.0, 209.0, 48.0)];
        labelBig.font = [UIFont systemFontOfSize:20.0];
        labelBig.textColor = [UIColor colorWithRed:105/255.0 green:119/255.0 blue:127/255.0 alpha:1.0];
        labelBig.text = @"This stack is empty.";
        labelBig.textAlignment = NSTextAlignmentCenter;
        labelBig.numberOfLines = 0;
        labelBig.tag = 107;
        [self.view addSubview:labelBig];
        
        UILabel *labelSmall = [[UILabel alloc]initWithFrame:CGRectMake(54.0, 220.0, 268.0, 36.0)];
        labelSmall.font = [UIFont systemFontOfSize:15.0];
        labelSmall.textColor = [UIColor colorWithRed:105/255.0 green:119/255.0 blue:127/255.0 alpha:1.0];
        labelSmall.text = @"Add books you've already read to this stack.";
        labelSmall.textAlignment = NSTextAlignmentCenter;
        labelSmall.numberOfLines = 0;
        labelSmall.tag = 108;
        [self.view addSubview:labelSmall];
        
        UIImage *image = [UIImage imageNamed:@"mvp-assets/icon-finished-large.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(165.0, 280.0, 56.0, 66.0)];
        imageView.image = image;
        imageView.tag = 109;
        [self.view addSubview:imageView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *image = [UIImage imageNamed:@"mvp-assets/logo-horiz.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.navigationItem setTitleView:imageView];
    
    UIButton *btnRight = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnRight setFrame:CGRectMake(0, 0, 24, 24)];
    [btnRight setImage:[UIImage imageNamed:@"mvp-assets/icon-about.png"] forState:UIControlStateNormal];
    [btnRight addTarget:self action:@selector(infoClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnRight = [[UIBarButtonItem alloc] initWithCustomView:btnRight];
    [barBtnRight setTintColor:[UIColor whiteColor]];
    //[[[self tabBarController] navigationItem] setRightBarButtonItem:barBtnRight];
    [self.navigationItem setRightBarButtonItem:barBtnRight];

    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:244/255.0 blue:247/255.0 alpha:1.0];
    
    UILabel *titleBlock = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 345, 44)];
    titleBlock.backgroundColor = [UIColor colorWithRed:226/255.0 green:231/255.0 blue:234/255.0 alpha:1.0];
    titleBlock.layer.cornerRadius = 10.0f;
    [titleBlock setClipsToBounds:YES];
    [self.view addSubview:titleBlock];
    
    UILabel *titleBlockText = [[UILabel alloc]initWithFrame:CGRectMake(54, 15, 345, 44)];
    titleBlockText.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightBold];
    titleBlockText.textColor = [UIColor blackColor];
    titleBlockText.textColor = [UIColor colorWithRed:105/255.0 green:119/255.0 blue:127/255.0 alpha:1.0];
    titleBlockText.text = @"FINISHED READING";
    titleBlockText.numberOfLines = 0;
    [self.view addSubview:titleBlockText];
    
    UIImage *stackIcon = [UIImage imageNamed:@"mvp-assets/icon-finished-small-grey.png"];
    UIImageView *imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(27, 26, 18, 21)];
    imageViewLogo.image = stackIcon;
    [self.view addSubview:imageViewLogo];
    
   // [self populateList];
}

-(void)infoClick {
    AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    [self presentViewController:aboutViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return finishedList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BookDetailViewController *viewController = [[BookDetailViewController alloc] initWithNibName:@"BookDetailViewController" bundle:nil];
    viewController.book = [finishedList objectAtIndex:indexPath.row];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 80;
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)thistableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SCBook *book = [finishedList objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.separatorInset = UIEdgeInsetsZero;
        cell.layoutMargins = UIEdgeInsetsZero;
        cell.preservesSuperviewLayoutMargins = NO;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 200, 60)];
        
        UIView *separatorLine = [[UIView alloc] initWithFrame:
                                 CGRectMake(0, 79.0f,
                                            cell.frame.size.width, 5)];
        separatorLine.backgroundColor = [UIColor colorWithRed:240/255.0 green:244/255.0 blue:247/255.0 alpha:1.0];
        [cell.contentView addSubview: separatorLine];
        
        //label.text = [NSString stringWithFormat:@"%@", book.title];
        label.tag = 12;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:17.0];
        label.textColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
        [cell.contentView addSubview:label];
        
        if(book.author != nil && book.author.length > 0)
        {
            UILabel *detailedLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 200, 60)];
            detailedLabel.tag = 13;
            // detailedLabel.text = [NSString stringWithFormat:@"%@", book.author];
            detailedLabel.textColor = [UIColor blackColor];
            detailedLabel.font = [UIFont systemFontOfSize:15.0];
            detailedLabel.textColor = [UIColor colorWithRed:105/255.0 green:119/255.0 blue:127/255.0 alpha:0.75];
            [cell.contentView addSubview:detailedLabel];
        }
    }
    
    cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"Delete" icon:[UIImage imageNamed:@"listbuttons/list-btn-trash.png"] backgroundColor:[UIColor clearColor] padding:0 callback:^BOOL(MGSwipeTableCell *sender) {
        [finishedList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self removeFromNSUserDefaults:@"finishedReading" andBook:book];
        [self populateList];
        [tableView reloadData];
        [self animateResultsLabel:0];
        return YES;
    }]];
    cell.leftSwipeSettings.transition = MGSwipeTransitionStatic;
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"listbuttons/list-btn-plantoread.png"]backgroundColor:[UIColor clearColor] padding:0 callback:^BOOL(MGSwipeTableCell *sender) {
        [finishedList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self removeFromNSUserDefaults:@"finishedReading" andBook:book];
        [self saveToNSUserDefaults:@"planToRead" andBook:book];
        [self populateList];
        [tableView reloadData];
        [self animateResultsLabel:1];
        return YES;
    }], [MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"listbuttons/list-btn-reading.png"] backgroundColor:[UIColor clearColor] padding:0 callback:^BOOL(MGSwipeTableCell *sender) {
        [finishedList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self removeFromNSUserDefaults:@"finishedReading" andBook:book];
        [self saveToNSUserDefaults:@"reading" andBook:book];
        [self populateList];
        [tableView reloadData];
        [self animateResultsLabel:2];
        return YES;
    }]];
    cell.rightSwipeSettings.transition = MGSwipeTransitionStatic;
    
    ((UILabel *)[cell viewWithTag:12]).text = book.title;
    if(book.author != nil && book.author.length > 0)
    {
        ((UILabel *)[cell viewWithTag:13]).text = book.author;
    }
    
    if(book.imagelink != nil)
    {
        NSURL *url = [NSURL URLWithString:book.imagelink];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UITableViewCell *updateCell = [tableView cellForRowAtIndexPath:indexPath];
                        if (updateCell)
                        {
                            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 60)];
                            imageView.image = image;
                            [updateCell.contentView addSubview:imageView];
                        }
                    });
                }
            }
        }];
        [task resume];
    }
    return cell;
}

-(void)animateResultsLabel:(int)userCommand {
    UILabel *backgroundLabel = [[UILabel alloc]initWithFrame:CGRectMake(00.0, 00.0, self.view.frame.size.width, 50.0)];
    backgroundLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:175/255.0 blue:210/255.0 alpha:1.0];
    
    UIImageView *successView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 24, 24)];
    UIImage *successImage = [UIImage imageNamed:@"mvp-assets/icon-check-trans.png"];
    successView.image = successImage;
    
    UILabel *resultsLabel = [[UILabel alloc]initWithFrame:CGRectMake(35.0, 10.0, self.view.frame.size.width, 15.0)];
    resultsLabel.font = [UIFont boldSystemFontOfSize:15.0];
    resultsLabel.textColor = [UIColor whiteColor];
    //resultsLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:175/255.0 blue:210/255.0 alpha:1.0];
    resultsLabel.text = @"   Confirmation";
    
    UILabel *resultsDetailedLabel = [[UILabel alloc]initWithFrame:CGRectMake(35.0, 26.0, self.view.frame.size.width, 13.0)];
    resultsDetailedLabel.font = [UIFont systemFontOfSize:13.0];
    resultsDetailedLabel.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:.5];
    //resultsDetailedLabel.backgroundColor = [UIColor colorWithRed:18/255.0 green:175/255.0 blue:210/255.0 alpha:1.0];
    
    if(userCommand == 0)
    {
        resultsDetailedLabel.text = @"   Book has been removed from library.";
    }
    else
    {
        resultsDetailedLabel.text = @"   Book has been stacked successfully.";
    }
    [self.view addSubview:backgroundLabel];
    [self.view addSubview:resultsLabel];
    [self.view addSubview:resultsDetailedLabel];
    [self.view addSubview:successView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [resultsLabel removeFromSuperview];
        [resultsDetailedLabel removeFromSuperview];
        [backgroundLabel removeFromSuperview];
        [successView removeFromSuperview];
    });
}

-(void) removeFromNSUserDefaults:(NSString*)userDefault andBook:(SCBook*)valueToRemove {
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:userDefault];
    NSMutableArray *arrayOfBooks;
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
        {
            arrayOfBooks = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        }
        else
        {
            arrayOfBooks = [[NSMutableArray alloc] init];
        }
        int i = 0;
        for(SCBook *object in arrayOfBooks)
        {
            if ([object.title isEqualToString:valueToRemove.title])
            {
                [arrayOfBooks removeObjectAtIndex:i];
                break;
            }
            i++;
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:arrayOfBooks] forKey:userDefault];
}

-(void) saveToNSUserDefaults:(NSString*)userDefault andBook:(SCBook*)valueToSave {
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray = [currentDefaults objectForKey:userDefault];
    NSMutableArray *arrayOfBooks;
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
        {
            arrayOfBooks = [[NSMutableArray alloc] initWithArray:oldSavedArray];
        }
        else
        {
            arrayOfBooks = [[NSMutableArray alloc] init];
        }
        [arrayOfBooks addObject:valueToSave];
    }
    else
    {
        arrayOfBooks = [[NSMutableArray alloc] init];
        [arrayOfBooks addObject:valueToSave];
    }
    // NSLog(@"in %@, book title is %@", arrayOfBooks, book.title);
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:arrayOfBooks] forKey:userDefault];
}

@end
