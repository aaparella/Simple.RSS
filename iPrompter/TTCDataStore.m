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
        self.sectionHeaders = [[NSMutableArray alloc] initWithArray:@[@"Accounts", @"Collections"]];
        self.sources = [[NSMutableArray alloc] initWithArray:@[
                                                    [[NSMutableArray alloc] initWithArray:@[@"Feedly", @"Google Reader"]],
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

- (void) moveObjectToIndexPath: (NSIndexPath*) toIndexPath fromIndexPath: (NSIndexPath*) fromIndexPath {
    [[self.sources objectAtIndex:toIndexPath.section] addObject:[[self.sources objectAtIndex:fromIndexPath.section] objectAtIndex:fromIndexPath.item]];
    [[self.sources objectAtIndex:fromIndexPath.section] removeObjectAtIndex:fromIndexPath.item];
}

@end
