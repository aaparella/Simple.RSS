//
//  TTCFeed.m
//  iPrompter
//
//  Created by Alex Parella on 9/27/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCFeed.h"

@implementation TTCFeed

// Designated initializer
- (instancetype) initWithTitle:(NSString *) title withURL:(NSString *) URL {
    self = [super init];
    if (self) {
        self.title = title;
        self.URL = [NSURL URLWithString:URL];
    }
    return self;
}

- (void) setUnreadArticles:(NSUInteger)unread {
    self.unreadArticles = unread;
}

- (NSUInteger) unreadArticles {
    return self.unreadArticles;
}

@end
