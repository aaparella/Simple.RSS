//
//  TTCDataStore.h
//  iPrompter
//
//  Created by Alex Parella on 9/24/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TTCFeed;
@class TTCFeedCollection;

@interface TTCFeedDataStore : NSObject

@property (nonatomic, strong) NSMutableArray* sectionHeaders;
@property (nonatomic, strong) NSMutableArray* sources;
@property (nonatomic, strong) NSMutableArray* collections;

+ (instancetype) sharedStore;

- (void) deleteFeedAtIndex:(NSUInteger) index;
- (void) deleteCollectionAtIndex:(NSUInteger) index;

- (void) moveFeedAtIndex:(NSUInteger) fromIndex toIndex:(NSUInteger) toIndex;
- (void) moveCollectionAtIndex:(NSUInteger) fromIndex toIndex:(NSUInteger) toIndex;

- (void) addSource:(NSString *) source withURL:(NSString *) URL;
- (void) addCollection:(NSString *) collection withFeeds:(NSArray *) feeds;

- (NSUInteger) numberOfCollections;
- (NSUInteger) numberOfSources;
- (NSUInteger) numberOfArticles;
- (NSUInteger) numberOfUnreadArticles;

- (TTCFeed *) feedForIndex:(NSUInteger) index;
- (TTCFeedCollection *) collectionForIndex:(NSUInteger) index;

@end
