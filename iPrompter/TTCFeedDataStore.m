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
        self.sources = [NSKeyedUnarchiver unarchiveObjectWithFile:[self feedStorePath]];
        
        if (!self.sources) {
            NSLog(@"Loading new data for sources");
            self.sources = [[NSMutableArray alloc] init];
        }
        
        self.collections = [NSKeyedUnarchiver unarchiveObjectWithFile:[self collectionStorePath]];
        if (!self.collections) {
            NSLog(@"Loading new data for collections");
            self.collections = [[NSMutableArray alloc] init];
        }
    
        self.sectionHeaders = [[NSMutableArray alloc] initWithArray:@[@"Sources", @"Collections"]];
    }
        
    return self;
}

- (BOOL) storeData {
    return ([NSKeyedArchiver archiveRootObject:self.sources toFile:[self feedStorePath]] && \
            [NSKeyedArchiver archiveRootObject:self.collections toFile:[self collectionStorePath]]);
}

// Simple accessors

- (TTCFeed *) feedForIndex:(NSUInteger) index {
    return self.sources[index];
}

- (TTCFeedCollection *) collectionForIndex:(NSUInteger) index {
    return self.collections[index];
}

// Manipulating / adding sources and collections

- (void) replaceFeed:(TTCFeed *)oldFeed withFeed:(TTCFeed *)newFeed {
    [self.sources removeObject:oldFeed];
    [self.sources addObject:newFeed];
    
    for (TTCFeedCollection *collection in self.collections)
        if ([collection.feeds containsObject:oldFeed])
            [collection replaceFeed:oldFeed withFeed:newFeed];
}

- (void) updateFeeds {
    for (TTCFeed *feed in self.sources)
        [feed updateArticles];
}

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
}

- (void) moveCollectionAtIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
    if (fromIndex == toIndex) return;

    TTCFeedCollection* movedCollection = self.collections[fromIndex];
    [self.collections removeObject:movedCollection];
    [self.collections insertObject:movedCollection atIndex:toIndex];
}

- (void) addSource:(NSString *) source withURL:(NSString *) URL {
    [self.sources addObject:[[TTCFeed alloc] initWithTitle:source withURL:URL]];
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

- (NSString *) feedStorePath {
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"feeds.archive"];

}

- (NSString *) collectionStorePath {
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"collections.archive"];
}

@end
