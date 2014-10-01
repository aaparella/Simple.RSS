//
//  TTCFeedCollection.h
//  iPrompter
//
//  Created by Alex Parella on 9/28/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTCFeed;

@interface TTCFeedCollection : NSObject <NSCoding>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSMutableArray *feeds;

- (instancetype) initWithTitle:(NSString *) title withFeeds:(NSArray *) feeds;
- (instancetype) initWithTitle:(NSString *) title;

- (void) removeSource:(TTCFeed *) source;

@end
