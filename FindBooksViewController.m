//
//  FindBooksViewController.m
//  bookstack
//
//  Created by Shivani Khanna on 1/1/17.
//  Copyright © 2017 sandc. All rights reserved.
//

#import "FindBooksViewController.h"
#import "SCBook.h"
#import "ScannerViewController.h"
#import "AddToStackViewController.h"

@interface FindBooksViewController ()

@end
NSMutableArray *tableData;

@implementation FindBooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0f green:244/255.0f blue:247/255.0f alpha:1.0f];
    
    UILabel *labelSearch = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 50)];
    labelSearch.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:labelSearch];
    
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(60, 74, 265, 25)];
    searchBar.placeholder = @"Title, Author, ISBN";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    UITextField *txfSearchField = [searchBar valueForKey:@"_searchField"];
    txfSearchField.backgroundColor = [UIColor colorWithRed:236/255.0f green:238/255.0f blue:239/255.0f alpha:1.0f];
    [txfSearchField setBorderStyle:UITextBorderStyleNone];
    
    UIButton *btnScan = [[UIButton alloc]initWithFrame:CGRectMake(12.0, 64.0, 40.0, 50.0)];
    [btnScan addTarget:self
                action:@selector(scanClick)
      forControlEvents:UIControlEventTouchUpInside];
    [btnScan setTitle:@"Scan" forState:UIControlStateNormal];
    [btnScan setTitleColor:[UIColor colorWithRed:18/255.0 green:175/255.0 blue:210/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnScan.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:btnScan];
    
    UIButton *btnDone = [[UIButton alloc]initWithFrame:CGRectMake(326, 64.0, 40.0, 50.0)];
    [btnDone addTarget:self
                action:@selector(doneClick)
      forControlEvents:UIControlEventTouchUpInside];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone setTitleColor:[UIColor colorWithRed:18/255.0 green:175/255.0 blue:210/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnDone.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    [self.view addSubview:btnDone];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 60)];
    label.backgroundColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
    [self.view addSubview:label];
    
    UIImage *imageLogo = [UIImage imageNamed:@"mvp-assets/logo-horiz.png"];
    UIImageView *imageViewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(132, 30, 111, 24)];
    imageViewLogo.image = imageLogo;
    [self.view addSubview:imageViewLogo];
    
    tableData = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view from its nib.
   // [self setupMenuBarButtonItems];
    
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSScanner *scanner = [NSScanner scannerWithString:searchText];
    BOOL isNumeric = [scanner scanInteger:NULL] && [scanner isAtEnd];
    NSString *urlString;
    [tableData removeAllObjects];
    if(isNumeric)
    {
        if(searchText.length < 13)return;
        urlString = [@"https://www.googleapis.com/books/v1/volumes?q=isbn:" stringByAppendingString:searchText];
    }
    else
    {
        if(searchText.length < 3) return;
        NSCharacterSet *set = [NSCharacterSet URLHostAllowedCharacterSet];
        NSString *encodedString = [searchText stringByAddingPercentEncodingWithAllowedCharacters:set];
        urlString = [@"https://www.googleapis.com/books/v1/volumes?q=" stringByAppendingString:encodedString];
    }
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url];
    [downloadTask resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    NSError *error;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    {
        NSArray *jArray;
        if(jsonObject != nil)
        {
            if(![[jsonObject objectForKey:@"items"] isEqual:@""])
            {
                jArray=[jsonObject objectForKey:@"items"];
                for(int i =0;i<jArray.count;i++)
                {
                    SCBook *book = [[SCBook alloc]init];
                    book.title = [[jArray[i]objectForKey:@"volumeInfo"]objectForKey:@"title"];
                    book.author = [[jArray[i]objectForKey:@"volumeInfo"]objectForKey:@"authors"][0];
                    book.bookDescription = [[jArray[i]objectForKey:@"volumeInfo"]objectForKey:@"description"];
                    book.imagelink = [[[jArray[i]objectForKey:@"volumeInfo"]objectForKey:@"imageLinks"]objectForKey:@"smallThumbnail"];
                    bool found = false;
                    for (SCBook *b in tableData)
                    {
                        if(b.title != nil && book.title != nil)
                        {
                            if([b.title isEqualToString:book.title])
                            {
                                found = true;
                                break;
                            }
                        }
                    }
                    if(!found)
                    {
                        [tableData addObject:book];
                    }
                }
            }
        }
        
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        if(tableData.count > 0)
        {
            float height = self.view.bounds.size.height;
            tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 130.0, 345.0, height)];
            tableView.delegate = self;
            tableView.dataSource = self;
            [self.view addSubview:tableView];
            tableView.layer.cornerRadius = 10.0f;
            [tableView reloadData];
        }
    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return 80;
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"in did select row");
    AddToStackViewController *viewController = [[AddToStackViewController alloc] initWithNibName:@"AddToStackViewController" bundle:nil];
    viewController.book = [tableData objectAtIndex:indexPath.row];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (UITableViewCell *)tableView:(UITableView *)thistableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    SCBook *book = [tableData objectAtIndex:indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(310, 33, 14, 14)];
        imageView.image = [UIImage imageNamed:@"mvp-assets/icon-plus-orange.png"];
        [cell.contentView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 200, 60)];
        //label.text = [NSString stringWithFormat:@"%@", book.title];
        label.tag = 12;
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:17.0];
        label.textColor = [UIColor colorWithRed:60/255.0 green:70/255.0 blue:75/255.0 alpha:1.0];
        [cell.contentView addSubview:label];
        
        if(book.author != nil && book.author.length > 0)
        {
            UILabel *detailedLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 200, 60)];
            detailedLabel.tag = 13;
           // detailedLabel.text = [NSString stringWithFormat:@"%@", book.author];
            detailedLabel.textColor = [UIColor blackColor];
            detailedLabel.font = [UIFont systemFontOfSize:15.0];
            detailedLabel.textColor = [UIColor colorWithRed:105/255.0 green:119/255.0 blue:127/255.0 alpha:0.75];
            [cell.contentView addSubview:detailedLabel];
        }
    }
    
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
                            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 60)];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scanClick {
    ScannerViewController *scannerViewController = [[ScannerViewController alloc] initWithNibName:@"ScannerViewController" bundle:nil];
    [self presentViewController:scannerViewController animated:YES completion:nil];
}

-(void)doneClick {
    [self dismissViewControllerAnimated:YES completion:nil];
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
