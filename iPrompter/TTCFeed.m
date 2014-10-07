//
//  TTCFeed.m
//  iPrompter
//
//  Created by Alex Parella on 9/27/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCFeed.h"
#import "MWFeedParser.h"

@interface TTCFeed() <MWFeedParserDelegate>

@end

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
        
        [self updateArticles];
    }
    
    return self;
}

- (BOOL) articleAlreadyContained:(MWFeedItem *) feedItem {
    for (MWFeedItem *item in self.articles)
        if (item.link == feedItem.link)
            return YES;
    
    return NO;
}

- (void) updateArticles {
    MWFeedParser *parser = [[MWFeedParser alloc] initWithFeedURL:self.URL];
    parser.delegate = self;
    parser.feedParseType = ParseTypeFull;
    parser.connectionType = ConnectionTypeAsynchronously;
    [parser parse];
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
    [aCoder encodeObject:self.title    forKey:@"feedTitle"];
    [aCoder encodeObject:self.URL      forKey:@"URL"];
    [aCoder encodeObject:self.articles forKey:@"articles"];
}

- (void) feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    int newArticles = 0;
    if (![self articleAlreadyContained:item]) {
        newArticles++;
        [self.articles addObject:item];
    }
    NSLog(@"%@", item.link);
    NSLog(@"%@ updated with %d new articles", self.title, newArticles);
}

@end
