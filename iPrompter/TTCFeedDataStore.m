//
//  TTCDataStore.m
//  iPrompter
//
//  Created by Alex Parella on 9/24/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCFeedDataStore.h"
#import "TTCFeed.h"
#import "TTCFeedCollection.h"

@implementation TTCFeedDataStore

// Ensure that only ever one data store object exists
+ (instancetype) sharedStore {
    static TTCFeedDataStore* dataStore = nil;
    
    if (!dataStore)
        dataStore = [[TTCFeedDataStore alloc] initPrivate];
    
    return dataStore;
}

- (instancetype) initPrivate {
    
    self = [super init];
    if (self) {
        // Test data only, not going to be there in the end
        self.sectionHeaders = [[NSMutableArray alloc] initWithArray:@[@"Sources", @"Collections"]];
        self.sources        = [[NSMutableArray alloc] init];
        
        [self.sources addObject:[[TTCFeed alloc] initWithTitle:@"Lifehacker" withURL:@"http://lifehacker.com"]];
        [self.sources addObject:[[TTCFeed alloc] initWithTitle:@"Daring Fireball" withURL:@"http://daringfireball.net"]];
        [self.sources addObject:[[TTCFeed alloc] initWithTitle:@"The Verge" withURL:@"http://theverge.com"]];
        
        self.collections = [[NSMutableArray alloc] init];
        [self.collections addObject:[[TTCFeedCollection alloc] initWithTitle:@"Technology" withFeeds:@[]]];
        [self.collections addObject:[[TTCFeedCollection alloc] initWithTitle:@"Design" withFeeds:@[]]];
    }
    
    return self;
}

// Simple accessors

- (TTCFeed *) feedForIndex:(NSUInteger) index {
    return self.sources[index];
}

- (TTCFeedCollection *) collectionForIndex:(NSUInteger) index {
    return self.collections[index];
}

// Manipulating / adding sources and collections

- (void) deleteFeedAtIndex:(NSUInteger) index {
    for (TTCFeedCollection* collection in self.collections)
        [collection removeSource:self.sources[index]];
    
    [self.sources removeObjectAtIndex:index];
}

- (void) deleteCollectionAtIndex:(NSUInteger) index {
    [self.collections removeObjectAtIndex:index];
}

- (void) moveFeedAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) return;
    
    TTCFeed* movedFeed = self.sources[fromIndex];
    [self.sources removeObject:movedFeed];
    [self.sources insertObject:movedFeed atIndex:toIndex];
    
    NSLog(@"Sources : %@\n", self.sources);
}

- (void) moveCollectionAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) return;

    TTCFeedCollection* movedCollection = self.collections[fromIndex];
    [self.collections removeObject:movedCollection];
    [self.collections insertObject:movedCollection atIndex:toIndex];
    NSLog(@"Collections : %@\n", self.collections);
}

- (void) addSource:(NSString *) source withURL:(NSString *) URL {
    [self.sources addObject:[[TTCFeed alloc] initWithTitle:source withURL:URL]];
    NSLog(@"%@\n", self.sources);
}

- (void) addCollection:(NSString *)collection withFeeds:(NSArray *) feeds {
    [self.collections addObject:[[TTCFeedCollection alloc] initWithTitle:collection withFeeds:feeds]];
}

// Information functions

- (NSUInteger) numberOfCollections {
    return (int) [self.collections count];
}

- (NSUInteger) numberOfSources {
    return (int) [self.sources count];
}

- (NSUInteger) numberOfArticles {
    NSUInteger total = 0;
    for (TTCFeed* feed in self.sources)
        total += [feed.articles count];
    return total;
}

- (NSUInteger) numberOfUnreadArticles {
    NSUInteger total = 0;
    for (TTCFeed* feed in self.sources)
        total += [feed unreadArticles];
    return total;
}

@end
