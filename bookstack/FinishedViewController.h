//
//  FinishedViewController.h
//  bookstack
//
//  Created by Shivani Khanna on 12/30/16.
//  Copyright © 2016 sandc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinishedViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end
