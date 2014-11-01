//
//  TTCFeed.m
//  iPrompter
//
//  Created by Alex Parella on 9/27/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCFeed.h"
#import "TTCFeedCollection.h"
#import "MWFeedParser.h"

@interface TTCFeed() <MWFeedParserDelegate>
{
    int newArticles;
}

@end

@implementation TTCFeed

# pragma mark - initializers

// Designated initializer
- (instancetype) initWithTitle:(NSString *) title withURL:(NSString *) URL {
    self = [super init];
    if (self) {
        self.title = title;
        self.unreadArticles = 0;
        self.URL = [NSURL URLWithString:URL];
        // Hold the collections that i
        self.containingCollections = [NSPointerArray weakObjectsPointerArray];
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

- (BOOL) articleIsNew:(MWFeedItem *) feedItem {
    for (MWFeedItem *item in self.articles)
        if ([item.identifier isEqualToString:feedItem.identifier])
            return NO;
    
    return YES;
}

- (void) addContainingCollection:(TTCFeedCollection *)collection {
    __weak TTCFeedCollection *coll = collection;
    [self.containingCollections addPointer:(__bridge void *)(coll)];
}

- (void) updateArticles {
    MWFeedParser *parser = [[MWFeedParser alloc] initWithFeedURL:self.URL];
    parser.delegate = self;
    parser.feedParseType = ParseTypeFull;
    parser.connectionType = ConnectionTypeSynchronously;
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

# pragma mark - NSCoding

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title    forKey:@"feedTitle"];
    [aCoder encodeObject:self.URL      forKey:@"URL"];
    [aCoder encodeObject:self.articles forKey:@"articles"];
}

# pragma mark - MWFeedParserDelegate

- (void) feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error {
    // Tell our delegate that we failed to update
    [self.delegate feed:self updateFailedWithError:error];
}

- (void) feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item {
    if ([self articleIsNew:item]) {
        NSLog(@"New Article!");
        newArticles++;
        [self.articles addObject:item];
    }
}

- (void) feedParserDidFinish:(MWFeedParser *)parser {
    [self.delegate feed:self updatedWithNewArticles:newArticles];
    newArticles = 0;
    
    for (TTCFeedCollection* coll in self.containingCollections) {
        // Update the contents of each collection
        [coll updateArticlesForFeed:self];
    }
}

@end
