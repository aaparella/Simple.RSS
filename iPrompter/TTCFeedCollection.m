//
//  TTCFeedCollection.m
//  iPrompter
//
//  Created by Alex Parella on 9/28/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCFeedCollection.h"
#import "TTCFeed.h"

@interface TTCFeedCollection()

@property (nonatomic, strong) NSMutableArray *articles;

@end

@implementation TTCFeedCollection

- (instancetype) initWithTitle:(NSString *)title withFeeds:(NSArray *)feeds {
    self = [super init];
    if (self) {
        self.title = title;
        self.feeds = [feeds mutableCopy];
        self.articles = [NSMutableArray new];
        
        [self collateArticles];
    }
    return self;
}

- (instancetype) initWithTitle:(NSString *) title {
    return [self initWithTitle:title withFeeds:@[]];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"collectionTitle"];
        self.feeds = [aDecoder decodeObjectForKey:@"feeds"];
    }
    
    return self;
}

- (void) collateArticles {
    for (TTCFeed *feed in self.feeds)
        self.articles = [[self.articles arrayByAddingObjectsFromArray:feed.articles] mutableCopy];
}

- (NSUInteger) numberOfFeeds {
    return [self.feeds count];
}

- (NSUInteger) numberOfArticles {
    return [self.articles count];
}

- (MWFeedItem *) articleForindex:(NSUInteger)index {
    return self.articles[index];
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
    [aCoder encodeObject:self.feeds forKey:@"feeds"];
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@ %@", self.title, self.feeds];
}
@end
