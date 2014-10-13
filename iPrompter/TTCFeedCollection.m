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

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self)
        self.title = [aDecoder decodeObjectForKey:@"collectionTitle"];
    
    return self;
}

- (NSUInteger) numberOfFeeds {
    return [self.feeds count];
}

- (void) replaceFeed:(TTCFeed *)oldFeed withFeed:(TTCFeed *)newFeed {
    [self.feeds removeObject:oldFeed];
    [self.feeds addObject:newFeed];
}

- (void) insertSource:(TTCFeed *) source {
    [self.feeds addObject:source];
}

- (void) removeSource:(TTCFeed *) source {
    [self.feeds removeObject:source];
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"collectionTitle"];
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@ %@", self.title, self.feeds];
}
@end
