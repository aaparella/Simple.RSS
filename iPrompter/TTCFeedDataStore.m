//
//  TTCDataStore.m
//  iPrompter
//
//  Created by Alex Parella on 9/24/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCFeedDataStore.h"

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
        self.sectionHeaders = [[NSMutableArray alloc] initWithArray:@[@"Sources", @"Collections"]];
        self.sources        = [[NSMutableArray alloc] initWithArray:@[@"The Verge", @"LifeHacker", @"Daring Fireball"]];
        self.collectionTitles = [[NSMutableArray alloc] initWithArray:@[@"Tech", @"Design"]];
        self.collections      = [[NSMutableDictionary alloc] initWithObjects:@[@"", @""] forKeys:@[@"Tech", @"Design"]];
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
    return (index == 0) ? (int)[self.sources count] : (int)[self.collectionTitles count];
}

- (NSString *) sourceForIndexPath: (NSIndexPath*) index {
    if (index.section == 0)
        return self.sources[index.item];
    else
        return self.collectionTitles[index.item];
}

- (void) deleteObjectAtIndexpath:(NSIndexPath *)indexPath {
    // Removing source
    if (indexPath.section == 0) {
        for (NSMutableArray* collection in self.collections)
            [collection removeObject:self.sources[indexPath.item]];
        [self.sources removeObjectAtIndex:indexPath.item];
    } else {
        // Remove both collection and entry in collection titles
        [self.collections removeObjectsForKeys:@[self.collectionTitles[indexPath.item]]];
        [self.collectionTitles removeObjectAtIndex:indexPath.item];
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
        id movedItem = self.collectionTitles[fromPath.item];
        [self.collectionTitles removeObject:movedItem];
        [self.collectionTitles insertObject:movedItem atIndex:toPath.item];
    }
}

- (void) addSource:(NSString *) source {
    [self.sources addObject:source];
}

- (void) addCollection:(NSString *) collection {
    [self.collectionTitles addObject:collection];
    [self.collections addEntriesFromDictionary:@{collection : @""}];
}

- (NSUInteger) numberOfCollections {
    return (int) [self.collectionTitles count];
}

- (NSUInteger) numberOfSources {
    return (int) [self.sources count];
}

@end
