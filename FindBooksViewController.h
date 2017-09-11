//
//  FindBooksViewController.h
//  bookstack
//
//  Created by Shivani Khanna on 1/1/17.
//  Copyright © 2017 sandc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindBooksViewController : UIViewController<NSURLSessionDelegate, NSURLSessionDownloadDelegate,UISearchBarDelegate, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UISearchBar *searchBar;
    UITableView *tableView;
}
@end
