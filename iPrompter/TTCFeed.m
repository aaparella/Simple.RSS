//
//  TTCFeed.m
//  iPrompter
//
//  Created by Alex Parella on 9/27/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCFeed.h"
#import "RSSItem.h"
#import "RSSParser.h"

@implementation TTCFeed

// Designated initializer
- (instancetype) initWithTitle:(NSString *) title withURL:(NSString *) URL {
    self = [super init];
    if (self) {
        self.title = title;
        self.URL = [NSURL URLWithString:URL];
        
        self.articles = [[NSMutableArray alloc] init];
        [self updateArticles];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"feedTitle"];
        _URL = [aDecoder decodeObjectForKey:@"URL"];
        _articles = [aDecoder decodeObjectForKey:@"articles"];
        
        NSLog(@"After decoding %@", _articles);
        [self updateArticles];
    }
    
    return self;
}

- (BOOL) articleAlreadyContained:(RSSItem *) feedItem {
    for (RSSItem *item in self.articles)
        if ([item isEqual:feedItem])
            return YES;
    
    return NO;
}

- (void) updateArticles {
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:self.URL];
    
    [RSSParser parseRSSFeedForRequest:req success:^(NSArray *feedItems) {
        NSUInteger newArticles = 0;
        for (RSSItem *newItem in feedItems) {
            if (![self articleAlreadyContained:newItem]) {
                [self.articles addObject:newItem];
                newArticles++;
            }
        }
        
        NSLog(@"%@ feed updated with %lu new articles", self.title, newArticles);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (void) setUnreadArticles:(NSUInteger)unread {
    unreadArticles = unread;
}

- (NSUInteger) unreadArticles {
    return self.unreadArticles;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@ %@", self.title, self.URL];
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"feedTitle"];
    [aCoder encodeObject:self.URL   forKey:@"URL"];
    [aCoder encodeObject:self.articles forKey:@"articles"];
}

@end
