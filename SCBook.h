//
//  SCBook.h
//  bookstack
//
//  Created by Shivani Khanna on 1/4/17.
//  Copyright © 2017 sandc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SCBook : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *imagelink;
@property (nonatomic, strong) NSString *bookDescription;
@end
