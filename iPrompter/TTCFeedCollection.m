//
//  TTCFeedCollection.m
//  iPrompter
//
//  Created by Alex Parella on 9/28/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCFeedCollection.h"
#import "TTCFeed.h"

@implementation TTCFeedCollection

- (instancetype) initWithTitle:(NSString *)title withFeeds:(NSArray *)feeds {
    self = [super init];
    if (self) {
        self.title = title;
        self.feeds = [feeds mutableCopy];
    }
    return self;
}

- (instancetype) initWithTitle:(NSString *) title {
    return [self initWithTitle:title withFeeds:@[]];
}

- (NSUInteger) numberOfFeeds {
    return [self.feeds count];
}

- (void) removeSource:(TTCFeed *) source {
    [self.feeds removeObject:source];
}

@end
