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

- (NSString *) sectionHeaderForIndex:(NSInteger) index {
    return [self.sectionHeaders objectAtIndex: index];
}

- (int) sectionCount {
    return (int)[self.sectionHeaders count];
}

- (int) numberOfItemsForSection:(NSInteger)index {
    return (index == 0) ? (int)[self.sources count] : (int)[self.collections count];
}

- (NSString *) sourceForIndexPath: (NSIndexPath*) index {
    return (index.section == 0) ? [self.sources[index.item] title] : [self.collections[index.item] title];
}

- (void) deleteObjectAtIndexpath:(NSIndexPath *)indexPath {
    // Removing source
    if (indexPath.section == 0) {
        // Remove this source from each collection it's in
        for (TTCFeedCollection* collection in self.collections)
            [collection removeSource:self.sources[indexPath.item]];
        
        // Then actually remove the source
        [self.sources removeObjectAtIndex:indexPath.item];
    } else {
        // Remove both collection and entry in collection titles
        [self.collections removeObjectAtIndex:indexPath.item];
    }
}

- (void) moveObjectAtIndexPath:(NSIndexPath*) fromPath toIndexPath: (NSIndexPath*) toPath {
    if (toPath == fromPath) return;
    if (fromPath.section == 0) {
        id movedItem = self.sources[fromPath.item];
        [self.sources removeObject:movedItem];
        [self.sources insertObject:movedItem atIndex:toPath.item];
    }
    else {
        id movedItem = self.collections[fromPath.item];
        [self.collections removeObject:movedItem];
        [self.collections insertObject:movedItem atIndex:toPath.item];
    }
}

- (void) addSource:(NSString *) source withURL:(NSString *) URL {
    [self.sources addObject:[[TTCFeed alloc] initWithTitle:source withURL:URL]];
    NSLog(@"%@\n", self.sources);
}

- (void) addCollection:(NSString *)collection withFeeds:(NSArray *) feeds {
    [self.collections addObject:[[TTCFeedCollection alloc] initWithTitle:collection withFeeds:feeds]];
}

- (NSUInteger) numberOfCollections {
    return (int) [self.collections count];
}

- (NSUInteger) numberOfSources {
    return (int) [self.sources count];
}

@end
