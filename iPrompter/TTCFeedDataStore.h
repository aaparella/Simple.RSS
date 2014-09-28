//
//  TTCDataStore.h
//  iPrompter
//
//  Created by Alex Parella on 9/24/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TTCFeedDataStore : NSObject

@property (nonatomic, strong) NSMutableArray* sectionHeaders;
@property (nonatomic, strong) NSMutableArray* sources;
@property (nonatomic, strong) NSMutableArray* collectionTitles;
@property (nonatomic, strong) NSMutableDictionary* collections;

+ (instancetype) sharedStore;

- (NSString *) sectionHeaderForIndex:(NSInteger) index;
- (int) numberOfItemsForSection:(NSInteger) index;
- (NSString *) sourceForIndexPath: (NSIndexPath*) index;
- (int) sectionCount;

- (void) deleteObjectAtIndexpath: (NSIndexPath *) indexPath;
- (void) moveObjectAtIndexPath: (NSIndexPath*) fromIndexPath
                   toIndexPath: (NSIndexPath*) toIndexPath;

- (void) addSource:(NSString *) source;
- (void) addCollection:(NSString *) collection;

- (NSUInteger) numberOfCollections;
- (NSUInteger) numberOfSources;

@end