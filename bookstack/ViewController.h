//
//  ViewController.h
//  bookstack
//
//  Created by Shivani Khanna on 10/4/16.
//  Copyright © 2016 sandc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@end

