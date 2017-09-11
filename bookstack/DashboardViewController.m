//
//  DashboardViewController.m
//  bookstack
//
//  Created by Shivani Khanna on 12/31/16.
//  Copyright © 2016 sandc. All rights reserved.
//

#import "DashboardViewController.h"
#import "AboutViewController.h"

@interface DashboardViewController ()

@end
//10px gap: todo
@implementation DashboardViewController
@synthesize tableView;
NSArray *tableMenu;
NSArray *tableImages;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [tableView removeFromSuperview];
    [self.tabBarController setSelectedIndex:0];
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(15.0, 70, 345.0, 185.0)];
    tableView.layer.cornerRadius = 10.0f;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    tableMenu = [[NSArray alloc]initWithObjects:@"Reading", @"Planning to Read", @"Finished", nil];
    tableImages = [[NSArray alloc]initWithObjects:@"mvp-assets/icon-reading-large.png", @"mvp-assets/icon-planning-large.png", @"mvp-assets/icon-finished-large.png", nil];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsZero;
    
    
    UILabel *titleBlock = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 345, 44)];
    titleBlock.backgroundColor = [UIColor colorWithRed:226/255.0 green:231/255.0 blue:234/255.0 alpha:1.0];
    titleBlock.layer.cornerRadius = 10.0f;
    [titleBlock setClipsToBounds:YES];
    [self.view addSubview:titleBlock];
    
    UILabel *titleBlockText = [[UILabel alloc]initWithFrame:CGRectMake(60, 15, 345, 44)];
    titleBlockText.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightBold];
    titleBlockText.textColor = [UIColor blackColor];
    titleBlockText.textColor = [UIColor colorWithRed:105/255.0 green:119/255.0 blue:127/255.0 alpha:1.0];
    titleBlockText.text = @"STACKS";
    titleBlockText.numberOfLines = 0;
    [self.view addSubview:titleBlockText];
    
    UIImage *stackIcon = [UIImage imageNamed:@"mvp-assets/icon-stack-grey.png"];
    UIImageView *imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(28, 28, 24, 19)];
    imageViewLogo.image = stackIcon;
    [self.view addSubview:imageViewLogo];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
}

-(void)infoClick {
    AboutViewController *aboutViewController = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
    [self presentViewController:aboutViewController animated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableMenu.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section!=0)
    {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}



- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 36, 42)];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [tableImages objectAtIndex:indexPath.section]]];
    [cell.contentView addSubview:imageView];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(62,12,200,20)];
    textLabel.text = [NSString stringWithFormat:@"%@", [tableMenu objectAtIndex:indexPath.section]];
    textLabel.font = [UIFont boldSystemFontOfSize:17.0];
    textLabel.textColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
    [cell.contentView addSubview:textLabel];
    
    UILabel *detailedLabel = [[UILabel alloc]initWithFrame:CGRectMake(62, 30, 200, 20)];
    long int bookCount = [self getBookCount:indexPath.section];
    if (bookCount == 1)
    {
        detailedLabel.text = [NSString stringWithFormat:@"%lu book", bookCount];
    }
    else {
        detailedLabel.text = [NSString stringWithFormat:@"%lu books", bookCount];
    }
    detailedLabel.textColor = [UIColor blackColor];
    detailedLabel.font = [UIFont systemFontOfSize:15.0];
    detailedLabel.textColor = [UIColor colorWithRed:105/255.0 green:119/255.0 blue:127/255.0 alpha:0.75];
    [cell.contentView addSubview:detailedLabel];
    
    return cell;
}

-(unsigned long)getBookCount:(unsigned long)rowIndex {
    NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
    NSData *dataRepresentingSavedArray;
    switch(rowIndex)
    {
        case 0: dataRepresentingSavedArray = [currentDefaults objectForKey:@"reading"];
            break;
        case 1: dataRepresentingSavedArray = [currentDefaults objectForKey:@"planToRead"];
            break;
        case 2: dataRepresentingSavedArray = [currentDefaults objectForKey:@"finishedReading"];
            break;
        default:
            return 0;
    }
    
    if (dataRepresentingSavedArray != nil)
    {
        NSArray *oldSavedArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataRepresentingSavedArray];
        if (oldSavedArray != nil)
        {
            return oldSavedArray.count;
        }
    }
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
    {
        [self.tabBarController setSelectedIndex:1];
    }
    else if(indexPath.section == 1)
    {
        [self.tabBarController setSelectedIndex:2];
    }
    else
    {
        [self.tabBarController setSelectedIndex:3];
    }
}

@end
