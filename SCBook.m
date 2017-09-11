//
//  SCBook.m
//  bookstack
//
//  Created by Shivani Khanna on 1/4/17.
//  Copyright © 2017 sandc. All rights reserved.
//

#import "SCBook.h"

@implementation SCBook

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.author forKey:@"author"];
    [coder encodeObject:self.imagelink forKey:@"imagelink"];
    [coder encodeObject:self.bookDescription forKey:@"bookDescription"];
}

- (id) initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.title = [coder decodeObjectForKey:@"title"];
        self.author = [coder decodeObjectForKey:@"author"];
        self.imagelink = [coder decodeObjectForKey:@"imagelink"];
        self.bookDescription = [coder decodeObjectForKey:@"bookDescription"];
    }
    return self;
}

@end


