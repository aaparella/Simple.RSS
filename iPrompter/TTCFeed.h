//
//  TTCFeed.h
//  iPrompter
//
//  Created by Alex Parella on 9/27/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTCFeed : NSObject <NSCoding>
{
    NSUInteger unreadArticles;
}

@property (nonatomic, strong) NSURL    *URL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate   *lastFetched;
@property (nonatomic, strong) NSMutableArray *articles;

- (instancetype) initWithTitle:(NSString *)title withURL:(NSString *)URL;

- (NSUInteger) unreadArticles;
- (void) setUnreadArticles:(NSUInteger) unread;

- (void) updateArticles;

@end
