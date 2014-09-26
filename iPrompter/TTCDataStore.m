//
//  TTCDataStore.m
//  iPrompter
//
//  Created by Alex Parella on 9/24/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCDataStore.h"

@implementation TTCDataStore

// Ensure that only ever one data store object exists
+ (instancetype) sharedStore {
    static TTCDataStore* dataStore = nil;
    
    if (!dataStore)
        dataStore = [[TTCDataStore alloc] initPrivate];
    
    return dataStore;
}

- (instancetype) initPrivate {
    
    self = [super init];
    if (self) {
        self.sectionHeaders = [[NSMutableArray alloc] initWithArray:@[@"Sources", @"Collections"]];
        self.sources = [[NSMutableArray alloc] initWithArray:@[
                                                    [[NSMutableArray alloc] initWithArray:@[@"Lifehacker", @"The Verge", @"Daring Fireball"]],
                                                    [[NSMutableArray alloc] initWithArray:@[@"Tech", @"Lifestyle", @"Design"]]]];
    }
    
    return self;
}

- (NSString *) sectionHeaderForIndex:(NSInteger) index {
    return [self.sectionHeaders objectAtIndex: index];
}


// Use section headers to indicate how many sections we'll have
- (int) sectionCount {
    return (int)[self.sectionHeaders count];
}

- (int) itemsForSectionWithIndexPath:(NSInteger)index {
    return (int)[[self.sources objectAtIndex:index] count];
}

- (NSString *) sourceForIndexPath: (NSIndexPath*) index {
    return [[self.sources objectAtIndex:index.section] objectAtIndex:index.item];
}

- (void) deleteObjectAtIndexpath:(NSIndexPath *)indexPath {
    [[self.sources objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.item];
}

- (void) moveObjectAtIndexPath:(NSIndexPath*) fromPath toIndexPath: (NSIndexPath*) toPath {

    if (toPath == fromPath) return;
    
    NSString* movedItem = [[self.sources objectAtIndex:fromPath.section] objectAtIndex:fromPath.item];
    [[self.sources objectAtIndex:fromPath.section] removeObjectAtIndex:fromPath.item];
    [[self.sources objectAtIndex:fromPath.section] insertObject:movedItem atIndex:toPath.item];
}

- (void) addSource:(NSString *) source {
    [[self.sources objectAtIndex:0] addObject:source];
}

- (void) addCollection:(NSString *) collection {
    [[self.sources objectAtIndex:1] addObject:collection];
}

- (NSUInteger) numberOfCollections {
    return [[self.sources objectAtIndex:1] count];
}

- (NSUInteger) numberOfSources {
    return [[self.sources objectAtIndex:0] count];
}

@end
