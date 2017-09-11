//
//  AddToStackViewController.h
//  bookstack
//
//  Created by Shivani Khanna on 1/15/17.
//  Copyright © 2017 sandc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCBook.h"

@interface AddToStackViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) SCBook *book;
@end
