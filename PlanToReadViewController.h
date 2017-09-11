//
//  PlanToReadViewController.h
//  bookstack
//
//  Created by Shivani Khanna on 12/30/16.
//  Copyright © 2016 sandc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlanToReadViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end
