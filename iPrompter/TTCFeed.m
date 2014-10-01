//
//  TTCFeed.m
//  iPrompter
//
//  Created by Alex Parella on 9/27/14.
//  Copyright (c) 2014 Tree Traversal Collective. All rights reserved.
//

#import "TTCFeed.h"

@implementation TTCFeed

// Designated initializer
- (instancetype) initWithTitle:(NSString *) title withURL:(NSString *) URL {
    self = [super init];
    if (self) {
        self.title = title;
        self.URL = [NSURL URLWithString:URL];
    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _title = [aDecoder decodeObjectForKey:@"feedTitle"];
        _URL = [aDecoder decodeObjectForKey:@"URL"];
    }
    
    return self;
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
}

@end
