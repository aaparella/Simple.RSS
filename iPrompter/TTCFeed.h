//
//  TTCFeed.h
//  iPrompter
//
//  Created by Alex Parella on 9/27/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTCFeed;

@protocol TTCFeedDelegate

- (void) feed:(TTCFeed *)feed updateFailedWithError:(NSError *) error;
- (void) feed:(TTCFeed *)feed updatedWithNewArticles:(NSInteger) newArticles;

@end

@interface TTCFeed : NSObject <NSCoding>
{
    NSUInteger unreadArticles;
}

@property (nonatomic, weak) id<TTCFeedDelegate> delegate;
@property (nonatomic, strong) NSURL    *URL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate   *lastFetched;
@property (nonatomic, strong) NSMutableArray *articles;
@property (nonatomic, strong) NSPointerArray *containingCollections;

- (instancetype) initWithTitle:(NSString *)title withURL:(NSString *)URL;

- (NSUInteger) unreadArticles;
- (void) setUnreadArticles:(NSUInteger) unread;

- (void) updateArticles;

@end
