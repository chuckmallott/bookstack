//
//  AddToStackViewController.m
//  bookstack
//
//  Created by Shivani Khanna on 1/15/17.
//  Copyright © 2017 sandc. All rights reserved.
//

#import "AddToStackViewController.h"
#import "ViewController.h"
#import "PlanToReadViewController.h"
#import "FinishedViewController.h"

@interface AddToStackViewController ()

@end

@implementation AddToStackViewController
@synthesize tableView, book;
NSArray *menuTable;
NSArray *imagesTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
    
    UILabel *labelAdd = [[UILabel alloc]initWithFrame:CGRectMake(120, 190, 140, 70)];
    labelAdd.font = [UIFont boldSystemFontOfSize:17.0];
    labelAdd.textColor = [UIColor whiteColor];
    labelAdd.text = @"ADD TO STACK";
    labelAdd.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelAdd];
    
    UIImage *imageAdd = [UIImage imageNamed:@"mvp-assets/icon-close-white.png"];
    UIImageView *imageViewAdd = [[UIImageView alloc] initWithFrame:CGRectMake(20, 36, 14, 14)];
    imageViewAdd.image = imageAdd;
    [self.view addSubview:imageViewAdd];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doneClick)];
    singleTap.numberOfTapsRequired = 1;
    [imageViewAdd setUserInteractionEnabled:YES];
    [imageViewAdd addGestureRecognizer:singleTap];
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(63.0, 244.0, 250.0, 180.0)];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    menuTable = [[NSArray alloc]initWithObjects:@"Reading", @"Planning to Read", @"Finished", nil];
    imagesTable = [[NSArray alloc]initWithObjects:@"mvp-assets/icon-reading-large.png", @"mvp-assets/icon-planning-large.png", @"mvp-assets/icon-finished-large.png", nil];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsZero;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)atableView numberOfRowsInSection:(NSInteger)section {
    return menuTable.count;
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor whiteColor];
        tableView.layer.cornerRadius = 10.0f;
        cell.layer.masksToBounds = true;
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 18, 22, 26)];
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", [imagesTable objectAtIndex:indexPath.row]]];
    [cell.contentView addSubview:imageView];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(50,20,200,20)];
    textLabel.text = [NSString stringWithFormat:@"%@", [menuTable objectAtIndex:indexPath.row]];
    textLabel.font = [UIFont boldSystemFontOfSize:15.0];
    textLabel.textColor = [UIColor blackColor];
    textLabel.textColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
    [cell.contentView addSubview:textLabel];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 60;
    return 0.0f;
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
        if(![self doesBookExist:valueToSave inArray:arrayOfBooks])
        {
            [arrayOfBooks addObject:valueToSave];
        }
    }
    else
    {
        arrayOfBooks = [[NSMutableArray alloc] init];
        if(![self doesBookExist:valueToSave inArray:arrayOfBooks])
        {
            [arrayOfBooks addObject:valueToSave];
        }
    }
   // NSLog(@"in %@, book title is %@", arrayOfBooks, book.title);
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:arrayOfBooks] forKey:userDefault];

}

-(BOOL)doesBookExist:(SCBook*)valueToSave inArray:(NSMutableArray*)arrayOfBooks {
    for(SCBook *object in arrayOfBooks)
    {
        if ([object.title isEqualToString:valueToSave.title] && [object.author isEqualToString:valueToSave.author])
        {
            return true;
        }
    }
    return false;
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


- (void)dismissModalStackAnimated:(bool)animated completion:(void (^)(void))completion {
    UIView *fullscreenSnapshot = [[UIApplication sharedApplication].delegate.window snapshotViewAfterScreenUpdates:false];
    [self.presentedViewController.view insertSubview:fullscreenSnapshot atIndex:NSIntegerMax];
    [self dismissViewControllerAnimated:animated completion:completion];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(!book) return;
    if (indexPath.row == 0)
    {
        [self saveToNSUserDefaults:@"reading" andBook:book];
        [self removeFromNSUserDefaults:@"planToRead" andBook:book];
        [self removeFromNSUserDefaults:@"finishedReading" andBook:book];
    }
    else if(indexPath.row == 1)
    {
        [self saveToNSUserDefaults:@"planToRead" andBook:book];
        [self removeFromNSUserDefaults:@"reading" andBook:book];
        [self removeFromNSUserDefaults:@"finishedReading" andBook:book];
    }
    else
    {
        [self saveToNSUserDefaults:@"finishedReading" andBook:book];
        [self removeFromNSUserDefaults:@"reading" andBook:book];
        [self removeFromNSUserDefaults:@"planToRead" andBook:book];
    }
    UIViewController *vc = self.presentingViewController;
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:NULL];
}

-(void)doneClick {
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
